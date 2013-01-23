package
{
    import General.FpsCounter;

    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.ProgressEvent;

    import game.GameStarter;

    import starling.core.Starling;

    import uster.display._2D.progress.ProgressBar;
    import uster.display.assetManager.AssetManager;

    [SWF(width="1024", height="768", frameRate="60", backgroundColor="#000000")]
    public class LightLife extends Sprite
    {
		private var assetManager:AssetManager = AssetManager.instance;
		private var progressBar:ProgressBar;
		private var loader:Loader;
		private var splash:MovieClip;
		private var mStarling:Starling;
        private var fpsCounter:FpsCounter = new FpsCounter();
        
        public static const WIDTH:int = 1024;
        public static const HEIGHT:int = 768;

        public function LightLife()
        {
            var square:Sprite = new Sprite();
            addChild(square);
            square.graphics.lineStyle(1,0x00ff00);
            square.graphics.beginFill(0x0000FF);
            square.graphics.drawRect(0,0,WIDTH,100);
            square.graphics.endFill();
            /*square.x = stage.stageWidth/2-square.width/2;
            square.y = stage.stageHeight/2-square.height/2;*/
            square.y = stage.stageHeight - 5;
            
            splash = MovieClip(new EmbeddedAssets.Splash());  
			loader = Loader(splash.getChildAt(0));
            
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_completeHandler);
        }
        
        public function spawnBadGuy():void
        {
            trace("local_var: !");
        }
        
		private function loader_completeHandler(event:Event):void
		{
			loader.removeEventListener(Event.COMPLETE, loader_completeHandler);
			this.addChild(splash);
			progressBar = new ProgressBar(MovieClip(loader.content)['progress']);
			assetManager.addEventListener(ProgressEvent.PROGRESS, assetManager_progressHandler);
			assetManager.addEventListener(Event.COMPLETE, assetManager_completeHandler);
			assetManager.load("../media/assets/UI.swf");
		}
        
		
		private function assetManager_progressHandler(event:ProgressEvent):void
		{
			progressBar.setProgression(event.bytesLoaded / event.bytesTotal);
		}
		
		private function assetManager_completeHandler(event:Event):void
		{
			assetManager.removeEventListener(ProgressEvent.PROGRESS, assetManager_completeHandler);
			assetManager.removeEventListener(Event.COMPLETE, assetManager_progressHandler);
			progressBar.setProgression(0.5);
			this.removeChild(splash);
			init();
		}
		
		public function init():void
		{
			addChild(DisplayObject(assetManager.getAsset("../media/assets/UI.swf")));
            addEventListener(Event.ENTER_FRAME, enterFrameHandler);
            
            //FPS Counter
            fpsCounter.x = 7;
            fpsCounter.y = 5;
            addChildAt(fpsCounter, 0);
			
			//Starling Init
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
            
            var nativeOverlay:Sprite = new Sprite();
            addChild(nativeOverlay);
            //Game.sprite2D = nativeOverlay;
            
			// create our Starling instance
			mStarling = new Starling(GameStarter, stage);
            
			// set anti-aliasing (higher is better quality but slower performance)
			mStarling.antiAliasing = 1;
			
			// start it!
			mStarling.start();
		}
        
        private function enterFrameHandler(event:Event):void
        {
            fpsCounter.update();
        }
    }
}