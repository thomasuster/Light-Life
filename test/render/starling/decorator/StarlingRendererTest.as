package render.starling.decorator {

    import org.flexunit.assertThat;

    import org.hamcrest.object.equalTo;

    import render.IDisplayObject;

    import starling.display.Sprite;

    public class StarlingRendererTest {
        private var starlingRenderer:StarlingRenderer;
        private var container:Sprite;
        private const GRID_SIZE:int = 3;

        [Before]
        public function setUp():void
        {
            container = new Sprite();
            starlingRenderer = new StarlingRenderer(container);
        }

        [Test]
        public function backgroundShouldGenerateMissingAssets():void
        {

        }

        [Test]
        public function backgroundShouldGroByGridSize():void
        {
            var base:IDisplayObject = starlingRenderer.addBackGround(0,0,100,100,"stars1");
            var bigger:IDisplayObject = starlingRenderer.addBackGround(0,0,100,100,"stars2");
            assertThat(base.height, equalTo(GRID_SIZE*bigger.height));
            assertThat(base.width, equalTo(GRID_SIZE*bigger.width));
        }
    }
}
