//=============================================
// Healing gem
//=============================================
Class GemHoly extends Gem;

function GemEffect()
{
local DeusExPlayer paw;
local deusexcarcass dec;
local Gem g;
	if(GemOwner == None)
	{
		//temp = Purity
			foreach VisibleActors(class'DeusExPlayer', paw, hitpoints)
			{
				if (paw != None)
				{
					if(paw.Health < 100 || paw.Drugeffecttimer > 1 || paw.bOnFire)
					{
						paw.HealPlayer(Purity / 3, True);
						paw.StopPoison();
						paw.ExtinguishFire();
						paw.drugEffectTimer = 0;		
					}
					
					if(paw.Energy < 100)
						paw.Energy += Purity / 3;
					
				}
			}
			
			foreach VisibleActors(class'DeusExCarcass', DEC, hitpoints)
				if (dec != None)
					Rezz(dec);

			foreach VisibleActors(class'Gem', g, hitpoints)
				if (G != None && g != Self)
					if(g.HitPoints < 750)
						g.HitPoints += Rand(3);
	}
	else
	{
			foreach VisibleActors(class'DeusExPlayer', paw, hitpoints)
			{
				if (paw != None && paw != gemOwner)
				{
					if(paw.Health < 100 || paw.Drugeffecttimer > 1 || paw.bOnFire)
					{
						paw.HealPlayer(Purity / 10, True);
						paw.StopPoison();
						paw.ExtinguishFire();
						paw.drugEffectTimer = 0;
					}
					if(paw.Energy < 100)
					{
						paw.Energy += Purity / 10;
					}
				}
			}
		if(DeusExPlayer(GemOwner) != None && (DeusExPlayer(GemOwner).Health < 100 || DeusExPlayer(GemOwner).Drugeffecttimer > 1 || DeusExPlayer(GemOwner).bOnFire))
		{
			DeusExPlayer(GemOwner).HealPlayer(Purity / 2, True);
		}
		if(DeusExPlayer(GemOwner) != None && DeusExPlayer(GemOwner).Energy < 100)
		{
			DeusExPlayer(GemOwner).Energy += Purity / 5;
		}
	}
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

function DestroyEffect()
{
	local DeusExPlayer paw;
	foreach AllActors(class'DeusExPlayer', paw)
	{
		if(paw.Health < 100 || paw.Drugeffecttimer > 1 || paw.bOnFire)
		{
			paw.HealPlayer(Purity / 10, True);
			paw.StopPoison();
			paw.ExtinguishFire();
			paw.drugEffectTimer = 0;
		}
		
	}
	
}

defaultproperties
{
    RingText=Texture'DeusExDeco.Skins.LightbulbTex1'
    bRing=True
    GemShardClass=Class'DecoGemShardHoly'
    TimerMin=3
    TimerMax=8
    ItemName="Holy Gem"
    Skin=Texture'Skins.GemBlue'
}
