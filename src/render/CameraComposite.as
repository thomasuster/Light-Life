package render
{
    import flash.utils.Dictionary;

    /**
     * Composite camera. 
     */    
    public class CameraComposite implements ICamera
    {
        private var cameras:Dictionary = new Dictionary();
        private var _width:Number;
        private var _height:Number;
        
        public function CameraComposite()
        {
        }
        
        public function set zoom(value:Number):void
        {
            for each (var camera:ICamera in cameras) 
            {
                camera.zoom = value;
            }
        }
        
        public function get zoom():Number
        {
            for each (var camera:ICamera in cameras) 
            {
                return camera.zoom;
            }
            return 0;
        }
        
        public function get height():Number
        {
            return _height;
        }

        public function set height(value:Number):void
        {
            _height = value;
            for each (var camera:ICamera in cameras) 
            {
                camera.height = value;
            }
        }

        public function get width():Number
        {
            return _width;
        }

        public function set width(value:Number):void
        {
            _width = value;
            for each (var camera:ICamera in cameras) 
            {
                camera.width = value;
            }
        }

        public function add(camera:ICamera):void
        {
            cameras[camera] = camera;
        }
        
        public function remove(camera:ICamera):void
        {
            delete cameras[camera];
        }
        
        public function get y():Number
        {
            for each (var camera:ICamera in cameras) 
            {
                return camera.y;
            }
            return 0;
        }
        
        public function set y(value:Number):void
        {
            for each (var camera:ICamera in cameras) 
            {
                camera.y = value;
            }
        }
        
        public function get x():Number
        {
            for each (var camera:ICamera in cameras) 
            {
                return camera.x;
            }
            return 0;
        }

        public function set x(value:Number):void
        {
            for each (var camera:ICamera in cameras) 
            {
                camera.x = value;
            }
        }

    }
}