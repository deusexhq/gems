class GemshardFlame extends GemShard;

function Sharded()
{
	local Pawn paw;
	local bool bFound;
	
		foreach Owner.VisibleActors(class'Pawn', paw, 300)
			if (paw != None && paw != Owner)
			{
				bFound=True;
				Baller(Paw);
			}
			
		if(!bFound)
			Spawn(class'GBolt',,, owner.Location, owner.Rotation);
}

function Baller(pawn  paw)
{
		local Vector HitLocation, HitNormal, StartTrace, EndTrace, X, Y, Z, loc, vline;
	local Rotator rot;
	local Actor hit;
						
				rot = Rotator(paw.location - owner.location);
				Spawn(class'GBolt',,, owner.Location, rot);
}

defaultproperties
{
    GemSpawnClass=Class'GemFlame'
    ItemName="Flame Gem shard"
    beltDescription="FLAME GEM"
    Style=2
    Skin=FireTexture'Effects.Fire.OnFire_J'
}
