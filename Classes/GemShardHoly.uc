class GemshardHoly extends GemShard;

function Sharded()
{
	local DeusExPlayer paw;
local deusexcarcass dec;
local Gem g;
local int temp;

			foreach Owner.VisibleActors(class'DeusExPlayer', paw, 300)
			{
				if (paw != None)
				{
					if(paw.Health < 100 || paw.Drugeffecttimer > 1 || paw.bOnFire)
					{
						Temp = 50;
						paw.HealPlayer(Temp, True);
						paw.StopPoison();
						paw.ExtinguishFire();
						paw.drugEffectTimer = 0;		
					}
					
					if(paw.Energy < 100)
						paw.Energy += 50;
					
				}
			}
			
			foreach Owner.VisibleActors(class'DeusExCarcass', DEC, 300)
				if (dec != None)
					Rezz(dec);

			foreach Owner.VisibleActors(class'Gem', g, 300)
				if (G != None && g != Self)
					if(g.HitPoints < 750)
						g.HitPoints += Rand(30);
}

function Rezz(deusexcarcass carcian)
{
local string tempname, carcassname;
local class<scriptedpawn> newpawn;

	TempName = string(carcian.Class);

	if( InStr(TempName,"Carcass")>=0 )
		CarcassName = Left( TempName, InStr(TempName,"Carcass") );

	Spawn(class<ScriptedPawn>( DynamicLoadObject(CarcassName, class'Class' ) ),,, carcian.Location);	
	carcian.Destroy();
}


defaultproperties
{
    GemSpawnClass=Class'GemHoly'
    ItemName="Holy Gem shard"
    beltDescription="HOLY GEM"
    Skin=Texture'DeusExDeco.Skins.LightbulbTex1'
}
