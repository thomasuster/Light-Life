package game
{
    import Box2D.Collision.Shapes.b2PolygonShape;
    import Box2D.Collision.b2AABB;
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Body;
    import Box2D.Dynamics.b2BodyDef;
    import Box2D.Dynamics.b2DebugDraw;
    import Box2D.Dynamics.b2Fixture;
    import Box2D.Dynamics.b2World;
    
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.utils.Dictionary;
    import flash.utils.getTimer;

    public class WorldManager
    {
        private var world:b2World;
        private var sprite2D:Sprite;
        private const SCALE:Number = 30;
        private var m_timeStep:Number = 1.0/30.0;
        private var m_velocityIterations:int = 10;
        private var m_positionIterations:int = 10;
        private var WIDTH:int = 1024;
        private var HEIGHT:int = 768;
        private var fixtures:Dictionary = new Dictionary();
        
        public function WorldManager(stage:Stage)
        {
            sprite2D = new Sprite();
            stage.addChild(sprite2D);
            createWorld();
        }
        
        private function createWorld():void
        {
            var gravity:b2Vec2 = new b2Vec2(0, 0);
            var doSleep:Boolean = true;
            world = new b2World(gravity, doSleep);
        }
        
        public function enableDebug(value:Boolean = true):void
        {
            var dbgDraw:b2DebugDraw = new b2DebugDraw();
            dbgDraw.SetSprite(sprite2D);
            dbgDraw.SetDrawScale(30.0);
            dbgDraw.SetFillAlpha(0.3);
            dbgDraw.SetLineThickness(1.0);
            dbgDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
            world.SetDebugDraw(dbgDraw);
        }
        
        public function createBounds():void
        {
            var wall:b2PolygonShape= new b2PolygonShape();
            var wallBd:b2BodyDef = new b2BodyDef();
            var wallB:b2Body;
            
            var buffer:int = 10;
            var thickness:int = 100;
            
            wall.SetAsBox(100/SCALE, HEIGHT/SCALE/2);
            // Left
            wallBd.position.Set( (-100 + buffer) / SCALE, HEIGHT/2 / SCALE);
            wallB = world.CreateBody(wallBd);
            wallB.CreateFixture2(wall);
            // Right
            wallBd.position.Set((WIDTH + 100 - buffer) / SCALE, HEIGHT/2 / SCALE);
            wallB = world.CreateBody(wallBd);
            wallB.CreateFixture2(wall);
            
            wall.SetAsBox(WIDTH/SCALE/2, thickness/SCALE);
            // Top
            wallBd.position.Set(WIDTH / SCALE / 2, (-1*thickness + buffer) / SCALE);
            wallB = world.CreateBody(wallBd);
            wallB.CreateFixture2(wall);
            // Bottom
            wallBd.position.Set(WIDTH / SCALE / 2, (HEIGHT + thickness - buffer) / SCALE);
            wallB = world.CreateBody(wallBd);
            wallB.CreateFixture2(wall);
        }
        
        public function createFixture(x:Number, y:Number, width:Number, height:Number):b2Fixture
        {
            var wall:b2PolygonShape = new b2PolygonShape();
            var wallBd:b2BodyDef = new b2BodyDef();
            var wallB:b2Body;
            wall.SetAsBox(width/2/ SCALE, height/2 /SCALE);
            // Box
            wallBd.position.Set(x / SCALE, y / SCALE);
            wallB = world.CreateBody(wallBd);
            return wallB.CreateFixture2(wall);
        }
        
        public function update():void
        {
            var physStart:uint = getTimer();
            world.Step(m_timeStep, m_velocityIterations, m_positionIterations);
            world.ClearForces();
            
            world.DrawDebugData();
        }
    }
}