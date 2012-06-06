package game.entities.camera.decorator
{
    import game.entities.IEntity;
    import game.entities.fixture.IFixtureEntity;
    
    import render.ICamera;

    public interface ICameraDecorator extends ICamera, IEntity
    {
        function add(decoratedCamera:ICamera):void
    }
}