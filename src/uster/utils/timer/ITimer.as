package uster.utils.timer
{
import flash.events.IEventDispatcher;

public interface ITimer extends IEventDispatcher
	{
		function reset():void;
		function start():void;
		function stop():void;
		function get currentCount():int;
		
		function set delay(value:Number):void;
		function get delay():Number;
		
		function set repeatCount(value:int):void;
		function get repeatCount():int;
		
		function get running():Boolean;
	}
}