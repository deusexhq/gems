//=============================================
// Healing gem
//=============================================
Class GemFlame extends Gem;

function GemEffect()
{
local Pawn paw;

	if(GemOwner == None)
	{
		foreach VisibleActors(class'Pawn', paw, hitpoints)
			Baller(Paw);
	}
	else
	{
		foreach VisibleActors(class'Pawn', paw, hitpoints)
			if (paw != None && GemOwner != paw)
				Baller(Paw);
	}
}

function Baller(pawn  paw)
{
		local Vector HitLocation, HitNormal, StartTrace, EndTrace, X, Y, Z, loc, vline;
	local Rotator rot;
	local Actor hit;
						
				rot = Rotator(paw.location - location);
				Spawn(class'GBolt',,, Location, rot);
}

defaultproperties
{
    RingText=FireTexture'Effects.Fire.flame_b'
    bRing=True
    GemShardClass=Class'DecoGemShardFlame'
    TimerMin=3
    TimerMax=8
    ItemName="Holy Gem"
    Style=sty_masked
    Texture=FireTexture'Effects.Fire.OnFire_J'
    bMeshEnviroMap=True
    SoundRadius=15
    AmbientSound=Sound'Ambient.Ambient.FireMedium1'
    LightSaturation=100
}
