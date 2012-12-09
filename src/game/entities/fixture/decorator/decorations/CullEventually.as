package game.entities.fixture.decorator.decorations
{
import game.entities.fixture.WorldManager;
import game.entities.fixture.decorator.AFixtureDecorator;

public class CullEventually extends AFixtureDecorator
    {
        private var worldManager:WorldManager;
        private var count:int = 0;
        
        public function CullEventually(worldManager:WorldManager)
        {
            super();
            this.worldManager = worldManager;
        }
        
        protected override function behavior():void
        {
            count++;
            if(count == 100)
            {
                worldManager.cull(fixture);
            }
        }
    }
}