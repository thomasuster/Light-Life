package game
{
    import flash.display.Sprite;

    import game.entities.fixture.WorldFactory;

    import mockolate.allow;
    import mockolate.expect;

    import org.hamcrest.assertThat;
    import org.hamcrest.number.greaterThan;

    import render.starling.decorator.StarlingRenderer;

    import starling.display.Sprite;
    import starling.events.Event;

    [RunWith("mockolate.runner.MockolateRunner")]
    public class GameStarterTest
    {
        [Mock(type="nice")]
        public var starlingStage:StarlingStageProxy;
        [Mock(type="nice")]
        public var flashStage:FlashStageProxy;
        [Mock(type="nice")]
        public var renderer:StarlingRenderer;
        [Mock(type="nice")]
        public var worldManager:WorldFactory;

        private var myGame:GameStarter;

        [Before]
        public function setup():void
        {
            myGame = new GameStarter();
            inject();
            allow(starlingStage.getStage()).returns(new starling.display.Sprite());
            allow(flashStage.getStage()).returns(new flash.display.Sprite());
        }

        public function inject():void
        {
            myGame.starlingStage = starlingStage;
            myGame.flashStage = flashStage;
            myGame.renderer = renderer;
            myGame.worldManager = worldManager;
        }

        [Test]
        public function onAddedToStageGameShouldCreateBadGuys():void
        {
            expect(worldManager.createBadGuy()).atLeast(1);
            onAdded();
        }

        private function onAdded():void
        {
            myGame.dispatchEvent(new Event(Event.ADDED_TO_STAGE));
        }

        [Test]
        public function onAddedShouldCreateWorld():void
        {
            expect(worldManager.createWorld());
            onAdded();
        }

        [Test]
        public function onAddedShouldCreateFireContact():void
        {
            onAdded();
        }
    }
}
