package uster.display.assetManager
{
import flash.display.Loader;
import flash.net.URLRequest;

import uster.debug.Logger;

internal class LoadCommand
	{
		public var loader:Loader;
		public var urlRequest:URLRequest;
		
		private var logger:Logger;
		
		public function LoadCommand(loader:Loader, urlRequest:URLRequest):void
		{
			this.loader = loader;
			this.urlRequest = urlRequest;
		}
		
		public function execute():void
		{
			loader.load(urlRequest);
		}
	}
}