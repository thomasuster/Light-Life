package game.entities.fixture.decorator
{
    import game.entities.fixture.IFixtureEntity;

    public interface IFixtureEntityDecorator extends IFixtureEntity
    {
        function add(decoratedFixture:IFixtureEntity):void;
    }
}