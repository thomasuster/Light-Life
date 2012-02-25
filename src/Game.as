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
		
		private var mouseX:Number = 0;
		private var mouseY:Number = 0
            
		private var controls:Controls = new Controls();

		private var worldManager:WorldManager = new WorldManager(Starling.current.nativeStage);
        
			
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
			//stage.addEventListener(TouchEvent.TOUCH, onTouch);
			// need to comment this one ? ;)q
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
            
            controls.init(stage);
            
            worldManager.createBounds();
            worldManager.createFixture(customSprite.x, customSprite.y, customSprite.width, customSprite.height);
            worldManager.enableDebug();
			
			// when the sprite is touched
			//customSprite.addEventListener(TouchEvent.TOUCH, onTouchedSprite);
		}
        
        /*private function getFixture(displayObject:DisplayObject):b2Fixture
        {
            var wall:b2PolygonShape= new b2PolygonShape();
            var wallBd:b2BodyDef = new b2BodyDef();
            var wallB:b2Body;
            wall.SetAsBox(displayObject.width/2/SCALE, displayObject.height/2/SCALE);
            // Box
            wallBd.position.Set(displayObject.x / SCALE, displayObject.y/ SCALE);
            wallB = world.CreateBody(wallBd);
            return wallB.CreateFixture2(wall);
        }*/
        
        private function onFrame (e:Event):void
		{
            // Update physics
            worldManager.update();
            
            //Main.m_fpsCounter.updatePhys(physStart);
            
			// easing on the custom sprite position
            var xDir:int = getDir(controls.left, controls.right);
            var yDir:int = getDir(controls.up, controls.down);
            
			customSprite.x += ( xDir ) * 10;
			customSprite.y += ( yDir ) * 10;
            
			// we update our custom sprite 
			customSprite.update();
            
            /*for each (var fixture:b2Fixture in fixtures) 
            {
                fixture.GetBody().ApplyForce(new b2Vec2(100, 100), new b2Vec2(10, 30));
            }*/
		}
        
        private function getDir(negative:Boolean, positive:Boolean):int
        {
            if(negative && !positive)
            {
                return -1;
            }
            else if(!negative && positive)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
        
		/*private function onTouch (e:TouchEvent):void
		{
			// get the mouse location related to the stage
			var touch:Touch = e.getTouch(stage);
			var pos:Point = touch.getLocation(stage);
			// store the mouse coordinates
			mouseX = pos.x;
			mouseY = pos.y;
		}
		
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