//=============================================
// Evil gem
//=============================================
Class GemCorrupted extends Gem;

function GemEffect()
{
local pawn paw;
local Gem g;

			foreach VisibleActors(class'Gem', g, hitpoints)
				if (G != None && g != Self)
					if(g.HitPoints > 50)
						g.HitPoints -= Rand(5);
			foreach VisibleActors(class'Pawn', paw, hitpoints)
				Baller(Paw);
}

function Baller(pawn  paw)
{
		local Vector HitLocation, HitNormal, StartTrace, EndTrace, X, Y, Z, loc, vline;
	local Rotator rot;
	local Actor hit;
						
	rot = Rotator(paw.location - location);
				
			if(FRand() < 0.2)
				Spawn(class'GBolt',Owner,, Location, rot);
			else if(FRand() >= 0.2 && FRand() < 0.4)
				Spawn(class'GBoltAir',Owner,, Location, rot);
			else if(FRand() >= 0.4 && FRand() < 0.6)
				Spawn(class'GraySpit',Owner,, Location, rot);
			else if(FRand() >= 0.8 && FRand() < 0.8)
				Spawn(class'GreaselSpit',Owner,, Location, rot);
			else if(FRand() >= 0.8 && FRand() < 0.9)
				Spawn(class'FleshBomb',Owner,, Location, rot);
			else if(FRand() >= 0.9)
				GenHorror();
}

function Genhorror()
{
	local ScriptedPawn SP;
	local int c;
	local class<actor> hc;
		foreach AllActors(class'ScriptedPawn',SP)
			if(SP.IsA('HorrorMinion') || SP.IsA('HorrorMinionFemale'))
				c++;
				
	if(C < 4)
	{
		if(FRand() < 0.5){
			hc = class<actor>( DynamicLoadObject( "HorrorMinion", class'Class' ) );
			if (hc != None) Spawn(hc,,, Location);
		}else {
            hc = class<actor>( DynamicLoadObject( "HorrorMinionFemale", class'Class' ) );
            if (hc != None) Spawn(hc,,, Location);
		}

	}
}

defaultproperties
{
    RingText=Texture'Skins.GemDarkBlue'
    bRing=True
    GemShardClass=Class'DecoGemShardCorrupted'
    TimerMin=5
    TimerMax=9
    ItemName="Corrupted Gem"
    Style=sty_modulated
    Skin=Texture'Skins.GemDarkBlue'
}
