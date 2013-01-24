package game.entities.fixture
{
    import Box2D.Dynamics.Contacts.b2Contact;
    import Box2D.Dynamics.b2Fixture;

    import mockolate.allow;
    import mockolate.expect;

    [RunWith("mockolate.runner.MockolateRunner")]
    public class FireContactListenerTest
    {
        [Mock(type="nice")]
        public var contact:b2Contact
        [Mock(type="nice")]
        public var worldManager:WorldManager;

        private var fireContactListener:FireContactListener;

        [Before]
        public function setup():void
        {
            fireContactListener = new FireContactListener(worldManager);
        }

        [Test]
        public function onFireContactShouldCullAllFiresOnUpdate():void
        {
            var fireFixture:b2Fixture = new b2Fixture();
            collideAShot(fireFixture);
            expect(worldManager.cull(fireFixture));
            fireContactListener.update();
        }

        private function collideAShot(fireFixture:b2Fixture):void
        {
            allow(contact.GetFixtureA()).returns(fireFixture);
            allow(contact.GetFixtureB()).returns(new b2Fixture());
            fireFixture.SetUserData(WorldManager.FIRE);
            fireContactListener.BeginContact(contact);
        }
    }
}
