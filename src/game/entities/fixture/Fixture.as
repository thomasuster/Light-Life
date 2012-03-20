package game.entities.fixture
{
    import Box2D.Dynamics.b2Fixture;
    
    public class Fixture implements IFixture
    {
        protected var _fixture:b2Fixture;
        
        public function Fixture(fixture:b2Fixture)
        {
            _fixture = fixture;
        }
        
        public function get fixture():b2Fixture
        {
            return _fixture;
        }
        
        public function update():void
        {
        }
    }
}