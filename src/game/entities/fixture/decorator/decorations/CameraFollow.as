package game.entities.fixture.decorator.decorations
{
    import Box2D.Common.Math.b2Vec2;

    import game.entities.fixture.WorldFactory;
    import game.entities.fixture.decorator.AFixtureDecorator;
    import game.entities.fixture.decorator.IFixtureEntityDecorator;

    import render.ICamera;

    public class CameraFollow extends AFixtureDecorator implements IFixtureEntityDecorator
    {
        private var camera:ICamera;
        
        public function CameraFollow(camera:ICamera)
        {
            this.camera = camera;
        }
        
        protected override function behavior():void
        {
            var position:b2Vec2 = fixture.GetBody().GetPosition();
            camera.x = position.x * WorldFactory.SCALE * camera.zoom;
            camera.y = position.y * WorldFactory.SCALE * camera.zoom;
        }
    }
}