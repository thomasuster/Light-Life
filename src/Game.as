package
{
    import Box2D.Common.Math.b2Vec2;

    import com.junkbyte.console.Cc;

    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;

    import game.entities.camera.decorator.LeanRenderedBackground;
    import game.entities.fixture.IFixtureEntity;
    import game.entities.fixture.WorldManager;

    import render.Assets;

    import render.CameraComposite;
    import render.ICamera;
    import render.flash.FlashCamera;
    import render.starling.StarlingCamera;
    import render.starling.decorator.StarlingRenderer;

    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;

    public class Game extends Sprite
    {
        private var controls:Controls = new Controls();
        private var worldManager:WorldManager;
        private var hero:IFixtureEntity;
        private var flashContainer:flash.display.Sprite = new flash.display.Sprite();
        private var badGuy:IFixtureEntity;
        private var camera:ICamera;
        private var background:LeanRenderedBackground;

        public function Game()
        {
            //Console integration
            Cc.config.style.backgroundColor = 0x000000;
            Cc.config.commandLineAllowed = true // Enables full commandLine features
            Cc.config.tracing = true; // also send traces to flash's normal trace()
            Cc.config.maxLines = 2000; // change maximum log lines to 2000, default is 1000
            Cc.config.rememberFilterSettings = true;
            Cc.startOnStage(flashContainer, "`");
            Cc.addMenu("Debug Draw", debugDraw);
            Cc.width = LightLife.WIDTH;
            Cc.height = 1/(1.61*2) * LightLife.HEIGHT;

            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        private function debugDraw():void
        {
            worldManager.toggleDebug();
        }

        private function onAdded ( e:Event ):void
        {
            setEventListeners();
            initControls();
            initRendering();
            addConsoleCommands();
        }

        private function initRendering():void
        {
            var renderer:StarlingRenderer = addRendering();
            var cameraComposite:CameraComposite = create();
            addBackground(renderer, cameraComposite);
        }

        private function initControls():void
        {
            controls.init(stage, Starling.current.nativeStage);
            controls.addEventListener(MouseEvent.MOUSE_WHEEL, controls_mouseWheelHandler);
        }

        private function addRendering():StarlingRenderer
        {
            var renderer:StarlingRenderer = new StarlingRenderer();
            renderer.container = this;
            renderer.assets = new Assets();
            renderer.init();
            Starling.current.nativeStage.addChild(flashContainer);
            worldManager = new WorldManager(flashContainer, renderer)
            return renderer;
        }

        private function setEventListeners():void
        {
            stage.addEventListener(TouchEvent.TOUCH, onTouch);
            stage.addEventListener(Event.ENTER_FRAME, onFrame);
        }

        private function addConsoleCommands():void
        {
            Cc.addSlashCommand("spawnBadGuy", worldManager.createBadGuy);
            Cc.commandLine = true;
        }

        private function create():CameraComposite
        {
            worldManager.createBounds();
            var flashCamera:FlashCamera = new FlashCamera(flashContainer);
            var starlingCamera:StarlingCamera = new StarlingCamera(this);
            var cameraComposite:CameraComposite;
            cameraComposite = new CameraComposite();
            cameraComposite.add(flashCamera);
            cameraComposite.add(starlingCamera);
            cameraComposite.width = LightLife.WIDTH;
            cameraComposite.height = LightLife.HEIGHT;

            hero = worldManager.createHero(controls, cameraComposite, this);
            for (var i:int = 0; i < 7; i++)
            {
                //                badGuy = worldManager.createBadGuy();
            }
            return cameraComposite;
        }

        private function addBackground(renderer:StarlingRenderer, cameraComposite:CameraComposite):void
        {
            background = new LeanRenderedBackground().setFactory(renderer);
            background.add(cameraComposite);
            camera = background;
        }

        private function controls_mouseWheelHandler(event:MouseEvent):void
        {
            var value:Number = camera.zoom+=(event.delta*0.01);
            if(value < 0)
            {
                value = 0.001;
            }
            camera.zoom = value;
        }

        private function onFrame (e:Event):void
        {
            worldManager.update();
            background.update();
        }

        private function onTouch(e:TouchEvent):void
        {
            // get the mouse location related to the stage
            var touch:Touch = e.getTouch(stage);
            var pos:Point = touch.getLocation(stage);
            // store the mouse coordinates
            controls.mouseX = pos.x;
            controls.mouseY = pos.y;
        }

        public function cameraToWorld(x:Number, y:Number):b2Vec2
        {
            return new b2Vec2((x + camera.x - LightLife.WIDTH/2) / (WorldManager.SCALE * camera.zoom), (y + camera.y - LightLife.HEIGHT/2) / (WorldManager.SCALE * camera.zoom));
        }
    }
}