class GemshardAir extends GemShard;

function Sharded()
{
	local pawn paw;
	local vector v2;
	owner.setPhysics(PHYS_Falling);
		Owner.Velocity = vect(0,0,512);
		
		/*foreach Owner.RadiusActors(class'pawn', paw, 300)
			if (paw != None && paw != Owner)
				{
					v2.Z = 60;
					paw.setPhysics(PHYS_Falling);
					paw.Velocity = v2;
				}*/
}

defaultproperties
{
    GemSpawnClass=Class'GemAir'
    ItemName="Air Gem shard"
    beltDescription="AIR GEM"
    Skin=FireTexture'Effects.Electricity.AirTaserFX1'
}
