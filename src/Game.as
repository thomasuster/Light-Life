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
	
	import drawables.CustomSprite;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import game.WorldManager;
	import game.entities.IEntity;
	import game.entities.fixture.Fixture;
	import game.entities.fixture.decorator.ControledMovement;
	import game.entities.fixture.decorator.MouseRotation;
	
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
        
		private var customSprite:CustomSprite;
		
		private var controls:Controls = new Controls();

		private var worldManager:WorldManager = new WorldManager(Starling.current.nativeStage);

		private var fixture:b2Fixture;

		private var hero:IEntity;
			
		public function Game()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		private function onAdded ( e:Event ):void
		{
			// create the custom sprite
			customSprite = new CustomSprite(200, 200);
			// positions it by default in the center of the stage
			// we add half width because of the registration point of the custom sprite (middle)
			customSprite.x = (stage.stageWidth - customSprite.width >> 1 ) + (customSprite.width >> 1);
			customSprite.y = (stage.stageHeight - customSprite.height >> 1) + (customSprite.height >> 1);
            
			// show it
			addChild(customSprite);
			// we listen to the mouse movement on the stage
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			// need to comment this one ? ;)q
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
            
            controls.init(stage);
            
            worldManager.createBounds();
            fixture = worldManager.createFixture(customSprite.x, customSprite.y, customSprite.width, customSprite.height);
            
            var mouseRotation:MouseRotation = new MouseRotation(controls);
            var controledMovement:ControledMovement = new ControledMovement(controls);
            mouseRotation.add(controledMovement);
            controledMovement.add(new Fixture(fixture));
            hero = mouseRotation;
            
            //fixture.GetBody().ApplyForce(
            worldManager.enableDebug();
            
			// when the sprite is touched
			//customSprite.addEventListener(TouchEvent.TOUCH, onTouchedSprite);
		}
        
        private function onFrame (e:Event):void
		{
            // Update physics
            worldManager.update();
            
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
            
            var position:b2Vec2 = fixture.GetBody().GetPosition();
            customSprite.x = position.x * 30; 
            customSprite.y = position.y * 30;
            
			// we update our custom sprite 
			customSprite.update();
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