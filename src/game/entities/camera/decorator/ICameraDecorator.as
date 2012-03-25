package game.entities.camera.decorator
{
    import game.entities.IEntity;
    import game.entities.fixture.IFixture;
    
    import render.ICamera;

    public interface ICameraDecorator extends ICamera, IEntity
    {
        function add(decoratedCamera:ICamera):void
    }
}