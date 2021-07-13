//=============================================================================
// WeaponPure
//=============================================================================
class WeaponGemSwordFlame extends WeaponGemSword;

function Fire(float Value)
{
	local vector v2;
	
	v2 = Owner.location;
	v2.z += 20;
	if(FRand() < 0.4)
		Spawn(class'GBolt',Pawn(Owner),,v2,Pawn(Owner).ViewRotation);
	super.Fire(value);
}

function name WeaponDamageType()
{
return 'Flamed';
}

defaultproperties
{
    GemClass=Class'GemFlame'
    InventoryGroup=127
    ItemName="Flame Gem Sword"
    ItemArticle="the"
    beltDescription="FLAMEGEM"
    MultiSkins(4)=FireTexture'Effects.Fire.OnFire_J'
    MultiSkins(5)=FireTexture'Effects.Fire.OneFlame_J'
}
