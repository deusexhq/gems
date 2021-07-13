//=============================================================================
// PlasmaBolt.
//=============================================================================
class GBolt extends DeusExProjectile;

var ParticleGenerator pGen1;
var ParticleGenerator pGen2;

var float mpDamage;
var float mpBlastRadius;

#exec OBJ LOAD FILE=Effects

simulated function DrawExplosionEffects(vector HitLocation, vector HitNormal)
{
	local ParticleGenerator gen;
local pring sphere;
	// create a particle generator shooting out plasma spheres
	gen = Spawn(class'ParticleGenerator',,, HitLocation, Rotator(HitNormal));
	if (gen != None)
	{
      //gen.RemoteRole = ROLE_None;
		gen.particleDrawScale = 1.0;
		gen.checkTime = 0.10;
		gen.frequency = 1.0;
		gen.ejectSpeed = 200.0;
		gen.bGravity = True;
		gen.bRandomEject = True;
		gen.particleLifeSpan = 0.75;
		gen.particleTexture = Texture'flmethrwr_fire';
		gen.LifeSpan = 1.3;
	}
	sphere = Spawn(class'pring',,, HitLocation);
	if (sphere != None)
	{
	sphere.size = blastradius / 32;
	Sphere.MultiSkins[0]=Texture'flmethrwr_fire';
	}
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

   if ((Level.NetMode == NM_Standalone) || (Level.NetMode == NM_ListenServer))
      SpawnPlasmaEffects();
}

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	Damage = mpDamage;
	blastRadius = mpBlastRadius;
}

simulated function PostNetBeginPlay()
{
   if (Role < ROLE_Authority)
      SpawnPlasmaEffects();
}

// DEUS_EX AMSD Should not be called as server propagating to clients.
simulated function SpawnPlasmaEffects()
{
	local Rotator rot;
   rot = Rotation;
	rot.Yaw -= 32768;

   pGen2 = Spawn(class'ParticleGenerator', Self,, Location, rot);
	if (pGen2 != None)
	{
    //  pGen2.RemoteRole = ROLE_None;
		pGen2.particleTexture = Texture'flmethrwr_fire';
		pGen2.particleDrawScale = 0.1;
		pGen2.checkTime = 0.04;
		pGen2.riseRate = 0.0;
		pGen2.ejectSpeed = 100.0;
		pGen2.particleLifeSpan = 0.5;
		pGen2.bRandomEject = True;
		pGen2.SetBase(Self);
	}
   
}

simulated function Destroyed()
{
	if (pGen1 != None)
		pGen1.DelayedDestroy();
	if (pGen2 != None)
		pGen2.DelayedDestroy();

	Super.Destroyed();
}

defaultproperties
{
    mpDamage=60.00
    mpBlastRadius=300.00
    bExplodes=True
    blastRadius=128.00
    DamageType=Burned
    AccurateRange=14400
    maxRange=24000
    bIgnoresNanoDefense=True
    ItemName="Gem Bolt"
    ItemArticle="a"
    speed=700.00
    MaxSpeed=800.00
    Damage=90.00
    MomentumTransfer=3000
    ImpactSound=Sound'DeusExSounds.Generic.MediumExplosion1'
    ExplosionDecal=Class'DeusEx.ScorchMark'
    Style=4
    Skin=FireTexture'Effects.Fire.flmethrwr_fire'
    Mesh=LodMesh'DeusExItems.PlasmaBolt'
    DrawScale=2.00
    Fatness=88
    bUnlit=True
    LightType=1
    LightEffect=13
    LightBrightness=200
    LightHue=1
    LightSaturation=128
    LightRadius=3
    bFixedRotationDir=True
}
