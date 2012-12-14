package game.entities.fixture.decorator
{
    import Box2D.Dynamics.b2Fixture;

    import game.entities.fixture.IFixtureEntity;

    public class AFixtureDecorator implements IFixtureEntity, IFixtureEntityDecorator
    {
        protected var decoratedFixture:IFixtureEntity;
        
        public function AFixtureDecorator()
        {
        }
        
        public function add(decoratedFixture:IFixtureEntity):void
        {
            this.decoratedFixture = decoratedFixture;   
        }
        
        public function get fixture():b2Fixture
        {
            return decoratedFixture.fixture;
        }
        
        final public function update():void
        {
            decoratedFixture.update();
            behavior();
        }
        
        /**
         * Template method 
         */        
        protected function behavior():void
        {
            
        }
    }
}