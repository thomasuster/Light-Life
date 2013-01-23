package game
{
    import flash.display.DisplayObjectContainer;

    import starling.core.Starling;

    public class FlashStageProxy
    {
        public function getStage():DisplayObjectContainer
        {
            return Starling.current.nativeStage;
        }
    }
}
