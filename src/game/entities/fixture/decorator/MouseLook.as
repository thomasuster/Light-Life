package game.entities.fixture.decorator
{
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Body;
    
    import game.entities.fixture.IFixture;

    public class MouseLook extends AFixtureDecorator
    {
        private var controls:Controls;
        
        public function MouseLook(controls:Controls)
        {
            this.controls = controls;
        }
        
        public override function update():void
        {
            super.update();
            roate();
        }
        
        private function roate():void
        {
            //Rotation
            var body:b2Body = fixture.GetBody();
            var mousePosition:b2Vec2 = new b2Vec2(controls.mouseX/30, controls.mouseY/30)
            mousePosition.Subtract(body.GetPosition());
            var angle:Number = Math.atan2(mousePosition.y, mousePosition.x);
            var bodyAngle:Number = body.GetAngle();
            fixture.GetBody().SetAngle(angle);
        }
    }
}