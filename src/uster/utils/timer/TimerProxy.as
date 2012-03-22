package uster.utils.timer
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * A Proxy for the Adobe Timer Class. All Timer's delegate to one Adobe Timer class for actual Events to allow
	 * for time manipulation.
     * 
     * @events
     * 
     * 
	 * @author Thomas Uster
	 * 
	 */	
	public class TimerProxy extends EventDispatcher implements ITimer
	{
        private static var timer:flash.utils.Timer = new flash.utils.Timer(TIMER_DELAY, 0);
        private var count:int;
        private var countRatio:int;
        private var _currentCount:int;
        private var _delay:Number;
        private var _repeatCount:int;
        private var _running:Boolean;
        
        private static const TIMER_DELAY:Number = 20;
        
        /**
         * 
         * @param delay Delay should be >= 20(ms).
         * @param repeatCount
         * 
         */        
		public function TimerProxy(delay:Number, repeatCount:int = 0)
		{
            reset();
            this.delay = delay;
            _repeatCount = repeatCount;
		}
		
		public function reset():void
		{
            timer.removeEventListener(TimerEvent.TIMER, timer_timerHandler);
            _currentCount = 0;
            _running = false;
            count = 0;
		}
		
		public function start():void
		{
            _running = true;
            timer.addEventListener(TimerEvent.TIMER, timer_timerHandler);
            if(!timer.running)
            {
                timer.start();
            }
		}
		
		public function stop():void
		{
            timer.removeEventListener(TimerEvent.TIMER, timer_timerHandler);
            _running = false;
            if(!timer.hasEventListener(TimerEvent.TIMER))
            {
                timer.stop();
            }
		}
        
        private function timer_timerHandler(event:Event):void
        {
            count++;
            if(count >= countRatio)
            {
                count = 0;
                _currentCount++;
                dispatchEvent(new TimerEvent(TimerEvent.TIMER));
                if(repeatCount != 0 &&
                   _currentCount >= repeatCount)
                {
                    stop();
                    dispatchEvent(new TimerEvent(TimerEvent.TIMER_COMPLETE));
                }
            }
        }
		
		public function get currentCount():int
		{
            return _currentCount;
		}
		
		public function set delay(value:Number):void
        {
            _delay = value;
            countRatio = Math.round(_delay / TIMER_DELAY);
        }
		public function get delay():Number
        {
            return _delay;
        }
		
		public function set repeatCount(value:int):void
        {
            _repeatCount = value;
        }
		public function get repeatCount():int
        {
            return _repeatCount;
        }
		
		public function get running():Boolean
        {
            return _running;
        }
	}
}