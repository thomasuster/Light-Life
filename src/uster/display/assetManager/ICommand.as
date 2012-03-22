package uster.display.assetManager
{
	/**
	 * Internal class for queuing up load requests and asset requests.
	 *  
	 * @author Thomas Uster
	 * 
	 */	
	internal interface ICommand
	{
		public function execute():void;
	}
}