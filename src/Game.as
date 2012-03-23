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
	import game.entities.fixture.decorator.KeyboardMove;
	import game.entities.fixture.decorator.MouseLook;
	
	import render.Camera;
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

		private var fixture:b2Fixture;

		private var hero:IFixture;

		private var flashContainer:flash.display.Sprite = new flash.display.Sprite();

		private var mouseFixture:b2Fixture;

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
            
            controls.init(stage);
            
            worldManager.createBounds();
            fixture = worldManager.createFixture(0, 0, 100, 100, b2Body.b2_dynamicBody);

            mouseFixture = worldManager.createFixture(0, 0, 50, 50);
            
            var flashCamera:FlashCamera = new FlashCamera(flashContainer);
            var starlingCamera:StarlingCamera = new StarlingCamera(this);
            var camera:render.Camera = new render.Camera();
            camera.add(flashCamera);
            camera.add(starlingCamera);
            
            var mouseRotation:MouseLook = new MouseLook(controls, camera);
            var controledMovement:KeyboardMove = new KeyboardMove(controls);
            var cameraFollow:CameraFollow = new CameraFollow(camera);
            cameraFollow.add(mouseRotation);
            mouseRotation.add(controledMovement);
            controledMovement.add(new Fixture(fixture));
            
            hero = cameraFollow;
            
            //Rendering
            {
                var renderer:StarlingRenderer = new StarlingRenderer(this);
                renderer.addBackground();
                hero = renderer.addDrawHero(hero);
            }
            worldManager.enableDebug();
            
			// when the sprite is touched
			//customSprite.addEventListener(TouchEvent.TOUCH, onTouchedSprite);
		}
        
        /*mouseFixture.GetBody().GetPosition().x = 
        mouseFixture.GetBody().GetPosition().y = (controls.mouseY + flashCamera.y - LightLife.HEIGHT/2) / WorldManager.SCALE;*/
        
        private function onFrame (e:Event):void
		{
            // Update physics
            worldManager.update();
            
            /*mouseFixture.GetBody().GetPosition().x = (controls.mouseX + flashCamera.x - LightLife.WIDTH/2) / WorldManager.SCALE;
            mouseFixture.GetBody().GetPosition().y = (controls.mouseY + flashCamera.y - LightLife.HEIGHT/2) / WorldManager.SCALE;*/
            
            //trace(camerafixture.GetBody().GetPosition().x);
            
            hero.update();
            
            //Main.m_fpsCounter.updatePhys(physStart);
            
            
            /*trace("body.GetAngle() " + body.GetAngle() % Math.PI);
            trace("angle " + angle);
            body.SetAngularVelocity(bodyAngle-angle);*/
            
            //worldManager.createFixture(mousePosition.x, mousePosition.y, 30, 30);
            /*var sprite:CustomSprite = new CustomSprite(10, 10);
            addChild(sprite);
            sprite.x = mousePosition.x;
            sprite.y = mousePosition.y;*/ 
            
			/*customSprite.x += xDelta;
			customSprite.y += yDelta;*/
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
		
        /*
		private function onTouchedSprite(e:TouchEvent):void
		{
			// get the touch points (can be multiple because of multitouch)
			var touch:Touch = e.getTouch(stage);
			var clicked:DisplayObject = e.currentTarget as DisplayObject;
			// detect the click/release phase
			if ( touch.phase == TouchPhase.ENDED )
			{
				// remove the clicked object
				removeChild(clicked, true);
			}
		}*/
	}
}