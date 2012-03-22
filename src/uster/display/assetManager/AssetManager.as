package uster.display.assetManager
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import uster.debug.Logger;
	
	/**w
	 * Singleton for loading and retrieving assets.
	 * 
	 * Assets can be anything from SWF files or image (JPG, PNG, or GIF) files.
	 *  
	 * @author Thomas Uster
	 */	
	public class AssetManager extends EventDispatcher
	{
		private static var _enforcer:Object = {};
		private static var _instance:AssetManager = new AssetManager(_enforcer);
		
		private var loaders:* = {};
		private var loadersComplete:* = {};
		
		private var loadCommands:Vector.<LoadCommand> = new Vector.<LoadCommand>;
		private var logger:Logger = Logger.instance;
		private var loading:Boolean = false;
		
		private var getAssetCommands:*/* url->ICommands */ = {};
		
		public function AssetManager(enforcer:Object)
		{
			if(enforcer != _enforcer)
			{
				throw new Error("AssetManager is a Singleton, use AssetManager.instance");
			}
		}
		
		public static function get instance():AssetManager
		{
			return _instance;
		}
		
		/**
		 * Queue up a url for an asset to load.
		 * @param url
		 * 
		 */		
		public function load(url:String):void
		{
			if(!(url in loaders))
			{
				var loader:Loader = new Loader();
				var urlRequest:URLRequest = new URLRequest(url);
				loaders[url] = loader;
				queue(loader, urlRequest);
			}
			else
			{
				logger.log("AssetManager: " + url + " already loading.");
			}
		}
		
		/**
		 * Get an asset from the library of a specified url. 
		 * @param url
		 * @param name
		 */		
		public function getAssetFromLibrary(url:String, name:String):Object
		{
			return _getAsset("AssetFromLibrary", url, name);
		}
		
		/**
		 * Get an asset from the library of a specified url. 
		 * @param url
		 * @param name
		 */		
		public function getDefinitionFromLibrary(url:String, name:String):Object
		{
			return _getAsset("AssetFromLibrary", url, name);
		}
		
		/**
		 * Get a raw asset.
		 * @param url
		 * @param name
		 * 
		 */		
		public function getAsset(url:String):Object
		{
			return _getAsset("Raw", url, "");
		}
		
		/**
		 * Get an asset from the library of a specified url. 
		 * @param url
		 * @param name
		 * 
		 */		
		public function getAssetFromStage(url:String, path:String):Object
		{
			return _getAsset("AssetFromStage", url, path);
		}
		
		private function _getAsset(type:String, url:String, string:String):Object
		{
			if(url in loadersComplete)
			{
				var loader:Loader = loadersComplete[url];
				switch(type)
				{
					case "AssetFromStage":
						
						var path:String = string;
						var displayObject:DisplayObject = loader.content;
						var names:Array = path.split(".");
						
						try
						{
							for (var i:int = 0; i < names.length ; i++)
							{
								var name:String = names[i];
								displayObject = displayObject[name];
							}
						}
						catch(error:Error)
						{
							logger.error("AssetManager: " + path + "invalid, only got to " + name + " returning null");
							return null;
						}
						return displayObject;
						
					case "AssetFromLibrary":
						
						var _Class:Class = Class(loader.contentLoaderInfo.applicationDomain.getDefinition(name));
						var object:Object = new _Class();
						return object;
						
					case "DefinitionFromLibrary":
						
						_Class = Class(loader.contentLoaderInfo.applicationDomain.getDefinition(name));
						return _Class;
					
					case "Raw":
						return loader.content;
						
				}
			}
			logger.error("AssetManager: " + url + " not yet loaded, returning null.");
			return null;
		}
		
		private function queue(loader:Loader, urlRequest:URLRequest):void
		{
			loadCommands.push(new LoadCommand(loader, urlRequest));
			if(loading)
			{
				logger.log("AssetManager: Currently loading " + loadCommands[0].loader.contentLoaderInfo.url 
					       + ", queueing " + loader.contentLoaderInfo.url + ".");
			}
			else
			{
				var loader:Loader = loadCommands[0].loader;
				with(loader.contentLoaderInfo)
				{
					addEventListener(IOErrorEvent.IO_ERROR, loader_ioErrorHandler);
					addEventListener(ProgressEvent.PROGRESS, loader_progressHandler);
					addEventListener(Event.COMPLETE, loader_completeHandler);
				}
				loadCommands[0].execute();
			}
		}
		
		private function getProgressEvent():ProgressEvent
		{
			var progressEvent:ProgressEvent = new ProgressEvent(ProgressEvent.PROGRESS);
			var bytesLoaded:int = 0;
			var bytesTotal:int = 0;
			for each(var loader:Loader in loaders)
			{
				bytesLoaded += loader.contentLoaderInfo.bytesLoaded;
				bytesTotal += loader.contentLoaderInfo.bytesTotal;
			}
			progressEvent.bytesLoaded = bytesLoaded;
			progressEvent.bytesTotal = bytesTotal;
			return progressEvent;
		}
		
		private function loader_ioErrorHandler(event:IOErrorEvent):void
		{
			IEventDispatcher(event.target).removeEventListener(IOErrorEvent.IO_ERROR, loader_ioErrorHandler);
			logger.error("AssetManager: " + event.toString() + ", check " + loadCommands[0].urlRequest.url);
		}
		
		private function loader_progressHandler(event:ProgressEvent):void
		{
			IEventDispatcher(event.target).removeEventListener(ProgressEvent.PROGRESS, loader_progressHandler);
			dispatchEvent(getProgressEvent());
		}
		
		private function loader_completeHandler(event:Event):void
		{
			IEventDispatcher(event.target).removeEventListener(Event.COMPLETE, loader_completeHandler);
			var loadCommand:LoadCommand = loadCommands.shift(); 
			var url:String = loadCommand.urlRequest.url;
			delete loaders[url];
			loadersComplete[url] = loadCommand.loader;
			var progressEvent:ProgressEvent = getProgressEvent();
			if(progressEvent.bytesLoaded == progressEvent.bytesTotal)
			{
				dispatchEvent(new Event(Event.COMPLETE));	
			}
			else if (progressEvent.bytesLoaded > progressEvent.bytesTotal)
			{
				logger.error("AssetManager: bytesLoaded > bytesTotal");
			}
			else
			{
				logger.log("AssetManager: " + LoaderInfo(event.target).url + " finished loading.");
			}
		}
	}
}