package render.starling.decorator {

    import flash.display.Bitmap;
    import flash.geom.Rectangle;

    import mockolate.allow;
    import mockolate.arg;
    import mockolate.expect;

    import org.flexunit.assertThat;
    import org.hamcrest.object.instanceOf;

    import render.Assets;
    import render.IDisplayObject;

    import starling.display.Sprite;
    import starling.textures.Texture;

    [RunWith("mockolate.runner.MockolateRunner")]
    public class StarlingRendererTest
    {
        private var renderer:StarlingRenderer;
        private const GRID_SIZE:int = 3;

        [Mock(type="nice")]
        public var textureProxy:TextureProxy;

        [Mock(type="nice")]
        public var texture:Texture;

        public var assets:Assets;

        [Before]
        public function setUp():void
        {
            create();
            inject();
        }

        private function create():void
        {
            var container:Sprite = new Sprite();
            renderer = new StarlingRenderer(container);
            assets = new Assets();
        }

        private function inject():void
        {
            renderer.textureProxy = textureProxy;
            renderer.assets = assets;
        }

        [Test]
        public function shouldReturnDisplayObject():void
        {
            expect(textureProxy.fromBitmap(arg(instanceOf(Bitmap)))).returns(texture);
            var rect:Rectangle = new Rectangle();
            allow(texture.frame).returns(rect);
            assertThat(renderer.getStars(1), instanceOf(IDisplayObject));
        }
    }
}
