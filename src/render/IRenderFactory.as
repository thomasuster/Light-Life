package render
{
    import game.entities.fixture.IFixture;

    public interface IRenderFactory
    {
        function createDrawHero():IFixture;
        //function drawDrone():void;
    }
}