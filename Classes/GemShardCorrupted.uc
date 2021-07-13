class GemshardCorrupted extends GemShard;

function Sharded()
{
local pawn paw;
local Gem g;

			foreach Owner.RadiusActors(class'Gem', g, 300)
				if (G != None && g != Self)
					if(g.HitPoints > 50)
						g.HitPoints -= Rand(25);
			foreach Owner.RadiusActors(class'Pawn', paw, 300)
				Baller(Paw);
}

function Baller(pawn  paw)
{
		local Vector HitLocation, HitNormal, StartTrace, EndTrace, X, Y, Z, loc, vline;
	local Rotator rot;
	local Actor hit;
						
	rot = Rotator(paw.location - Owner.location);
				
			if(FRand() < 0.2)
				Spawn(class'GBolt',Owner,, Owner.Location, rot);
			else if(FRand() >= 0.2 && FRand() < 0.4)
				Spawn(class'GBoltAir',Owner,, Owner.Location, rot);
			else if(FRand() >= 0.4 && FRand() < 0.6)
				Spawn(class'GraySpit',Owner,, Owner.Location, rot);
			else if(FRand() >= 0.8 && FRand() < 0.8)
				Spawn(class'GreaselSpit',Owner,, Owner.Location, rot);
			else if(FRand() >= 0.8)
				Spawn(class'FleshBomb', Owner,, Owner.Location, rot);
}
defaultproperties
{
    GemSpawnClass=Class'GemCorrupted'
    ItemName="Corrupted Gem shard"
    beltDescription="CORRUPT GEM"
    Skin=WetTexture'Effects.water.drtywater_a'
}
