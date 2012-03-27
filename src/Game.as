package 
{
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2DebugDraw;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2World;
	
	import General.FpsCounter;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import game.WorldManager;
	import game.entities.IEntity;
	import game.entities.fixture.Fixture;
	import game.entities.fixture.IFixture;
	import game.entities.fixture.decorator.CameraFollow;
	import game.entities.fixture.decorator.DynamicBackground;
	import game.entities.fixture.decorator.KeyboardMove;
	import game.entities.fixture.decorator.MouseLook;
	
	import render.CameraComposite;
	import render.ICamera;
	import render.IRenderFactory;
	import render.IRenderer;
	import render.flash.FlashCamera;
	import render.starling.StarlingCamera;
	import render.starling.StarlingRenderFactory;
	import render.starling.decorator.HeroDecorator;
	import render.starling.decorator.StarlingRenderer;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class Game extends Sprite
	{
        //public static var sprite2D:flash.display.Sprite;
        
		private var controls:Controls = new Controls();

		private var worldManager:WorldManager;

		private var hero:IFixture;

		private var flashContainer:flash.display.Sprite = new flash.display.Sprite();

		private var mouseFixture:b2Fixture;

		private var background:DynamicBackground;

		public function Game()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		private function onAdded ( e:Event ):void
		{
            Starling.current.nativeStage.addChild(flashContainer);
            worldManager = new WorldManager(flashContainer)
                
			// we listen to the mouse movement on the stage
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			// need to comment this one ? ;)q
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
            
            controls.init(stage, Starling.current.nativeStage);
            
            
            //creating stuff
            {
                worldManager.createBounds();
                var fixture:b2Fixture = worldManager.createFixture(0, 0, 100, 100, b2Body.b2_dynamicBody);
    
                mouseFixture = worldManager.createFixture(0, 0, 50, 50);
                
                var flashCamera:FlashCamera = new FlashCamera(flashContainer);
                var starlingCamera:StarlingCamera = new StarlingCamera(this);
                var cameraComposite:render.CameraComposite = new render.CameraComposite();
                cameraComposite.add(flashCamera);
                cameraComposite.add(starlingCamera);
                cameraComposite.width = LightLife.WIDTH;
                cameraComposite.height = LightLife.HEIGHT;
                
                var mouseRotation:MouseLook = new MouseLook(controls, cameraComposite);
                var controledMovement:KeyboardMove = new KeyboardMove(controls);
                var cameraFollow:CameraFollow = new CameraFollow(cameraComposite);
                cameraFollow.add(mouseRotation);
                mouseRotation.add(controledMovement);
                controledMovement.add(new Fixture(fixture));
                
                hero = cameraFollow;
            }
            
            //var camera:ICamera = background;
            
            //Rendering
            {
                var renderer:IRenderer = new StarlingRenderer(this);
                background = new DynamicBackground(renderer);
                background.add(cameraComposite);
                
                hero = renderer.addDrawHero(hero);
            }
            
            worldManager.enableDebug();
		}
        
        private function onFrame (e:Event):void
		{
            worldManager.update();
            background.update();
            hero.update();
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
	}
}