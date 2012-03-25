package render.starling.decorator
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;
    
    import game.entities.fixture.IFixture;
    
    import render.IDisplayObject;
    import render.IRenderer;
    import render.starling.StarlingDisplayObject;
    
    import starling.display.DisplayObject;
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
        private var displayObjects:Dictionary = new Dictionary();
        
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
        
        public function addBackGround(x:Number, y:Number, width:Number, height:Number):IDisplayObject
        {
            var texture:Texture = Texture.fromBitmap(stars);
            var image:Image = new Image(texture);
            image.x = x;
            image.y = y;
            image.width = width;
            image.height= height;
            var displayObject:IDisplayObject = new StarlingDisplayObject(image);
            addChild(displayObject, image);
            return displayObject;
        }
        
        public function remove(displayObject:IDisplayObject):void
        {
            removeChild(displayObject);
            delete displayObjects[displayObject];
        }
        
        private function addChild(displayObject:IDisplayObject, starlingDisplayObject:DisplayObject):void
        {
            container.addChild(starlingDisplayObject);
            displayObjects[displayObject] = starlingDisplayObject;
        }
        
        private function removeChild(displayObject:IDisplayObject):void
        {
            var starlingDisplayObject:DisplayObject = displayObjects[displayObject];
            container.removeChild(starlingDisplayObject);
            delete displayObjects[displayObject];
        }
    }
}