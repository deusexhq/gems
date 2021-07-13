class GemshardWarped extends GemShard;

function Sharded()
{
	local Pawn paw;
local GemWarped CT, Locked;
local int c, n;
	foreach AllActors(class'GemWarped',CT)
		c++;
	
	n=1;
	n+Rand(c);
	foreach AllActors(class'GemWarped',CT)
			Locked = CT;
		PlaySound(Sound'Spark1', SLOT_None,,, 256);	
	foreach Owner.VisibleActors(class'Pawn', paw, 250)
	{
		if(!paw.isinState('Spectating') && paw.Health >= 1)
		{
		paw.SetCollision(false, false, false);
		paw.bCollideWorld = true;
		paw.GotoState('PlayerWalking');
		paw.SetLocation(Locked.location);
		paw.SetCollision(true, true , true);
		paw.SetPhysics(PHYS_Walking);
		paw.bCollideWorld = true;
		paw.GotoState('PlayerWalking');
		DeusExPlayer(paw).ClientReStart();	
		paw.PlaySound(Sound'Spark1', SLOT_None,,, 256);
		}
	}
	Locked.SetTimer(6,False);
	Locked.PlaySound(Sound'Spark1', SLOT_None,,, 256);
}

defaultproperties
{
    GemSpawnClass=Class'GemWarped'
    ItemName="Warped Gem shard"
    beltDescription="WARP GEM"
    Style=sty_translucent
    Skin=WetTexture'Effects.Electricity.Xplsn_EMPG'
}
