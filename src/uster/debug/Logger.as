package uster.debug
{
	/**
	 * Singleton for logging.
	 *  
	 * @author Thomas Uster
	 * 
	 */	
	public class Logger
	{
		private static var _enforcer:* = {};
		private static var _instance:Logger = new Logger(_enforcer);
		private var _log:Vector.<Log> = new Vector.<Log>;
		
		public function Logger(enforcer:Object)
		{
			if(_enforcer != enforcer)
			{
				throw new Error("Logger is a Singleton, use Logger.instance");
			}
		}
		
		public static function get instance():Logger
		{
			return _instance;
		}
		
		public function log(string:String):void
		{
			trace(string);
			_log.push(new Log(string, "log"));
		}
		
		public function warn(string:String):void
		{
			trace(string);
			_log.push(new Log(string, "warn"));
		}
		
		public function error(string:String):void
		{
			trace(string);
			_log.push(new Log(string, "error"));
		}
	}
}