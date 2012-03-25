package game.entities.fixture.decorator
{
    import Box2D.Common.Math.b2Vec2;
    
    import game.entities.fixture.IFixture;

    public class KeyboardMove extends AFixtureDecorator
    {
        private var controls:Controls;
        
        public function KeyboardMove(controls:Controls)
        {
            this.controls = controls;
        }
        
        protected override function behavior():void
        {
            // easing on the custom sprite position
            var xDir:int = controls.getXDir();
            var yDir:int = controls.getYDir();

            var speed:Number;
            if(controls.mouseDown)
            {
                speed = 10;
            }
            else
            {
                speed = 1;
            }
            //Moving
            var xDelta:Number = xDir * speed;
            var yDelta:Number = yDir * speed;
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