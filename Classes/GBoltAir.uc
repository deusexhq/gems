//=============================================================================
// PlasmaBolt.
//=============================================================================
class GBoltAir extends DeusExProjectile;

var ParticleGenerator pGen1;
var ParticleGenerator pGen2;

var float mpDamage;
var float mpBlastRadius;

#exec OBJ LOAD FILE=Effects

simulated function DrawExplosionEffects(vector HitLocation, vector HitNormal)
{
	local ParticleGenerator gen;
local pring sphere;

	sphere = Spawn(class'pring',,, HitLocation);
	if (sphere != None)
	{
	sphere.size = blastradius / 32;
	Sphere.MultiSkins[0]=FireTexture'Effects.Electricity.AirTaserFX1';
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
    mpDamage=30.00
    mpBlastRadius=150.00
    bExplodes=True
    blastRadius=128.00
    AccurateRange=14400
    maxRange=24000
    bIgnoresNanoDefense=True
    ItemName="Gem Bolt"
    ItemArticle="a"
    speed=700.00
    MaxSpeed=800.00
    Damage=45.00
    MomentumTransfer=3000
    ImpactSound=Sound'DeusExSounds.Generic.Spark1'
    ExplosionDecal=Class'DeusEx.ScorchMark'
    Style=3
    Skin=FireTexture'Effects.Electricity.AirTaserFX1'
    Mesh=LodMesh'DeusExItems.PlasmaBolt'
    DrawScale=2.00
    Fatness=88
    bUnlit=True
    bFixedRotationDir=True
}
