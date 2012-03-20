package game.entities.fixture
{
    import Box2D.Dynamics.b2Fixture;
    
    import game.entities.IEntity;

    public interface IFixture extends IEntity
    {
        function get fixture():b2Fixture;
    }
}