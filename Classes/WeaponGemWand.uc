//=============================================================================
// WeaponBaton.
//=============================================================================
class WeaponGemWand extends DeusExWeapon;

var() class<DeusExProjectile> gProjectile[4];
/*

*/
enum EStyle
{
	Style_projectile,
	Style_targetted,
	Style_self,
	Style_special
};
var() config EStyle SpellStyle;

enum EElem
{
	Elem_flame,
	Elem_holy,
	Elem_warped,
	Elem_air
};
var() config EElem SpellElement;

function Fire(float Value)
{
	local vector v2;
	local vector loc, line, HitLocation, hitNormal, HitLocation2, hitNormal2;
	local actor hitActor;
	
	v2 = Owner.location;
	v2.z += 20;

	if(SpellStyle==Style_projectile)
	{
		if(SpellElement == Elem_flame)
			if(gProjectile[0] != None)
				Spawn(gProjectile[0],Pawn(Owner),,v2,Pawn(Owner).ViewRotation);
		if(SpellElement == Elem_holy)
			if(gProjectile[1] != None)
				Spawn(gProjectile[1],Pawn(Owner),,v2,Pawn(Owner).ViewRotation);
		if(SpellElement == Elem_warped)
			if(gProjectile[2] != None)
				Spawn(gProjectile[2],Pawn(Owner),,v2,Pawn(Owner).ViewRotation);
		if(SpellElement == Elem_air)
			if(gProjectile[3] != None)
				Spawn(gProjectile[3],Pawn(Owner),,v2,Pawn(Owner).ViewRotation);
	}
	if(SpellStyle==Style_targetted)
	{
		if(SpellElement == Elem_flame) //Explode target
		{
			loc = DeusExPlayer(Owner).Location;
			loc.Z += DeusExPlayer(Owner).BaseEyeHeight;
			line = Vector(DeusExPlayer(Owner).ViewRotation) * 10000;
			HitActor = Trace(hitLocation, hitNormal, loc+line, loc, true);
			Trace(hitLocation2, hitNormal2, loc+line, loc, true);
			if(HitActor != None)
				TargetExplode(HitActor);
			else
				TargetExplodeNull(hitLocation2);
		}
			
		if(SpellElement == Elem_holy) //Heal target
		{
			loc = DeusExPlayer(Owner).Location;
			loc.Z += DeusExPlayer(Owner).BaseEyeHeight;
			line = Vector(DeusExPlayer(Owner).ViewRotation) * 10000;
			HitActor = Trace(hitLocation, hitNormal, loc+line, loc, true);
				if(DeusExPlayer(HitActor) != None)
				{
						DeusExPlayer(HitActor).HealPlayer(50, True);
						DeusExPlayer(HitActor).StopPoison();
						DeusExPlayer(HitActor).ExtinguishFire();
						DeusExPlayer(HitActor).drugEffectTimer = 0;	
				}
		}
		if(SpellElement == Elem_warped)
		{
			loc = DeusExPlayer(Owner).Location;
			loc.Z += DeusExPlayer(Owner).BaseEyeHeight;
			line = Vector(DeusExPlayer(Owner).ViewRotation) * 10000;
			HitActor = Trace(hitLocation, hitNormal, loc+line, loc, true);
			Trace(hitLocation2, hitNormal2, loc+line, loc, true);
			Owner.PlaySound(Sound'Spark1', SLOT_None,,, 256);
				if(HitActor != None)
				{
					DeusExPlayer(Owner).SetCollision(false, false, false);
					DeusExPlayer(Owner).bCollideWorld = true;
					DeusExPlayer(Owner).GotoState('PlayerWalking');
					DeusExPlayer(Owner).SetLocation(HitActor.location);
					DeusExPlayer(Owner).SetCollision(true, true , true);
					DeusExPlayer(Owner).SetPhysics(PHYS_Walking);
					DeusExPlayer(Owner).bCollideWorld = true;
					DeusExPlayer(Owner).GotoState('PlayerWalking');
					DeusExPlayer(Owner).ClientReStart();	
				}
				else
				{
					DeusExPlayer(Owner).SetCollision(false, false, false);
					DeusExPlayer(Owner).bCollideWorld = true;
					DeusExPlayer(Owner).GotoState('PlayerWalking');
					DeusExPlayer(Owner).SetLocation(HitLocation2);
					DeusExPlayer(Owner).SetCollision(true, true , true);
					DeusExPlayer(Owner).SetPhysics(PHYS_Walking);
					DeusExPlayer(Owner).bCollideWorld = true;
					DeusExPlayer(Owner).GotoState('PlayerWalking');
					DeusExPlayer(Owner).ClientReStart();			
				}
		}
		if(SpellElement == Elem_air) //Petrify
		{
			loc = DeusExPlayer(Owner).Location;
			loc.Z += DeusExPlayer(Owner).BaseEyeHeight;
			line = Vector(DeusExPlayer(Owner).ViewRotation) * 10000;
			HitActor = Trace(hitLocation, hitNormal, loc+line, loc, true);	
				if(HitActor == None)
					if(StonedPerson(HitActor).OriginActor != None)
						UnfreezeIt(StonedPerson(HitActor));
						
				if(HitActor != None && stonedPerson(HitActor) == None)
					FreezeIt(HitActor);
		}
	}
	if(SpellStyle==Style_self)
	{
		if(SpellElement == Elem_flame)
			DeusExPlayer(Owner).ClientMessage("It does nothing...");
		if(SpellElement == Elem_holy)
			DeusExPlayer(Owner).ClientMessage("It does nothing...");
		if(SpellElement == Elem_warped)
			DeusExPlayer(Owner).ClientMessage("It does nothing...");
		if(SpellElement == Elem_air)
			DeusExPlayer(Owner).ClientMessage("It does nothing...");
	}			
	if(SpellStyle==style_special)
	{
		if(SpellElement == Elem_flame)
			DeusExPlayer(Owner).ClientMessage("It does nothing...");
		if(SpellElement == Elem_holy)
			DeusExPlayer(Owner).ClientMessage("It does nothing...");
		if(SpellElement == Elem_warped)
			DeusExPlayer(Owner).ClientMessage("It does nothing...");
		if(SpellElement == Elem_air)
			Spawn(class'AirProj',Pawn(Owner),,v2,Pawn(Owner).ViewRotation);

	}
	super.Fire(value);
}

function CycleAmmo()
{
	if(SpellStyle==style_projectile)
	{
		SpellStyle=style_targetted;
		DeusExPlayer(Owner).ClientMessage("Target mode.");
		return;
	}
	if(SpellStyle==style_targetted)
	{
		SpellStyle=style_self;
		DeusExPlayer(Owner).ClientMessage("Self mode.");
		return;
	}
	if(SpellStyle==style_self)
	{
		SpellStyle=style_special;
		DeusExPlayer(Owner).ClientMessage("Special mode.");
		return;
	}
	if(SpellStyle==style_special)
	{
		SpellStyle=style_projectile;
		DeusExPlayer(Owner).ClientMessage("Projectile mode.");
		return;
	}
}

function LaserToggle()
{
	if(SpellElement==Elem_flame)
	{
		SpellElement=Elem_holy;
		DeusExPlayer(Owner).ClientMessage("Holy elemental.");
		return;
	}
	if(SpellElement==Elem_holy)
	{
		SpellElement=Elem_warped;
		DeusExPlayer(Owner).ClientMessage("Warped elemental.");
		return;
	}
	if(SpellElement==Elem_warped)
	{
		SpellElement=Elem_air;
		DeusExPlayer(Owner).ClientMessage("Air elemental.");
		return;
	}
	if(SpellElement==Elem_air)
	{
		SpellElement=Elem_flame;
		DeusExPlayer(Owner).ClientMessage("Flame elemental.");
		return;
	}
}

function ScopeToggle()
{
}

function UnfreezeIt(StonedPerson Other)
{
	local Actor a;
	
	Other.Destroy();
	Spawn(Other.OriginActor.class,,,Other.Location);
}

function FreezeIt(actor other)
{
local Pawn pawn;
local DeusExDecoration deco;
local DeusExCarcass carcass;
local StonedPerson fperson;
local int i;

	pawn = pawn(Other);
	deco = DeusExDecoration(Other);
	carcass = DeusExCarcass(Other);
		
	if(DeusExPlayer(other).Reduceddamagetype == 'All')
		return;
		
	fperson = Spawn(class'StonedPerson',,,Other.Location);
	fperson.SetCollisionSize(Other.CollisionRadius,Other.CollisionHeight);
	fperson.Texture = Other.Texture;
	fperson.Mesh=Other.Mesh;
	fperson.Mass=Other.Mass/2;
	fperson.drawscale=Other.Drawscale;
	fperson.originActor=Other;
	
	for (i=0;i<8;i++)
	{
		if ((Other.MultiSkins[i]==Texture'DeusExItems.Skins.GrayMaskTex')
			|| (Other.MultiSkins[i]==Texture'DeusExItems.Skins.PinkMaskTex')
				|| (Other.MultiSkins[i]==Texture'DeusExItems.Skins.BlackMaskTex'))
		{
			fperson.MultiSkins[i]=Other.MultiSkins[i];
		}
		else
			fperson.MultiSkins[i] = Texture'CoreTexStone.Stone.ClenGrenSlate_A';
	}
	fperson.setRotation(Other.Rotation);
	if(!Other.IsA('DeusExPlayer'))
	{
	Other.Destroy();
	}
	else
	{
		DeusExPlayer(Other).TakeDamage(10000, DeusExPlayer(Owner), other.Location, vect(0,0,0), 'Exploded');
	}
}

function TargetExplode(actor Other)
{
	local SphereEffect sphere;
	local ScorchMark s;
	local ExplosionLight light;
	local int i;
	local float explosionDamage;
	local float explosionRadius;

	explosionDamage = 100;
	explosionRadius = 256;

	// alert NPCs that I'm exploding
	Other.AISendEvent('LoudNoise', EAITYPE_Audio, , explosionRadius*16);
	Other.PlaySound(Sound'LargeExplosion1', SLOT_None,,, explosionRadius*16);

	// draw a pretty explosion
	light = Spawn(class'ExplosionLight',,, Other.Location);
	if (light != None)
		light.size = 4;

	Spawn(class'ExplosionSmall',,, Other.Location + 2*VRand()*Other.CollisionRadius);
	Spawn(class'ExplosionMedium',,, Other.Location + 2*VRand()*Other.CollisionRadius);
	Spawn(class'ExplosionMedium',,, Other.Location + 2*VRand()*Other.CollisionRadius);
	Spawn(class'ExplosionLarge',,, Other.Location + 2*VRand()*Other.CollisionRadius);

	sphere = Spawn(class'SphereEffect',,, Other.Location);
	if (sphere != None)
		sphere.size = explosionRadius / 32.0;

	// spawn a mark
	s = spawn(class'ScorchMark', Other.Base,, Other.Location-vect(0,0,1)*Other.CollisionHeight, Rotation+rot(16384,0,0));
	if (s != None)
	{
		s.DrawScale = FClamp(explosionDamage/30, 0.1, 3.0);
		s.ReattachDecal();
	}

	// spawn some rocks and flesh fragments
	for (i=0; i<explosionDamage/6; i++)
	{
		if (FRand() < 0.3)
			spawn(class'Rockchip',,,Other.Location);
		else
			spawn(class'FleshFragment',,,Other.Location);
	}
	Other.TakeDamage(explosionDamage, deusExPlayer(Owner), other.Location, vect(0,0,0), 'Exploded');
	HurtRadius(explosionDamage, explosionRadius, 'Exploded', explosionDamage*100, Other.Location);
}

function TargetExplodeNull(vector Loc)
{
	local SphereEffect sphere;
	local ScorchMark s;
	local ExplosionLight light;
	local int i;
	local float explosionDamage;
	local float explosionRadius;

	explosionDamage = 100;
	explosionRadius = 256;

	// alert NPCs that I'm exploding
	//Other.AISendEvent('LoudNoise', EAITYPE_Audio, , explosionRadius*16);
	//PlaySound(Sound'LargeExplosion1', SLOT_None,,, explosionRadius*16);

	// draw a pretty explosion
	light = Spawn(class'ExplosionLight',,, Loc);
	if (light != None)
		light.size = 4;

	Spawn(class'ExplosionSmall',,, Loc + 2*VRand()*30);
	Spawn(class'ExplosionMedium',,, Loc + 2*VRand()*30);
	Spawn(class'ExplosionMedium',,, Loc + 2*VRand()*30);
	Spawn(class'ExplosionLarge',,, Loc + 2*VRand()*30);

	sphere = Spawn(class'SphereEffect',,, Loc);
	if (sphere != None)
		sphere.size = explosionRadius / 32.0;


	// spawn some rocks and flesh fragments
	for (i=0; i<explosionDamage/6; i++)
	{
		if (FRand() < 0.3)
			spawn(class'Rockchip',,,Loc);
		else
			spawn(class'FleshFragment',,,Loc);
	}
	
	HurtRadius(explosionDamage, explosionRadius, 'Exploded', explosionDamage*100, Loc);
}

simulated function PlaySelectiveFiring()
{
 local Pawn aPawn;

 if (( Level.NetMode == NM_Standalone ) || ( DeusExPlayer(Owner) == DeusExPlayer(GetPlayerPawn())) )
 {
  PlayAnim('Attack',1.0,0.1);
 }
 else if ( Role == ROLE_Authority )
 {
  for ( aPawn = Level.PawnList; aPawn != None; aPawn = aPawn.nextPawn )
  {
   if ( aPawn.IsA('DeusExPlayer') && ( DeusExPlayer(Owner) != DeusExPlayer(aPawn) ) )
   {
    // If they can't see the weapon, don't bother
    if ( DeusExPlayer(aPawn).FastTrace( DeusExPlayer(aPawn).Location, Location ))
     DeusExPlayer(aPawn).ClientPlayAnimation( Self, 'Attack', 0.1, False );
   }
  }
 }
}

defaultproperties
{
    gProjectile(0)=Class'GBolt'
    gProjectile(1)=Class'GBolt'
    gProjectile(2)=Class'GBolt'
    gProjectile(3)=Class'GBoltAir'
    LowAmmoWaterMark=0
    GoverningSkill=Class'DeusEx.SkillWeaponLowTech'
    NoiseLevel=0.05
    reloadTime=0.00
    HitDamage=7
    maxRange=80
    AccurateRange=80
    BaseAccuracy=1.00
    bPenetrating=False
    bHasMuzzleFlash=False
    bHandToHand=True
    bFallbackWeapon=True
    bEmitWeaponDrawn=False
    AmmoName=Class'DeusEx.AmmoNone'
    ReloadCount=0
    bInstantHit=True
    FireOffset=(X=-24.00,Y=14.00,Z=17.00),
    shakemag=20.00
    FireSound=Sound'DeusExSounds.Weapons.BatonFire'
    SelectSound=Sound'DeusExSounds.Weapons.BatonSelect'
    Misc1Sound=Sound'DeusExSounds.Weapons.BatonHitFlesh'
    Misc2Sound=Sound'DeusExSounds.Weapons.BatonHitHard'
    Misc3Sound=Sound'DeusExSounds.Weapons.BatonHitSoft'
    InventoryGroup=24
    ItemName="Wand"
    PlayerViewOffset=(X=24.00,Y=-14.00,Z=-17.00),
    PlayerViewMesh=LodMesh'DeusExItems.Baton'
    PickupViewMesh=LodMesh'DeusExItems.BatonPickup'
    ThirdPersonMesh=LodMesh'DeusExItems.Baton3rd'
    Icon=Texture'DeusExUI.Icons.BeltIconBaton'
    largeIcon=Texture'DeusExUI.Icons.LargeIconBaton'
    largeIconWidth=46
    largeIconHeight=47
    Description="A hefty looking wand, typically used by riot wizards and gem security forces to discourage gem resistance."
    beltDescription="WAND"
    Mesh=LodMesh'DeusExItems.BatonPickup'
    MultiSkins=Texture'CoreTexWood.Wood.BoatHouseWood_D'
    CollisionRadius=14.00
    CollisionHeight=1.00
}
