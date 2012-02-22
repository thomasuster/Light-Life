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
	import flash.utils.getTimer;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class Game extends Sprite
	{
        public static var sprite2D:flash.display.Sprite;
        
		private var customSprite:CustomSprite;
		
		private var mouseX:Number = 0;
		private var mouseY:Number = 0
            
		private var controls:Controls = new Controls();
		private var world:b2World;
        
        //Box2D
        private var m_physScale:Number = 30;
        public var m_timeStep:Number = 1.0/30.0;
        public var m_velocityIterations:int = 10;
        public var m_positionIterations:int = 10;
        private var WIDTH:int = 1024;
        private var HEIGHT:int = 768;
			
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
            
            //BOX2D INIT
            {
                var worldAABB:b2AABB = new b2AABB();
                worldAABB.lowerBound.Set(-1000.0, -1000.0);
                worldAABB.upperBound.Set(1000.0, 1000.0);
                var gravity:b2Vec2 = new b2Vec2(0, 0);
                var doSleep:Boolean = true;
                world = new b2World(gravity, doSleep);
                
                // set debug draw
                var dbgDraw:b2DebugDraw = new b2DebugDraw();
                dbgDraw.SetSprite(sprite2D);
                dbgDraw.SetDrawScale(30.0);
                dbgDraw.SetFillAlpha(0.3);
                dbgDraw.SetLineThickness(1.0);
                dbgDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
                world.SetDebugDraw(dbgDraw);
                
                var wall:b2PolygonShape= new b2PolygonShape();
                var wallBd:b2BodyDef = new b2BodyDef();
                var wallB:b2Body;
                
                var buffer:int = 10;
                var thickness:int = 100;
                
                wall.SetAsBox(100/m_physScale, HEIGHT/m_physScale/2);
                // Left
                wallBd.position.Set( (-100 + buffer) / m_physScale, HEIGHT/2 / m_physScale);
                wallB = world.CreateBody(wallBd);
                wallB.CreateFixture2(wall);
                // Right
                wallBd.position.Set((WIDTH + 100 - buffer) / m_physScale, HEIGHT/2 / m_physScale);
                wallB = world.CreateBody(wallBd);
                wallB.CreateFixture2(wall);
                
                
                wall.SetAsBox(WIDTH/m_physScale/2, thickness/m_physScale);
                // Top
                wallBd.position.Set(WIDTH / m_physScale / 2, (-1*thickness + buffer) / m_physScale);
                wallB = world.CreateBody(wallBd);
                wallB.CreateFixture2(wall);
                // Bottom
                wallBd.position.Set(WIDTH / m_physScale / 2, (HEIGHT + thickness - buffer) / m_physScale);
                wallB = world.CreateBody(wallBd);
                wallB.CreateFixture2(wall);
            }
            
            // set debug draw
            /*var dbgDraw:b2DebugDraw = new b2DebugDraw();
            dbgDraw.SetSprite(m_sprite);
            dbgDraw.SetDrawScale(30.0);
            dbgDraw.SetFillAlpha(0.3);
            dbgDraw.SetLineThickness(1.0);
            dbgDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
            world.SetDebugDraw(dbgDraw);*/
			
			// when the sprite is touched
			//customSprite.addEventListener(TouchEvent.TOUCH, onTouchedSprite);
		}
		private function onFrame (e:Event):void
		{
            // Update physics
            var physStart:uint = getTimer();
            world.Step(m_timeStep, m_velocityIterations, m_positionIterations);
            world.ClearForces();
            
            //Main.m_fpsCounter.updatePhys(physStart);
            
            // Render
            world.DrawDebugData();
            
			// easing on the custom sprite position
            var xDir:int = getDir(controls.left, controls.right);
            var yDir:int = getDir(controls.up, controls.down);
            
			customSprite.x += ( xDir ) * 10;
			customSprite.y += ( yDir ) * 10;
            
			
			// we update our custom sprite 
			customSprite.update();
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