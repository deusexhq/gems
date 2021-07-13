//=============================================================================
// WeaponPure
//=============================================================================
class WeaponGemSword extends DeusExWeapon;

var() Gem SpawnedGem;
var() class<Gem> GemClass;
var() bool bHasGem;
var() int Shards;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();

	// If this is a netgame, then override defaults
	if ( Level.NetMode != NM_StandAlone )
	{
		HitDamage = mpHitDamage;
		BaseAccuracy = mpBaseAccuracy;
		ReloadTime = mpReloadTime;
		AccurateRange = mpAccurateRange;
		MaxRange = mpMaxRange;
	}
}

simulated function ProcessTraceHit(Actor Other, Vector HitLocation, Vector HitNormal, Vector X, Vector Y, Vector Z)
{
	local float        mult;
	local name         damageType;
	local DeusExPlayer dxPlayer;
	dxplayer = deusexplayer(other);

	super.ProcessTraceHit(other, hitlocation, hitnormal, x, y, z);
	SwordStrikeEffect();
}

function SwordStrikeEffect()
{
}

function ScopeToggle()
{
}

function LaserToggle()
{
}

function CycleAmmo()
{
}

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

state DownWeapon
{
	function BeginState()
	{
		Super.BeginState();
		LightType = LT_None;
		if(SpawnedGem != None)
		{
			SpawnedGem.bDoomed=True;
			SpawnedGem.Destroy();
			SpawnedGem = None;
		}
	}
}

state Idle
{
	function BeginState()
	{
		local vector v2;
		Super.BeginState();
			if(SpawnedGem == None && bHasGem)
			{
				SpawnedGem = Spawn(GemClass, Owner,, Location,);
				if (SpawnedGem != None)
				{
					v2 = Owner.Location;
					v2.Z += Owner.collisionHeight + 50;
					SpawnedGem.SetLocation(v2);
					SpawnedGem.GemOwner = Pawn(owner);
				}
			}
	}
}

auto state Pickup
{
	function EndState()
	{
		Super.EndState();
	}
}

//Texture messed up on first person
defaultproperties
{
    GemClass=Class'Gem'
    bHasGem=True
    LowAmmoWaterMark=0
    GoverningSkill=Class'DeusEx.SkillWeaponLowTech'
    NoiseLevel=0.05
    reloadTime=0.00
    HitDamage=500
    maxRange=96
    AccurateRange=96
    BaseAccuracy=1.00
    AreaOfEffect=1
    bHasMuzzleFlash=False
    bHandToHand=True
    SwingOffset=(X=24.00,Y=0.00,Z=2.00),
    mpHitDamage=500
    mpBaseAccuracy=1.00
    mpAccurateRange=150
    mpMaxRange=150
    AmmoName=Class'DeusEx.AmmoNone'
    ReloadCount=0
    bInstantHit=True
    FireOffset=(X=-21.00,Y=16.00,Z=27.00),
    shakemag=20.00
    FireSound=Sound'DeusExSounds.Weapons.NanoSwordFire'
    SelectSound=Sound'DeusExSounds.Weapons.NanoSwordSelect'
    Misc1Sound=Sound'DeusExSounds.Weapons.NanoSwordHitFlesh'
    Misc2Sound=Sound'DeusExSounds.Weapons.NanoSwordHitHard'
    Misc3Sound=Sound'DeusExSounds.Weapons.NanoSwordHitSoft'
    InventoryGroup=126
    ItemName="Gem Sword"
    PlayerViewOffset=(X=21.00,Y=-16.00,Z=-27.00),
    PlayerViewMesh=LodMesh'DeusExItems.NanoSword'
    PickupViewMesh=LodMesh'DeusExItems.NanoSwordPickup'
    ThirdPersonMesh=LodMesh'DeusExItems.NanoSword3rd'
    LandSound=Sound'DeusExSounds.Generic.DropLargeWeapon'
    Icon=Texture'DeusExUI.Icons.BeltIconDragonTooth'
    largeIcon=Texture'DeusExUI.Icons.LargeIconDragonTooth'
    largeIconWidth=205
    largeIconHeight=46
    invSlotsX=4
    Description="Gemz."
    beltDescription="GEM"
    Mesh=LodMesh'DeusExItems.NanoSwordPickup'
    MultiSkins(1)=Texture'DeusExItems.Skins.PinkMaskTex'
    MultiSkins(4)=Texture'DeusExItems.Skins.GlassFragmentTex1'
    MultiSkins(5)=Texture'DeusExItems.Skins.GlassFragmentTex1'
    MultiSkins(6)=Texture'DeusExItems.Skins.PinkMaskTex'
    CollisionRadius=32.00
    CollisionHeight=2.40
    Mass=20.00
    RotationRate=(Pitch=900,Yaw=900,Roll=900),
}
