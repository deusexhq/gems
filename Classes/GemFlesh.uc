//=============================================
// Evil gem
//=============================================
Class GemFlesh extends Gem;
var int pass;
//flesh [effect, fatness, from 120-150-120-200, +5, -10, +10, +5 - spawns gore

function GemEffect()
{
}

function Tick(float deltatime)
{
	if(Pass == 0)
	{
		Fatness+=2;
		if(Fatness >= 150)
			Pass=1;
	}
	
	if(Pass == 1)
	{
		Fatness--;
		if(Fatness <= 120)
			Pass=2;
	}
	if(Pass == 2)
	{
		Fatness+=5;
		if(Fatness >= 200)
			Pass=3;
	}
	if(Pass == 3)
	{
		Fatness--;
		if(Fatness <= 120)
			Pass=0;
	}
}

defaultproperties
{
    RingText=Texture'DeusExItems.Skins.FleshFragmentTex1'
    bRing=True
    GemShardClass=None
    TimerMin=5
    TimerMax=9
    ItemName="Flesh Gem"
    Style=sty_modulated
    Skin=Texture'DeusExItems.Skins.FleshFragmentTex1'
    Fatness=120
}
