package 
{
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2World;
	
	import General.FpsCounter;
	
	import drawables.CustomSprite;
	
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class Game extends Sprite
	{
		private var customSprite:CustomSprite;
		
		private var mouseX:Number = 0;
		private var mouseY:Number = 0
            
		private var controls:Controls = new Controls();
			
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
            var worldAABB:b2AABB = new b2AABB();
            worldAABB.lowerBound.Set(-100.0, -100.0);
            worldAABB.upperBound.Set(100.0, 100.0);
            
            var gravity:b2Vec2 = new b2Vec2 (0.0, 0.0);
            var doSleep:Boolean = true;
            
            var world:b2World = new b2World(gravity, doSleep);

            var groundBodyDef:b2BodyDef = new b2BodyDef();
            groundBodyDef.position.Set(0.0, -10.0);
            
            var groundBody:b2Body = world.CreateBody(groundBodyDef);
            
            var groundShapeDef:b2PolygonShape = new b2PolygonShape();
            groundShapeDef.SetAsBox(50.0, 10.0);
            
            //groundBody.CreateShape(groundShapeDef);
            var fixture:b2Fixture = groundBody.CreateFixture2(groundShapeDef);
            
            var bodyDef:b2BodyDef = new b2BodyDef();
            bodyDef.position.Set(0.0, 4.0);
            
            var body:b2Body = world.CreateBody(bodyDef);
            
            //var shapeDef:b2PolygonDef = new b2PolygonDef();
            var shapeDef:b2PolygonShape = new b2PolygonShape();
            shapeDef.SetAsBox(1.0, 1.0);
            body.CreateFixture2(shapeDef);
            var massData:b2MassData = new b2MassData();
            body.SetMassData(massData);
            
            //init
            var timeStep:Number = 1.0 / 60.0;
            var iterations:Number = 10;

            for (var i:Number = 0; i < 60; ++i)
                
            {
                //world.Step(timeStep, iterations);
                world.Step(timeStep, iterations, iterations);
                var position:b2Vec2 = body.GetPosition();
                var angle:Number = body.GetAngle();
                trace(position.x +','+ position.y +','+ angle);
            }

			
			// when the sprite is touched
			//customSprite.addEventListener(TouchEvent.TOUCH, onTouchedSprite);
		}
		private function onFrame (e:Event):void
		{
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