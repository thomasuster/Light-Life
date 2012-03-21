package game.entities.fixture.decorator
{
    import game.entities.fixture.IFixture;

    public interface IFixtureDecorator extends IFixture
    {
        function add(decoratedFixture:IFixture):void;
    }
}