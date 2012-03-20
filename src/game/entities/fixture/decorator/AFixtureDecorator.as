package game.entities.fixture.decorator
{
    import Box2D.Dynamics.b2Fixture;
    
    import game.entities.fixture.IFixture;

    public class AFixtureDecorator implements IFixture
    {
        protected var decoratedFixture:IFixture;
        
        public function AFixtureDecorator()
        {
        }
        
        public function add(decoratedFixture:IFixture):void
        {
            this.decoratedFixture = decoratedFixture;   
        }
        
        public function get fixture():b2Fixture
        {
            return decoratedFixture.fixture;
        }
        
        public function update():void
        {
            decoratedFixture.update();
        }
    }
}