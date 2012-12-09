package render.starling
{
import render.IDisplayObject;

import starling.display.DisplayObject;

public class StarlingDisplayObject implements IDisplayObject
    {
        private var displayObject:DisplayObject;
        
        public function StarlingDisplayObject(displayObject:DisplayObject)
        {
            this.displayObject = displayObject;
        }
        
        public function get height():Number
        {
            return displayObject.height;
        }
        
        public function set height(value:Number):void
        {
            displayObject.height = value;
        }
        
        public function get width():Number
        {
            return displayObject.width;
        }
        
        public function set width(value:Number):void
        {
            displayObject.width = value;
        }
        
        public function get y():Number
        {
            return displayObject.y;
        }
        
        public function set y(value:Number):void
        {
            displayObject.y = value;
        }
        
        public function get x():Number
        {
            return displayObject.x;
        }
        
        public function set x(value:Number):void
        {
            displayObject.x = value;
        }
    }
}