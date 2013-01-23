package game
{
    import starling.display.Sprite;

    public class StageProxyTest
    {
        private var stageProxy:StarlingStageProxy;

        [Before]
        public function setup():void
        {
            stageProxy = new StarlingStageProxy(new Sprite());
        }

        [Test]
        public function isNotExplody():void
        {
        }
    }
}
