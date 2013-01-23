package game.entities.fixture
{
    public class WorldManagerTest
    {
        private var worldManager:WorldManager;

        [Before]
        public function setup():void
        {
            worldManager = new WorldManager();
        }

        [Test]
        public function notExploding():void
        {
        }
    }
}
