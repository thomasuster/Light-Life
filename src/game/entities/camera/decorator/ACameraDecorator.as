package game.entities.camera.decorator
{
    import render.ICamera;

    public class ACameraDecorator implements ICameraDecorator
    {
        protected var camera:ICamera;
        
        public function add(decoratedCamera:ICamera):void
        {
            this.camera = decoratedCamera;
        }
        
        public function update():void
        {
            behavior();
        }
        
        /**
         * Template method 
         */        
        protected function behavior():void
        {
            
        }
        
        public function set zoom(value:Number):void
        {
            camera.zoom = value;
        }
        
        public function get zoom():Number
        {
            return camera.zoom;
        }
        
        public function get height():Number
        {
            return camera.height;
        }
        
        public function set height(value:Number):void
        {
            camera.height = value;
        }
        
        public function get width():Number
        {
            return camera.width;
        }
        
        public function set width(value:Number):void
        {
            camera.width = value;
        }
        
        public function get y():Number
        {
            return camera.y;
        }
        
        public function set y(value:Number):void
        {
            camera.y = value;
        }
        
        public function get x():Number
        {
            return camera.x;
        }
        
        public function set x(value:Number):void
        {
            camera.x = x;
        }
    }
}