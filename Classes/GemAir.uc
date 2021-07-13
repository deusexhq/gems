//=============================================
// Healing gem
//=============================================
Class GemAir extends Gem;

function GemEffect()
{
local Pawn paw;
local Gem g;
local float temp, temp2, temp3;
local vector v2;

	if(GemOwner == None)
	{
		foreach VisibleActors(class'Pawn', paw, hitpoints)
		{
			if (paw != None)
			{
				temp = Purity;
				temp = temp * 10;
				temp += 100;
				v2.Z = Temp;
				paw.setPhysics(PHYS_Falling);
				paw.Velocity = v2;
				
			}
		}
	}
	else
	{
		foreach VisibleActors(class'Pawn', paw, hitpoints)
		{
			if (paw != None && paw != gemOwner)
			{
				temp = Purity;
				temp = temp * 10;
				temp += 100;
				v2.Z = Temp;
				paw.setPhysics(PHYS_Falling);
				paw.Velocity = v2;
			}
		}
	}
}

defaultproperties
{
    RingText=FireTexture'Effects.Electricity.AirTaserFX1'
    bRing=True
    GemShardClass=Class'DecoGemShardAir'
    TimerMin=1
    TimerMax=4
    ItemName="Air Gem"
    Skin=FireTexture'Effects.Electricity.AirTaserFX1'
    SoundRadius=15
    AmbientSound=Sound'Ambient.Ambient.StrongWind'
}
