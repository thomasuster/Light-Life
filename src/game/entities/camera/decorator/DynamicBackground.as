package game.entities.camera.decorator
{
    import com.junkbyte.console.Cc;
    
    import render.ICamera;
    import render.IDisplayObject;
    import render.IRenderer;
    
    public class DynamicBackground extends ACameraDecorator
    {
        private var baseTileWidth:Number;
        private var baseTileHeight:Number;
        private var currentHash:String;
        private var tiles:Object = {};
        private const buffer:Number = 0;
        private var renderer:IRenderer;
        private var test:Boolean = false;
        private var dimensionsByTiles:Object = {};

        private var ratio:int = 1;
        
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
            //var tile:TileDimensions = calculateTileDimensions();
            baseTileWidth =  (width/zoom);
            baseTileHeight = baseTileWidth;
        }
        
//        private function calculateTileDimensions():TileDimensions
//        {
////            var tile:TileDimensions = new TileDimensions();
////            tile.tileWidth = width/zoom - buffer;
////            tile.tileHeight = tile.tileWidth;
//            //tile.tileHeight = height/zoom - buffer;
//            return tile;
//        }
        
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
            //LOD
            //var baseTilesPerCameraRaw:Number = width/zoom / (baseTileWidth);
            //var baseTilesPerCamera:int = baseTilesPerCameraRaw;
            var currentTileWidth:Number = (width/zoom);
            var _ratio:Number = currentTileWidth/baseTileWidth;
            ratio = (_ratio)/3+1;
            
//            3  % 3 = 0 //3/3 = 1
//            4  % 3 = 1
//            5  % 3 = 2
//            6  % 3 = 0 //6/3 = 2
            
            
            Cc.log("DynamicBackground.ratio: " + ratio);
            
            var _tileWidth:Number = baseTileWidth * Math.pow(3, ratio);
            var _tileHeight:Number = baseTileHeight * Math.pow(3, ratio);
            
            var hashX:int = (x+(x/Math.abs(x))*(width*zoom/2)) / (_tileWidth * zoom);
            var hashY:int = (y+(y/Math.abs(y))*(height*zoom/2)) / (_tileHeight * zoom);
            
            var newHash:String = hash(hashX, hashY);
            var displayObject:IDisplayObject;
            
            if(true)
            {
//                Cc.log("DynamicBackground.behavior: (x,y) " + x + " , " + y);
//                Cc.log("DynamicBackground.behavior: (hashX,hashY) " + hashX + " , " + hashY);
//                Cc.log("DynamicBackground.behavior: (width,height) " + width + " , " + height);
//                Cc.log("DynamicBackground.behavior: (zoom) " + zoom);
                Cc.log("DynamicBackground.behavior: _tileWidth" + _tileWidth);
            }
            
            if(newHash != currentHash)
            {
                var newTiles:Object = {};
                currentHash = newHash;
                
                for (var tileX:int = hashX; tileX <= hashX; tileX++) 
                {
                    for (var tileY:int = hashY; tileY <= hashY; tileY++) 
                    {
                        var hash:String = hash(tileX, tileY);
                        if(hash in tiles)
                        {
                            newTiles[hash] = tiles[hash];
                            delete tiles[hash];
                        }
                        else
                        {
                            var _x:Number = getX(tileX, _tileWidth);
                            var _y:Number = getY(tileY, _tileHeight);
                            displayObject = renderer.addBackGround(_x, _y, _tileWidth, _tileWidth, String(ratio));
                            newTiles[hash] = displayObject;
                        }
                    }
                }
                
                cullTiles();
                tiles = newTiles;
            }
        }
        
        private function getY(tileY:int, _tileHeight:Number):Number
        {
            return (tileY*_tileHeight) - _tileHeight/2;
        }
        
        private function getX(tileX:Number, _tileWidth:Number):Number
        {
            return (tileX*_tileWidth) - _tileWidth/2;
        }
        
        private function hash(tileX:int, tileY:int):String
        {
            return tileX + " " + tileY;
        }
    }
}

internal class TileDimensions
{
    public var tileWidth:Number = 1;
    public var tileHeight:Number = 1;
    
    public function TileDimensions()
    {
        
    }
}