//=============================================================================
// LAM.
//=============================================================================
class FleshBomb extends ThrownProjectile;

var float	mpBlastRadius;
var float	mpProxRadius;
var float	mpLAMDamage;
var float	mpFuselength;

simulated function Tick(float deltaTime)
{
	local float blinkRate;
		if (FRand() < 0.5)
			Spawn(class'BloodDrop',,, Location);
	Super.Tick(deltaTime);
}

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	if ( Level.NetMode != NM_Standalone )
	{
		blastRadius=mpBlastRadius;
		proxRadius=mpProxRadius;
		Damage=mpLAMDamage;
		fuseLength=mpFuselength;
		bIgnoresNanoDefense=True;
	}
}

simulated function SpawnEffects(Vector HitLocation, Vector HitNormal, Actor Other)
{
	local int i;
	local SmokeTrail puff;
	local TearGas gas;
	local Fragment frag;
	local ParticleGenerator gen;
	local ProjectileGenerator projgen;
	local vector loc;
	local rotator rot;
	local ExplosionLight light;
	local DeusExDecal mark;
   local AnimatedSprite expeffect;

	rot.Pitch = 16384 + FRand() * 16384 - 8192;
	rot.Yaw = FRand() * 65536;
	rot.Roll = 0;

	for (i=0; i<blastRadius/36; i++)
	{
		if (FRand() < 0.9)
		{
			if (bDebris && bStuck)
			{
				frag = spawn(FragmentClass,,, HitLocation);
				if (!bDamaged)
					frag.RemoteRole = ROLE_None;
				if (frag != None)
					frag.CalcVelocity(VRand(), blastRadius);
			}

			loc = Location;
			loc.X += FRand() * blastRadius - blastRadius * 0.5;
			loc.Y += FRand() * blastRadius - blastRadius * 0.5;

			if (damageType == 'Exploded')
			{
				puff = spawn(class'SmokeTrail',,, loc);
				if (puff != None)
				{
					if (!bDamaged)
						puff.RemoteRole = ROLE_None;
					else					
						puff.RemoteRole = ROLE_SimulatedProxy;
					puff.RiseRate = FRand() + 1;
					puff.DrawScale = FRand() + 3.0;
					puff.OrigScale = puff.DrawScale;
					puff.LifeSpan = FRand() * 10 + 10;
					puff.OrigLifeSpan = puff.LifeSpan;
				}

				light = Spawn(class'ExplosionLight',,, HitLocation);
				if ((light != None) && (!bDamaged))
					light.RemoteRole = ROLE_None;

					expeffect = spawn(class'ExplosionSmall',,, loc);
					light.size = 2;


				if ((expeffect != None) && (!bDamaged))
					expeffect.RemoteRole = ROLE_None;
			}
		}
	}
}

defaultproperties
{
    mpBlastRadius=512.00
    mpProxRadius=128.00
    mpLAMDamage=500.00
    mpFuselength=1.50
    fuseLength=2.00
    FragmentClass=Class'DeusEx.FleshFragment'
    proxRadius=128.00
    blastRadius=384.00
    ItemName="Flesh"
    speed=1000.00
    MaxSpeed=1000.00
    Damage=500.00
    MomentumTransfer=50000
    ImpactSound=Sound'DeusExSounds.Generic.FleshHit1'
    MiscSound=Sound'DeusExSounds.Generic.FleshHit2'
    ExplosionDecal=Class'DeusEx.ScorchMark'
    LifeSpan=0.00
    Mesh=LodMesh'DeusExItems.FleshFragment1'
    Mass=5.00
    Buoyancy=2.00
}
