package game.entities.fixture
{
    import Box2D.Dynamics.Contacts.b2Contact;
    import Box2D.Dynamics.b2ContactListener;
    import Box2D.Dynamics.b2Fixture;

    import flash.utils.Dictionary;

    import game.entities.IEntity;

    public class FireContactListener extends b2ContactListener implements IEntity
    {
        private var worldManager:WorldFactory;
        private var fixturesToCull:Dictionary = new Dictionary();
        
        public function FireContactListener(worldManager:WorldFactory)
        {
            this.worldManager = worldManager;
            super();
        }
        
        override public function BeginContact(contact:b2Contact):void
        {
            var fixtures:Array = [contact.GetFixtureA(), contact.GetFixtureB()];
            for each (var fixture:b2Fixture in fixtures)
            {
                if(fixture.GetUserData() == WorldFactory.FIRE)
                {
                    fixturesToCull[fixture] = fixture;
                }
            }
        }
        
        public function update():void
        {
            for each (var fixture:b2Fixture in fixturesToCull) 
            {
                worldManager.cull(fixture);
            }
            fixturesToCull = new Dictionary();
        }
    }
}