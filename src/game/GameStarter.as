package game
{
    import Box2D.Common.Math.b2Vec2;

    import com.junkbyte.console.Cc;

    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Point;

    import game.entities.camera.decorator.LeanRenderedBackground;
    import game.entities.fixture.IFixtureEntity;
    import game.entities.fixture.WorldFactory;

    import render.Assets;
    import render.CameraComposite;
    import render.ICamera;
    import render.flash.FlashCamera;
    import render.starling.StarlingCamera;
    import render.starling.decorator.StarlingRenderer;

    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;

    public class GameStarter extends Sprite
    {
        public var starlingStage:StarlingStageProxy;
        public var renderer:StarlingRenderer = new StarlingRenderer();
        public var worldFactory:WorldFactory = new WorldFactory();

        private var controls:Controls = new Controls();
        private var hero:IFixtureEntity;
        private var camera:ICamera;
        private var background:LeanRenderedBackground;

        private var flashContainer:flash.display.Sprite = new flash.display.Sprite();
        public var flashStage:FlashStageProxy;

        public function GameStarter()
        {
            starlingStage = new StarlingStageProxy(this);
            flashStage = new FlashStageProxy();

            CcConfig.config(flashContainer, debugDraw);

            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        private function debugDraw():void
        {
            worldFactory.toggleDebug();
        }

        private function onAdded (e:Event):void
        {
            setEventListeners();
            initControls();
            initRendering();
            addConsoleCommands();
        }

        private function initRendering():void
        {
            configureRenderer();
            var cameraComposite:CameraComposite = create();
            addBackground(renderer, cameraComposite);
        }

        private function initControls():void
        {
            controls.init(starlingStage.getStage(), flashStage.getStage());
            controls.addEventListener(MouseEvent.MOUSE_WHEEL, controls_mouseWheelHandler);
        }

        private function configureRenderer():void
        {
            renderer.container = this;
            renderer.assets = new Assets();
            renderer.init();

            flashStage.getStage().addChild(flashContainer);

            worldFactory.renderer = renderer;
            worldFactory.sprite2D = flashContainer;
            worldFactory.createWorld();
        }

        private function setEventListeners():void
        {
            starlingStage.getStage().addEventListener(TouchEvent.TOUCH, onTouch);
            starlingStage.getStage().addEventListener(Event.ENTER_FRAME, onFrame);
        }

        private function addConsoleCommands():void
        {
            Cc.addSlashCommand("spawnBadGuy", worldFactory.createBadGuy);
            Cc.commandLine = true;
        }

        private function create():CameraComposite
        {
            worldFactory.createBounds();
            var flashCamera:FlashCamera = new FlashCamera(flashContainer);
            var starlingCamera:StarlingCamera = new StarlingCamera(this);
            var cameraComposite:CameraComposite;
            cameraComposite = new CameraComposite();
            cameraComposite.add(flashCamera);
            cameraComposite.add(starlingCamera);
            cameraComposite.width = LightLife.WIDTH;
            cameraComposite.height = LightLife.HEIGHT;

            hero = worldFactory.createHero(controls, cameraComposite, this);
            for (var i:int = 0; i < 50; i++)
            {
                worldFactory.createBadGuy();
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
            worldFactory.update();
            background.update();
        }

        private function onTouch(e:TouchEvent):void
        {
            var touch:Touch = e.getTouch(stage);
            var pos:Point = touch.getLocation(stage);
            controls.mouseX = pos.x;
            controls.mouseY = pos.y;
        }

        public function cameraToWorld(x:Number, y:Number):b2Vec2
        {
            return new b2Vec2((x + camera.x - LightLife.WIDTH/2) / (WorldFactory.SCALE * camera.zoom), (y + camera.y - LightLife.HEIGHT/2) / (WorldFactory.SCALE * camera.zoom));
        }
    }
}