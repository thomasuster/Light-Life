package
{
    import starling.display.Stage;
    import starling.events.KeyboardEvent;

	/**
	 * LightLife Game Controller. 
	 */	
	public class Controls
	{
        private var _left:Boolean;
        private var _right:Boolean;
        private var _up:Boolean;
        private var _down:Boolean;
        
		public function Controls()
		{
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

        public function init(stage:Stage):void
        {
            stage.addEventListener(KeyboardEvent.KEY_UP, stage_keyUpHandler);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, stage_keyDownHandler);
        }
        
        private function stage_keyDownHandler(event:KeyboardEvent):void
        {
            changeKey(event.charCode, true);
        }
        
        private function stage_keyUpHandler(event:KeyboardEvent):void
        {
            changeKey(event.charCode, false);
        }
        
        private function changeKey(charCode:uint, keyUp:Boolean):void
        {
            switch(charCode)
            {
                case 119:
                {
                    _up = keyUp;
                    break;
                }
                case 97:
                {
                    _left = keyUp;
                    break;
                }
                case 115:
                {
                    _down = keyUp;
                    break;
                }
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
            trace("Controls.changeKey(charCode, keyUp)");
            trace("_up: " + _up);
            trace("_down: " + _down);
            trace("_left: " + _left);
            trace("_right: " + _right);
        }
    }
}