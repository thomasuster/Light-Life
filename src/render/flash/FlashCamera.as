package render.flash
{
    import flash.display.DisplayObject;
    
    import game.WorldManager;
    
    import render.ICamera;
    
    public class FlashCamera implements ICamera
    {
        private var camera:DisplayObject;
        private var _x:Number = 0;
        private var _y:Number = 0;
        
        public function FlashCamera(camera:DisplayObject)
        {
            this.camera = camera; 
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