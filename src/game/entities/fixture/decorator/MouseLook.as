package game.entities.fixture.decorator
{
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Body;
    
    import flash.display.DisplayObject;
    
    import game.entities.fixture.WorldManager;
    import game.entities.fixture.IFixture;
    
    import render.ICamera;

    public class MouseLook extends AFixtureDecorator
    {
        private var controls:Controls;
        private var _game:Game;
        
        public function MouseLook(controls:Controls, game:Game)
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