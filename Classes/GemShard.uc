class Gemshard extends deusexpickup;

var class<Gem> GemSpawnClass;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();
}

state Activated
{
	function Activate()
	{
		// can't turn it off
	}

	function BeginState()
	{
		local Gem G;
		local vector v2;
		Super.BeginState();
		Sharded();
			if(NumCopies == 20)
			{
				v2 = Owner.Location;
				v2.Z += Owner.collisionHeight + 50;
				Spawn(GemSpawnClass,,,v2);
				Numcopies=0;
				Destroy();
			}
		UseOnce();
	}
Begin:
}

function Sharded()
{	
}

function bool UpdateInfo(Object winObject)
{
	local PersonaInfoWindow winInfo;
	local string str;

	winInfo = PersonaInfoWindow(winObject);
	if (winInfo == None)
		return False;

	winInfo.SetTitle(itemName);
	winInfo.SetText(Description $ winInfo.CR() $ winInfo.CR());
	winInfo.AppendText("Shard");

	// Print the number of copies
	str = CountLabel @ String(NumCopies);
	winInfo.AppendText(winInfo.CR() $ winInfo.CR() $ str);

	return True;
}

simulated function bool TestMPBeltSpot(int BeltSpot)
{
   return ( (BeltSpot >= 1) && (BeltSpot <=9) );
}

defaultproperties
{
    GemSpawnClass=Class'Gem'
    maxCopies=20
    bCanHaveMultipleCopies=True
    bActivatable=True
    ItemName="Gem shard"
    PlayerViewOffset=(X=30.00,Y=0.00,Z=-12.00),
    PlayerViewMesh=LodMesh'DeusExDeco.Lightbulb'
    PickupViewMesh=LodMesh'DeusExDeco.Lightbulb'
    ThirdPersonMesh=LodMesh'DeusExDeco.Lightbulb'
    LandSound=Sound'DeusExSounds.Generic.GlassHit1'
    Icon=Texture'DeusExUI.Icons.BeltIconVialAmbrosia'
    Description="A shard of a gem"
    beltDescription="GEM"
    Style=sty_translucent
    Skin=Texture'DeusExItems.Skins.GlassFragmentTex1'
    Mesh=LodMesh'DeusExDeco.Lightbulb'
    CollisionRadius=2.00
    CollisionHeight=2.00
}
