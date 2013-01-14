package render.starling.decorator {

    import flash.display.Bitmap;
    import flash.geom.Rectangle;

    import mockolate.allow;
    import mockolate.arg;
    import mockolate.capture;
    import mockolate.expect;
    import mockolate.ingredients.Capture;

    import org.flexunit.assertThat;
    import org.hamcrest.object.instanceOf;
    import org.hamcrest.object.notNullValue;

    import render.Assets;
    import render.IDisplayObject;

    import starling.display.DisplayObject;
    import starling.display.Image;

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

        public var container:Sprite;

        public var assets:Assets;

        [Before]
        public function setUp():void
        {
            create();
            inject();
            expectTexture();
            renderer.init();
        }

        private function create():void
        {
            container = new Sprite();
            renderer = new StarlingRenderer();
            assets = new Assets();
        }

        private function inject():void
        {
            renderer.container = container;
            renderer.textureProxy = textureProxy;
            renderer.assets = assets;
        }

        private function expectTexture():void
        {
            expect(textureProxy.fromBitmap(arg(instanceOf(Bitmap)))).returns(texture).once();
        }

        [Test]
        public function renderStarsShouldAddToStage():void
        {
            expectTexture();
            var rect:Rectangle = new Rectangle();
            renderer.renderStars(rect);
            var background:DisplayObject = getBackgroundByTexture(texture);
            assertThat(background, notNullValue());
        }

        private function getBackgroundByTexture(texture:Texture):DisplayObject
        {
            for (var i:int = 0; i < container.numChildren; i++)
            {
                var displayObject:DisplayObject = container.getChildAt(i);
                if(displayObject is Image)
                {
                    var image:Image = displayObject as Image;
                    if(image.texture == texture)
                        return image;
                }
            }
            return null;
        }
    }
}
