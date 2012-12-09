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
    private var levelOfDetail:String;
    private var tiles:Object = {};
    private var renderer:IRenderer;
    private var newHash:String;
    private var hashX:int;
    private var hashY:int;
    private var newTileWidth:Number;
    private var newTileHeight:Number;
    private var newTiles:Object;
    private var ratio:int = 1;
    private static const gridSize:int = 3;

    public function DynamicBackground(renderer:IRenderer)
    {
        this.renderer = renderer;
    }

    public override function add(decoratedCamera:ICamera):void
    {
        super.add(decoratedCamera);
        calculateBasesDimensions();
    }

    private function calculateBasesDimensions():void
    {
        baseTileWidth =  (width/zoom);
        baseTileHeight = baseTileWidth;
    }

    public override function set zoom(value:Number):void
    {
        super.zoom = value;
    }

    private function cull():void
    {
        for each (var displayObject:IDisplayObject in tiles) {
            renderer.remove(displayObject);
        }
        tiles = {};
    }

    protected override function behavior():void
    {
        calculateNewValues();
        debug();
        checkAndAdjust();
    }

    private function checkAndAdjust():void {

        if(newHash != levelOfDetail) {
            levelOfDetail = newHash;
            newTiles = {};
            generateTiles();
            cull();
            tiles = newTiles;
        }
    }

    private function generateTiles():void {
        for (var tileX:int = hashX; tileX <= hashX; tileX++)
        {
            for (var tileY:int = hashY; tileY <= hashY; tileY++)
            {
                addTileIfNeeded(tileX, tileY);
            }
        }
    }

    private function addTileIfNeeded(tileX:int, tileY:int):void {
        var hash:String = getHash(tileX, tileY);
        if(hash in tiles)
        {
            newTiles[hash] = tiles[hash];
            delete tiles[hash];
        }
        else
        {
            newTiles[hash] = addTile(tileX, tileY);
        }
    }

    private function addTile(tileX:int, tileY:int):IDisplayObject {
        var _x:Number = getX(tileX, newTileWidth);
        var _y:Number = getY(tileY, newTileHeight);
        return renderer.addBackGround(_x, _y, newTileWidth, newTileHeight, String(ratio));
    }

    private function calculateNewValues():void {
        var newWidthToZoom:Number = (width / zoom);

        var _ratio:Number = newWidthToZoom / baseTileWidth;
        ratio = (_ratio) / gridSize + 1;

        newTileWidth = baseTileWidth * Math.pow(gridSize, ratio);
        newTileHeight = baseTileHeight * Math.pow(gridSize, ratio);

        hashX = getHashX(newTileWidth);
        hashY = getHashY(newTileHeight);

        newHash = getHash(hashX, hashY);
    }

    private function getHashY(_tileHeight:Number):int {
        return (y+(y/Math.abs(y))*(height*zoom/2)) / (_tileHeight * zoom);
    }

    private function getHashX(_tileWidth:Number):int {
        return (x+(x/Math.abs(x))*(width*zoom/2)) / (_tileWidth * zoom);
    }

    private function debug():void {
        if(false)
        {
            Cc.log("DynamicBackground.ratio: " + ratio);
            Cc.log("DynamicBackground.behavior: (x,y) " + x + " , " + y);
            Cc.log("DynamicBackground.behavior: (hashX,hashY) " + hashX + " , " + hashY);
            Cc.log("DynamicBackground.behavior: (width,height) " + width + " , " + height);
            Cc.log("DynamicBackground.behavior: (zoom) " + zoom);
            Cc.log("DynamicBackground.behavior: _tileWidth" + newTileWidth);
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

    private function getHash(tileX:int, tileY:int):String
    {
        return tileX + " " + tileY;
    }
}
}

internal class TileDimensions
{
    public var tileWidth:Number = 1;
    public var tileHeight:Number = 1;
}