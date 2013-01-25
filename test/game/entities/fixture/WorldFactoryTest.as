package game.entities.fixture
{
    public class WorldFactoryTest
    {
        private var worldFactory:WorldFactory;

        [Before]
        public function setup():void
        {
            worldFactory = new WorldFactory();
        }

        [Test]
        public function createWorldShouldCreateFireEntityAndUpdate():void
        {

        }
    }
}
