package game.entities.camera.decorator
{
    import Box2D.Common.Math.b2Vec2;
    
    import render.ICamera;
    import render.IDisplayObject;
    import render.IRenderer;
    
    public class DynamicBackground extends ACameraDecorator
    {
        private var tileWidth:Number;
        private var tileHeight:Number;
        private var currentHash:String;
        /*private var cameraWidth:Number;
        private var error:Number = 0.01;*/
        private var tiles:Object = {};
        private const buffer:Number = 100;
        private var renderer:IRenderer;
        
        public function DynamicBackground(renderer:IRenderer)
        {
            this.renderer = renderer;
        }
        
        public override function add(decoratedCamera:ICamera):void
        {
            super.add(decoratedCamera);
            tileWidth = width + buffer;
            tileHeight = height + buffer;
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
        
        protected override function behavior():void
        {
            //trace(camera.x + " " + camera.y);
            var hashX:int = x / tileWidth;
            var hashY:int = y / tileHeight;
            var newHash:String = hash(hashX, hashY);
            var displayObject:IDisplayObject;
//            trace(newHash);
            if(newHash != currentHash)
            {
                var newTiles:Object = {};
                currentHash = newHash;
                for (var tileX:int = hashX-1; tileX <= hashX+1; tileX++) 
                {
                    for (var tileY:int = hashY-1; tileY <= hashY+1; tileY++) 
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
//                            trace(_x + " " + _y);
                            displayObject = renderer.addBackGround(_x, _y, tileWidth, tileHeight);
                            newTiles[hash] = displayObject;
                        }
                    }
                }
                
                for each (displayObject in tiles) 
                {
                    renderer.remove(displayObject);
                }
                tiles = newTiles;
            }
        }
        
        private function hash(tileX:int, tileY:int):String
        {
            return tileX + " " + tileY;
        }
    }
}