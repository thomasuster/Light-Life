package game.entities.camera.decorator
{
import render.ICamera;

public class ACameraDecorator implements ICameraDecorator
    {
        protected var decoratedCamera:ICamera;
        
        public function ACameraDecorator()
        {
        }
        
        public function add(decoratedCamera:ICamera):void
        {
            this.decoratedCamera = decoratedCamera;   
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
            decoratedCamera.zoom = value;
        }
        
        public function get zoom():Number
        {
            return decoratedCamera.zoom;
        }
        
        public function get height():Number
        {
            return decoratedCamera.height;
        }
        
        public function set height(value:Number):void
        {
            decoratedCamera.height = value;
        }
        
        public function get width():Number
        {
            return decoratedCamera.width;
        }
        
        public function set width(value:Number):void
        {
            decoratedCamera.width = value;
        }
        
        public function get y():Number
        {
            return decoratedCamera.y;
        }
        
        public function set y(value:Number):void
        {
            decoratedCamera.y = value;
        }
        
        public function get x():Number
        {
            return decoratedCamera.x;
        }
        
        public function set x(value:Number):void
        {
            decoratedCamera.x = x;
        }
    }
}