package render
{
    import game.entities.fixture.IFixture;

    public interface IRenderer
    {
        function addDrawHero(fixture:IFixture):IFixture;
    }
}