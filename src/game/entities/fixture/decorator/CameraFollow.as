package game.entities.fixture.decorator
{
    import Box2D.Common.Math.b2Vec2;
    
    import game.entities.fixture.WorldManager;
    
    import render.ICamera;
    
    public class CameraFollow extends AFixtureDecorator implements IFixtureDecorator
    {
        private var camera:ICamera;
        
        public function CameraFollow(camera:ICamera)
        {
            this.camera = camera;
        }
        
        protected override function behavior():void
        {
            var position:b2Vec2 = fixture.GetBody().GetPosition();
            //camera.x = position.x;
            //camera.x = position.x;
            /*camera.x = -1 * position.x * WorldManager.SCALE + LightLife.WIDTH / 2;
            camera.y = -1 * position.y * WorldManager.SCALE + LightLife.HEIGHT / 2;*/
            
            camera.x = position.x * WorldManager.SCALE;
            camera.y = position.y * WorldManager.SCALE;
        }
    }
}