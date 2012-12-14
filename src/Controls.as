package
{
    import flash.display.Stage;
    import flash.events.EventDispatcher;
    import flash.events.MouseEvent;

    import starling.display.Stage;
    import starling.events.KeyboardEvent;

    /**
	 * LightLife Game Controller. 
	 */	
	public class Controls extends EventDispatcher
	{
        private var _left:Boolean;
        private var _right:Boolean;
        private var _up:Boolean;
        private var _down:Boolean;
        
        private var _mouseX:Number = 0;
        private var _mouseY:Number = 0;
        private var _rightMouseDown:Boolean;
        private var _mouseDown:Boolean;
        
		public function Controls()
		{
		}
        
        public function get mouseDown():Boolean
        {
            return _mouseDown;
        }
        
        public function get rightMouseDown():Boolean
        {
            return _rightMouseDown;
        }
        
        public function get mouseY():Number
        {
            return _mouseY;
        }

        public function set mouseY(value:Number):void
        {
            _mouseY = value;
        }

        public function get mouseX():Number
        {
            return _mouseX;
        }

        public function set mouseX(value:Number):void
        {
            _mouseX = value;
        }

        public function get down():Boolean
        {
            return _down;
        }

        public function get up():Boolean
        {
            return _up;
        }

        public function get right():Boolean
        {
            return _right;
        }

        public function get left():Boolean
        {
            return _left;
        }
        
        public function init(stage:starling.display.Stage, flashStage:flash.display.Stage):void
        {
            stage.addEventListener(KeyboardEvent.KEY_UP, stage_keyUpHandler);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_keyDownHandler);
            
            flashStage.addEventListener(MouseEvent.MOUSE_DOWN, flashStage_mouseDownHandler);
            flashStage.addEventListener(MouseEvent.MOUSE_UP, flashStage_mouseUpHandler);
            flashStage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, flashStage_rightMouseDownHandler);
            flashStage.addEventListener(MouseEvent.RIGHT_MOUSE_UP, flashStage_rightMouseUpHandler);
            
            flashStage.addEventListener(MouseEvent.MOUSE_WHEEL, flashStage_mouseWheelHandler);
        }
        
        private function flashStage_mouseWheelHandler(event:MouseEvent):void
        {
            dispatchEvent(event);
        }
        
        private function flashStage_rightMouseDownHandler(event:MouseEvent):void
        {
            _rightMouseDown = true;
        }
        
        private function flashStage_rightMouseUpHandler(event:MouseEvent):void
        {
            _rightMouseDown = false;
        }
        
        private function flashStage_mouseDownHandler(event:MouseEvent):void
        {
            _mouseDown = true;
        }
        
        private function flashStage_mouseUpHandler(event:MouseEvent):void
        {
            _mouseDown = false;
        }
        
        private function stage_keyDownHandler(event:KeyboardEvent):void
        {
            changeKey(event.charCode, true);
        }
        
        private function stage_keyUpHandler(event:KeyboardEvent):void
        {
            changeKey(event.charCode, false);
        }
        
        public function getXDir():int
        {
            return getDir(left, right);
        }
        
        public function getYDir():int
        {
            return getDir(up, down);
        }
        
        private function getDir(negative:Boolean, positive:Boolean):int
        {
            if(negative && !positive)
            {
                return -1;
            }
            else if(!negative && positive)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
        
        private function changeKey(charCode:uint, keyUp:Boolean):void
        {
            switch(charCode)
            {
                case 87:
                case 119:
                {
                    _up = keyUp;
                    break;
                }
                case 65:
                case 97:
                {
                    _left = keyUp;
                    break;
                }
                case 83:
                case 115:
                {
                    _down = keyUp;
                    break;
                }
                case 68:
                case 100:
                {
                    _right = keyUp;
                    break;
                }
                default:
                {
                    break;
                }
            }
            /*trace("Controls.changeKey(charCode, keyUp)");
            trace("_up: " + _up);
            trace("_down: " + _down);
            trace("_left: " + _left);
            trace("_right: " + _right);*/
        }
    }
}