//=============================================
// Master class of the Gems
//=============================================
Class Gem extends DeusExDecoration;

var Pawn GemOwner;
var() int Purity;
var() texture RingText;
var() bool bRing;
var() bool bDoomed;
var() class<DecoGemShard> GemShardClass;
var() int TimerMin, TimerMax;
var() bool bRandomStats;
var GemFlare MyFlare;

function BeginPlay()
{
	SetTimer(1,False);
	if(bRandomStats)
	{
		Hitpoints = RandRange(250,750);
		Purity = RandRange(25,100);
	}
}

function PostBeginPlay()
{
	MyFlare = Spawn(class'GemFlare',,,Location);
	MyFlare.SetBase(Self);
}

function Bump(actor Other)
{
	if(Gemshard(Other) != None)
	{
		if(Purity <= 100 && (GemShard(Other).GemSpawnClass == Self.Class && !IsA('GemCorrupted') && GemShardCorrupted(Other) == None))
		{
			Purity+=5;
			Other.Destroy();
		}
		else if(GemShardCorrupted(Other) != None)
		{
			Purity-=15;
			Other.Destroy();
		}
	}
}

function Tick(float deltatime)
{
	local vector v2;
	if (GemOwner != None)
	{
		if(GemOwner.Health <= 0)
		{
			ExplodeLum();
			Destroy();
		}
	}
}

function GemEffect()
{}

function Timer()
{
local pring sphere;

	if(Purity <= 15)
	{
		if(FRand() < 0.1)
		{
			GemShardclass = class'DecoGemShardCorrupted';
			Destroy();
		}
		
	}
	if(bRing)
	{
		sphere = Spawn(class'Gems.pring',,, Location);
		if (sphere != None)
		{
		sphere.size = purity / 32.0;
		sphere.bMeshEnviroMap=True;
		Sphere.MultiSkins[0]=RingText;
		Sphere.Texture=RingText;
		}
		GemEffect();
		SetTimer(RandRange(TimerMin,TimerMax), False);
	}
}

function ExplodeLum()
{
	local SphereEffect sphere;
	local ScorchMark s;
	local ExplosionLight light;
	local int i;
	local float explosionDamage;
	local float explosionRadius;
	local ProjectileGenerator PG;
	
	explosionDamage = 100;
	explosionRadius = 256;

	// alert NPCs that I'm exploding
	AISendEvent('LoudNoise', EAITYPE_Audio, , explosionRadius*16);
	PlaySound(Sound'LargeExplosion1', SLOT_None,,, explosionRadius*16);

	// draw a pretty explosion
	light = Spawn(class'ExplosionLight',,, Location);
	if (light != None)
		light.size = 4;

	Spawn(class'ExplosionSmall',,, Location + 2*VRand()*CollisionRadius);
	Spawn(class'ExplosionMedium',,, Location + 2*VRand()*CollisionRadius);
	Spawn(class'ExplosionMedium',,, Location + 2*VRand()*CollisionRadius);
	Spawn(class'ExplosionLarge',,, Location + 2*VRand()*CollisionRadius);

	sphere = Spawn(class'SphereEffect',,, Location);
	if (sphere != None)
		sphere.size = explosionRadius / 32.0;

	// spawn a mark
	s = spawn(class'ScorchMark', Base,, Location-vect(0,0,1)*CollisionHeight, Rotation+rot(16384,0,0));
	if (s != None)
	{
		s.DrawScale = FClamp(explosionDamage/30, 0.1, 3.0);
		s.ReattachDecal();
	}

	// spawn some rocks and flesh fragments
	for (i=0; i<explosionDamage/6; i++)
	{
		if (FRand() < 0.2)
			spawn(GemShardClass,,,Location);
		else
			spawn(class'GlassFragment',,,Location);
	}
	
	PG = spawn(class'ProjectileGenerator',,,Location,rot(16384,0,0));
	PG.bRandomEject=True;
	PG.ProjectileClass = class'Tracer';
	PG.NumPerSpawn = 5;
	PG.CheckTime = 0.1;
	PG.Lifespan=1;
	HurtRadius(explosionDamage, explosionRadius, 'Exploded', explosionDamage*100, Location);
	//Destroy();
}

function DestroyEffect()
{	
}

function Destroyed()
{
	if(!bDoomed)
		ExplodeLum();
		
	MyFlare.Destroy();
	DestroyEffect();
	Super.destroyed();
}

defaultproperties
{
    RingText=Texture'DeusExDeco.Skins.AlarmLightTex7'
    GemShardClass=Class'DecoGemShard'
    bRandomStats=True
    HitPoints=100
    FragType=Class'DeusEx.GlassFragment'
    bHighlight=False
    ItemName="Gem"
    bPushable=False
    Physics=phys_rotating
    Style=sty_translucent
    Skin=Texture'DeusExItems.Skins.GlassFragmentTex1'
    Mesh=LodMesh'DeusExDeco.Lightbulb'
    DrawScale=4.00
    AmbientGlow=255
    Fatness=140
    CollisionRadius=5.00
    CollisionHeight=8.00
    LightType=1
    LightBrightness=100
    LightSaturation=255
    LightRadius=10
    bFixedRotationDir=True
    RotationRate=(Pitch=0,Yaw=8192,Roll=0),
}
