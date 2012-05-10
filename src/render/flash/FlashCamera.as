package render.flash
{
    import flash.display.DisplayObject;
    
    import game.entities.fixture.FixtureManager;
    
    import render.ICamera;
    
    public class FlashCamera implements ICamera
    {
        private var camera:DisplayObject;
        private var _x:Number = 0;
        private var _y:Number = 0;
        private var _width:Number = 0;
        private var _height:Number = 0;
        
        public function FlashCamera(camera:DisplayObject)
        {
            this.camera = camera; 
        }
        
        public function get height():Number
        {
            return _height;
        }
        
        public function set height(value:Number):void
        {
            _height = value;
        }
        
        public function get width():Number
        {
            return _width;
        }
        
        public function set width(value:Number):void
        {
            _width = value;
        }
        
        public function get y():Number
        {
            return _y;
        }
        
        public function set y(value:Number):void
        {
            _y = value;
            camera.y = -1 * value + LightLife.HEIGHT / 2;
        }
        
        public function get x():Number
        {
            return _x;
        }
        
        public function set x(value:Number):void
        {
            _x = value;
            camera.x = -1 * value + LightLife.WIDTH / 2;
        }
    }
}