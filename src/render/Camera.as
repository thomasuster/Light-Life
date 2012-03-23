package render
{
    import flash.utils.Dictionary;

    /**
     * Composite camera. 
     */    
    public class Camera implements ICamera
    {
        private var cameras:Dictionary = new Dictionary();
        
        public function Camera()
        {
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