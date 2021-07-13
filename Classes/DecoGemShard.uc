//=============================================
// Master class of the Gems
//=============================================
Class decoGemShard extends DeusExDecoration;

var() class<GemShard> GemShardClass;

function Frob(Actor Frobber, Inventory frobWith) 
{
	local DeusExPlayer SP;
	local int i;
	
	local GemShard GA;	
	local Inventory item, nextItem, startItem;
	local DeusExWeapon W;
	local bool bFoundSomething;
	local DeusExPlayer player;
	local ammo AmmoType;
	local bool bPickedItemUp;
	local POVCorpse corpse;
	local DeusExPickup p;
	local int itemCount;
	local inventory inv;
	SP = DeusExPlayer(Frobber);

				if(GemShardClass != None)
				{
					GA=Spawn(GemShardClass, Self,, Location, Rotation);
					GA.Frob(SP,None);
					GA.Destroy();
					Destroy();
				}
}

defaultproperties
{
    GemShardClass=Class'GemShard'
    HitPoints=100
    bInvincible=True
    FragType=Class'DeusEx.GlassFragment'
    bExplosive=True
    ItemName="Gem Shard"
    bPushable=False
    Style=3
    Skin=Texture'DeusExItems.Skins.GlassFragmentTex1'
    Mesh=LodMesh'DeusExDeco.Lightbulb'
    Fatness=140
    CollisionRadius=2.00
    CollisionHeight=2.00
}
