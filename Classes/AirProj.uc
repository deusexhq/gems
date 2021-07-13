class AirProj extends Shuriken;

simulated function Tick(float DeltaTime)
{
	Super.Tick(DeltaTime);
	Owner.SetLocation(Location);
}

defaultproperties
{
    bBlood=False
    bStickToWall=False
    ItemName="Air Missile"
    ItemArticle="an"
}
