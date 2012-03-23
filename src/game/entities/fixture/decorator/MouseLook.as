package game.entities.fixture.decorator
{
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Body;
    
    import flash.display.DisplayObject;
    
    import game.WorldManager;
    import game.entities.fixture.IFixture;
    
    import render.ICamera;

    public class MouseLook extends AFixtureDecorator
    {
        private var controls:Controls;
        private var camera:ICamera;
        
        public function MouseLook(controls:Controls, camera:ICamera)
        {
            this.controls = controls;
            this.camera = camera;
        }
        
        public override function update():void
        {
            super.update();
            roate();
        }
        
        private function roate():void
        {
            //Rotation
            trace(camera.x + " " + camera.y);
            
            var body:b2Body = fixture.GetBody();
            var bodyPosition:b2Vec2 = body.GetPosition();
            var mousePosition:b2Vec2 = new b2Vec2((controls.mouseX + camera.x - LightLife.WIDTH/2) / WorldManager.SCALE, (controls.mouseY + camera.y - LightLife.HEIGHT/2) / WorldManager.SCALE);
                
            mousePosition.Subtract(bodyPosition);
            var angle:Number = Math.atan2(mousePosition.y, mousePosition.x);
            var bodyAngle:Number = body.GetAngle();
            fixture.GetBody().SetAngle(angle);
        }
    }
}