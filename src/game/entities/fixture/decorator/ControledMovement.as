package game.entities.fixture.decorator
{
    import Box2D.Common.Math.b2Vec2;
    
    import game.entities.fixture.IFixture;

    public class ControledMovement extends AFixtureDecorator
    {
        private var controls:Controls;
        
        public function ControledMovement(controls:Controls)
        {
            this.controls = controls;
        }
        
        public override function update():void
        {
            super.update();
            move();
        }
        
        private function move():void
        {
            // easing on the custom sprite position
            var xDir:int = controls.getXDir();
            var yDir:int = controls.getYDir();
            
            //Moving
            var xDelta:Number = xDir * 1;
            var yDelta:Number = yDir * 1;
            var error:Number = 0.1;
            if(Math.abs(xDelta) > error || Math.abs(yDelta) > error)
            {
                fixture.GetBody().ApplyImpulse(new b2Vec2(xDelta, yDelta), new b2Vec2(0, 0));
            }
            else
            {
                fixture.GetBody().SetLinearDamping(3);
            }
        }
    }
}