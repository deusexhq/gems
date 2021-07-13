//=============================================
// Evil gem
//=============================================
Class GemWarped extends Gem;

var int ChainNum;
var int setupTime;
var int timeUntilSetup;
var bool doneSetup;

function PostBeginPlay()
{
super.PostBeginPlay();
setupTime = Rand(500);
	//Moved the setup from here to a randomized timer, since DX triggers them all at once at map start....
	//SetTimer(Rand(15),False);
}

function Tick(float deltatime)
{
    local GemWarped CT;
    local int T;
	super.tick(deltatime);
	timeUntilSetup++;
	if(!DoneSetup && timeUntilSetup >= setupTime){
		if(ChainNum == 0){
            foreach AllActors(class'GemWarped',CT)
                if(CT != Self && CT.doneSetup == True)
                    T++;

            log(T$" chains. Chain ident is"@T+1);
            ChainNum = T+1;
            doneSetup = True;
        }
	}

}

function GemEffect()
{
    local pawn paw;
    local GemWarped CT, Locked;
    local int d;
    
    if(doneSetup){
        d = hitpoints / 3;
    
        foreach AllActors(class'GemWarped',CT)
            if(CT.ChainNum == ChainNum+1)
                Locked = CT;
        
        if(Locked == None)
            foreach AllActors(class'GemWarped',CT)
                if(CT.ChainNum == 1)
                    Locked = CT;
                    
        PlaySound(Sound'Spark1', SLOT_None,,, 256);
        foreach VisibleActors(class'Pawn', paw, d)
        {
            if(paw != none && !paw.isinState('Spectating') && paw.Health >= 1 && locked != None)
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
            Locked.SetTimer(6,False);
            Locked.PlaySound(Sound'Spark1', SLOT_None,,, 256);
            }
        }
    }


}


defaultproperties
{
    RingText=Texture'GemRainbow'
    bRing=True
    GemShardClass=Class'DecoGemShardWarped'
    TimerMin=6
    TimerMax=7
    ItemName="Warped Gem"
    style=std_modulated
    Skin=Texture'GemRainbow'
}
