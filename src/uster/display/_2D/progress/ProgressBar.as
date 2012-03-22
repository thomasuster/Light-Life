package uster.display._2D.progress
{
	import flash.display.DisplayObject;

	public class ProgressBar implements IProgress
	{
		private var displayObject:DisplayObject;
		private var width:Number;
		
		public function ProgressBar(displayObject:DisplayObject)
		{
			this.displayObject = displayObject;
			width = displayObject.width;
		}
		
		public function setProgression(progression:Number):void
		{
			displayObject.width = width*progression;
		}
	}
}