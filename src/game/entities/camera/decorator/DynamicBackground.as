package game.entities.camera.decorator
{
    import Box2D.Common.Math.b2Vec2;
    
    import com.junkbyte.console.Cc;
    
    import game.entities.fixture.WorldManager;
    
    import render.ICamera;
    import render.IDisplayObject;
    import render.IRenderer;
    
    public class DynamicBackground extends ACameraDecorator
    {
        private var tileWidth:Number;
        private var tileHeight:Number;
        private var currentHash:String;
        private var tiles:Object = {};
        private const buffer:Number = 0;
        private var renderer:IRenderer;
        private var test:Boolean = true;
        
        public function DynamicBackground(renderer:IRenderer)
        {
            this.renderer = renderer;
        }
        
        public override function add(decoratedCamera:ICamera):void
        {
            super.add(decoratedCamera);
            init();
        }
        
        private function init():void
        {
            tileWidth = width/zoom - buffer;
            tileHeight = height/zoom - buffer;
            for (var tileX:int = -1; tileX <= 1; tileX++) 
            {
                for (var tileY:int = -1; tileY <= 1; tileY++) 
                {
                    var _x:Number = getX(tileX);
                    var _y:Number = getY(tileY);
                    var displayObject:IDisplayObject = renderer.addBackGround(_x, _y, tileWidth, tileHeight);
                    tiles[hash(tileX, tileY)] = displayObject;
                }
            }
        }
        
        private function getY(tileY:int):Number
        {
            return (tileY*tileHeight) - tileHeight/2;
        }
        
        private function getX(tileX:Number):Number
        {
            return (tileX*tileWidth) - tileWidth/2;
        }
        
        public override function set zoom(value:Number):void
        {
            super.zoom = value;
            
            cullTiles();
            currentHash = "reset";
            //Refresh width for zooming
            Cc.log("DynamicBackground.zoom: text");
        }
        
        private function cullTiles():void
        {
            for each (var displayObject:IDisplayObject in tiles) 
            {
                renderer.remove(displayObject);
            }
            tiles = {};
        }
        
        protected override function behavior():void
        {
            var hashX:int = (x+(x/Math.abs(x))*(width*zoom/2)) / (tileWidth * zoom);
            var hashY:int = (y+(y/Math.abs(y))*(height*zoom/2)) / (tileHeight * zoom)
            
            var newHash:String = hash(hashX, hashY);
            var displayObject:IDisplayObject;
            var xTilesPerCamera:int = Math.ceil(width/zoom / tileWidth / 2);
            var yTilesPerCamera:int = Math.ceil(height/zoom / tileHeight / 2);
//            var xTilesPerCamera:int = 0;
//            var yTilesPerCamera:int = 0;
            
            if(test)
            {
                Cc.log("DynamicBackground.behavior: (x,y) " + x + " , " + y);
                Cc.log("DynamicBackground.behavior: (hashX,hashY) " + hashX + " , " + hashY);
                Cc.log("DynamicBackground.behavior: (width,height) " + width + " , " + height);
                Cc.log("DynamicBackground.behavior: (zoom) " + zoom);
                Cc.log("DynamicBackground.behavior: (xTilesPerCamera, yTilesPerCamera) " + xTilesPerCamera + " , " + yTilesPerCamera);
            }
            
            if(newHash != currentHash)
            {
                var newTiles:Object = {};
                currentHash = newHash;
                for (var tileX:int = hashX-xTilesPerCamera; tileX <= hashX+xTilesPerCamera; tileX++) 
                {
                    for (var tileY:int = hashY-yTilesPerCamera; tileY <= hashY+yTilesPerCamera; tileY++) 
                    {
                        var hash:String = hash(tileX, tileY);
                        if(hash in tiles)
                        {
                            newTiles[hash] = tiles[hash];
                            delete tiles[hash];
                        }
                        else
                        {
                            var _x:Number = getX(tileX);
                            var _y:Number = getY(tileY);
                            displayObject = renderer.addBackGround(_x, _y, tileWidth, tileHeight);
                            newTiles[hash] = displayObject;
                        }
                    }
                }
                
                cullTiles();
                tiles = newTiles;
            }
        }
        
        private function hash(tileX:int, tileY:int):String
        {
            return tileX + " " + tileY;
        }
    }
}