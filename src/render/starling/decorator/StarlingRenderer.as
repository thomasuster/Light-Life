package render.starling.decorator
{
    import flash.display.Bitmap;
    
    import game.entities.fixture.IFixture;
    
    import render.IRenderer;
    
    import starling.display.DisplayObjectContainer;
    import starling.display.Image;
    import starling.display.Stage;
    import starling.textures.Texture;
    
    public class StarlingRenderer implements IRenderer
    {
        [Embed (source="assets/stars.gif" )]
        private static const Stars:Class;
        private var stars:Bitmap = new Stars();
        
        private var container:DisplayObjectContainer;
        
        public function StarlingRenderer(container:DisplayObjectContainer)
        {
            this.container = container;
        }
        
        public function addDrawHero(fixture:IFixture):IFixture
        {
            var customSprite:HeroDecorator = new HeroDecorator(200, 200);
            customSprite.add(fixture);
            container.addChild(customSprite);
            return customSprite;
        }
        
        public function addBackground():void
        {
            var texture:Texture = Texture.fromBitmap(stars);
            var image:Image = new Image(texture);
            image.width = LightLife.WIDTH * 1.2;
            image.height= LightLife.HEIGHT * 1.2;
            container.addChild(image);
        }
    }
}