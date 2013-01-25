package game
{
    import flash.display.Sprite;

    import game.entities.fixture.WorldFactory;

    import mockolate.allow;
    import mockolate.expect;

    import render.starling.decorator.StarlingRenderer;

    import starling.display.Sprite;
    import starling.events.Event;

    [RunWith("mockolate.runner.MockolateRunner")]
    public class GameStarterTest
    {
        [Mock(type="nice")]
        public var starlingStageProxy:StarlingStageProxy;
        [Mock(type="nice")]
        public var flashStageProxy:FlashStageProxy;
        [Mock(type="nice")]
        public var renderer:StarlingRenderer;
        [Mock(type="nice")]
        public var worldFactory:WorldFactory;

        private var myGame:GameStarter;

        private var starlingStage:starling.display.Sprite = new starling.display.Sprite();

        [Before]
        public function setup():void
        {
            myGame = new GameStarter();
            inject();
            allow(starlingStageProxy.getStage()).returns(starlingStage);
            allow(flashStageProxy.getStage()).returns(new flash.display.Sprite());
        }

        public function inject():void
        {
            myGame.starlingStage = starlingStageProxy;
            myGame.flashStage = flashStageProxy;
            myGame.renderer = renderer;
            myGame.worldFactory = worldFactory;
        }

        [Test]
        public function onAddedToStageGameShouldCreateBadGuys():void
        {
            expect(worldFactory.createBadGuy()).atLeast(1);
            onAdded();
        }

        private function onAdded():void
        {
            myGame.dispatchEvent(new Event(Event.ADDED_TO_STAGE));
        }

        [Test]
        public function onAddedShouldCreateWorld():void
        {
            expect(worldFactory.createWorld());
            onAdded();
        }

        [Test]
        public function onAddedAndFrameShouldUpdateWorldFactory():void
        {
            expect(worldFactory.update());
            onAdded();
            starlingStage.dispatchEvent(new Event(Event.ENTER_FRAME));
        }
    }
}
