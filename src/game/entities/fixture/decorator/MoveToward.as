package game.entities.fixture.decorator
{
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Body;
    import Box2D.Dynamics.b2Fixture;
    
    import game.entities.fixture.IFixture;

    public class MoveToward extends AFixtureDecorator
    {
        private var targetFixture:b2Body;
        
        public function MoveToward(targetFixture:b2Body)
        {
            this.targetFixture = targetFixture;
        }
        
        protected override function behavior():void
        {
            var direction:b2Vec2 = targetFixture.GetPosition().Copy();
            direction.Subtract(fixture.GetBody().GetPosition());
            
            var xDir:int = direction.x;
            var yDir:int = direction.y;
            
            var speed:Number = 0.02;
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