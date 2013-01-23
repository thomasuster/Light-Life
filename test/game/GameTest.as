package game
{
    import flash.display.Sprite;

    import mockolate.allow;

    import render.starling.decorator.StarlingRenderer;

    import starling.display.Sprite;
    import starling.events.Event;

    [RunWith("mockolate.runner.MockolateRunner")]
    public class GameTest
    {
        [Mock(type="nice")]
        public var starlingStage:StarlingStageProxy;
        [Mock(type="nice")]
        public var flashStage:FlashStageProxy;
        [Mock(type="nice")]
        public var renderer:StarlingRenderer;

        private var myGame:Game;

        [Before]
        public function setup():void
        {
            myGame = new Game();
            myGame.starlingStage = starlingStage;
            myGame.flashStage = flashStage;
            myGame.renderer = renderer;
            allow(starlingStage.getStage()).returns(new starling.display.Sprite());
            allow(flashStage.getStage()).returns(new flash.display.Sprite());
        }

        [Test]
        public function onAddedToStageGameShouldCreateBadGuys():void
        {
            myGame.dispatchEvent(new Event(Event.ADDED_TO_STAGE));
        }
    }
}
