//=============================================================================
// StonedPerson.
//=============================================================================
class StonedPerson expands Containers;

var actor OriginActor;

// ----------------------------------------------------------------------
// Frag()
//
// copied from Engine.Decoration
// modified so fragments will smoke	and use the skin of their parent object
// ----------------------------------------------------------------------

simulated function Frag(class<fragment> FragType, vector Momentum, float DSize, int NumFrags) 
{
	local int i;
	local actor A, Toucher;
	local DeusExFragment s;
		
	NumFrags*=10;

	if ( bOnlyTriggerable )
		return; 
	if (Event!='')
		foreach AllActors( class 'Actor', A, Event )
			A.Trigger( Toucher, pawn(Toucher) );
	if ( Region.Zone.bDestructive )
	{
		Destroy();
		return;
	}
	for (i=0 ; i<NumFrags ; i++) 
	{
		s = DeusExFragment(Spawn(FragType, Owner));
		if (s != None)
		{
			s.Instigator = Instigator;
			s.CalcVelocity(Momentum,0);
			s.DrawScale = DSize*0.5+0.7*DSize*FRand();
			s.Skin = GetMeshTexture();
			if (bExplosive)
				s.bSmoking = True;
		}
	}

	if (!bExplosive)
		Destroy();
}

defaultproperties
{
    HitPoints=10
    bInvincible=True
    FragType=Class'DeusEx.GlassFragment'
    bFlammable=False
    bHighlight=False
    ItemName="Stone"
    bBlockSight=True
    Texture=Texture'Engine.S_Pawn'
    Mesh=LodMesh'DeusExDeco.CrateBreakableMed'
    CollisionRadius=34.00
    CollisionHeight=24.00
    Mass=500.00
    Buoyancy=60.00
}
