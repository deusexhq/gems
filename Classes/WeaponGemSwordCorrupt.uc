//=============================================================================
// WeaponPure
//=============================================================================
class WeaponGemSwordCorrupt extends WeaponGemSword;

function Fire(float Value)
{
	local vector v2;
	
	if(DeusExPlayer(Owner) != None)
		DeusExPlayer(Owner).TakeDamage(2, Pawn(Owner), Owner.Location, vect(0,0,0), 'Radiation');
		
	v2 = Owner.location;
	v2.z += 10;
	if(FRand() < 0.4)
		Spawn(class'GraySpit',Pawn(Owner),,v2,Pawn(Owner).ViewRotation);
	super.Fire(value);
}

defaultproperties
{
    GemClass=Class'GemCorrupted'
    InventoryGroup=127
    ItemName="Corrupted Gem Sword"
    ItemArticle="the"
    beltDescription="CORRUPTGEM"
    MultiSkins(4)=WetTexture'Effects.water.drtywater_a'
    MultiSkins(5)=WetTexture'Effects.water.drtywater_a'
}
