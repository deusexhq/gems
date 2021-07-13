//=============================================================================
// WeaponPure
//=============================================================================
class WeaponGemSwordAir extends WeaponGemSword;

function Fire(float Value)
{
	local vector v2;
	
	v2 = Owner.location;
	v2.z += 20;
	if(FRand() < 0.4)
		Spawn(class'GBoltAir',Pawn(Owner),,v2,Pawn(Owner).ViewRotation);
	super.Fire(value);
}

defaultproperties
{
    GemClass=Class'GemAir'
    InventoryGroup=127
    ItemName="Air Gem Sword"
    ItemArticle="the"
    beltDescription="AIRGEM"
    MultiSkins(4)=FireTexture'Effects.Electricity.AirTaserFX1'
    MultiSkins(5)=FireTexture'Effects.Electricity.AirTaserFX1'
}
