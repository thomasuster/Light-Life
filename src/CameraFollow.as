package
{
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Fixture;
    
    import game.WorldManager;
    import game.entities.fixture.IFixture;
    import game.entities.fixture.decorator.AFixtureDecorator;
    import game.entities.fixture.decorator.IFixtureDecorator;
    
    import starling.display.DisplayObject;
    import starling.display.Stage;
    
    public class CameraFollow extends AFixtureDecorator implements IFixtureDecorator
    {
        private var camera:DisplayObject;
        private var worldManager:WorldManager;
        
        public function CameraFollow(camera:DisplayObject, worldManager:WorldManager)
        {
            this.camera = camera;
            this.worldManager = worldManager;
        }
        
        public override function update():void
        {
            super.update();
            /*var position:b2Vec2 = fixture.GetBody().GetPosition();
            camera.x = position.x * WorldManager.SCALE;
            camera.y = position.y * WorldManager.SCALE;;
            worldManager.debugCameraX = camera.x; 
            worldManager.debugCameraY = camera.y;
            trace(camera.x + " " + camera.y);*/
        }
    }
}