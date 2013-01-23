package game
{
    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;

    public class StarlingStageProxy
    {
        private var reference:DisplayObject;

        public function StarlingStageProxy(reference:DisplayObject)
        {
            this.reference = reference;
        }

        public function getStage():DisplayObjectContainer
        {
            return reference.stage;
        }
    }
}
