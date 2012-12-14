package render.starling.decorator
{
    import flash.events.Event;

    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.events.Event;

    //http://forum.starling-framework.org/topic/testing-starling-application-with-flexunit
    public class FlexUnitStarlingIntegration extends Sprite
    {
        public function FlexUnitStarlingIntegration()
        {
            super();
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(event:starling.events.Event):void
        {
            this.removeEventListener(starling.events.Event.ADDED_TO_STAGE, onAddedToStage);
            Starling.current.nativeStage.dispatchEvent(new flash.events.Event(flash.events.Event.COMPLETE));
        }
    }
}

