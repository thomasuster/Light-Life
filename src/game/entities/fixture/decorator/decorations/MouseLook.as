package game.entities.fixture.decorator.decorations
{
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Body;

    import game.GameStarter;

    import game.entities.fixture.decorator.AFixtureDecorator;

    public class MouseLook extends AFixtureDecorator
    {
        private var controls:Controls;
        private var _game:GameStarter;
        
        public function MouseLook(controls:Controls, game:GameStarter)
        {
            this.controls = controls;
            this._game = game;
        }
        
        protected override function behavior():void
        {
            //Rotation
            var body:b2Body = fixture.GetBody();
            var bodyPosition:b2Vec2 = body.GetPosition();
            
            var mousePosition:b2Vec2 = _game.cameraToWorld(controls.mouseX, controls.mouseY);
            
            mousePosition.Subtract(bodyPosition);
            
            var angle:Number = Math.atan2(mousePosition.y, mousePosition.x);
            var bodyAngle:Number = body.GetAngle();
            fixture.GetBody().SetAngle(angle);
        }
    }
}