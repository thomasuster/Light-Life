package game
{
    import Box2D.Collision.Shapes.b2PolygonShape;
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Body;
    import Box2D.Dynamics.b2BodyDef;
    import Box2D.Dynamics.b2DebugDraw;
    import Box2D.Dynamics.b2Fixture;
    import Box2D.Dynamics.b2World;
    
    import flash.display.Sprite;
    import flash.utils.Dictionary;
    import flash.utils.getTimer;

    public class WorldManager
    {
        private var world:b2World;
        private var sprite2D:Sprite;
        public static const SCALE:Number = 30;
        private var timeStep:Number = 1.0/30.0;
        private var velocityIterations:int = 10;
        private var positionIterations:int = 10;
        private var WIDTH:int = 1024;
        private var HEIGHT:int = 768;
        public var fixtures:Dictionary = new Dictionary();
        
        public function WorldManager(camera:Sprite)
        {
            sprite2D = camera;
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
            dbgDraw.SetDrawScale(SCALE);
            dbgDraw.SetFillAlpha(0.3);
            dbgDraw.SetLineThickness(1.0);
            dbgDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
            world.SetDebugDraw(dbgDraw);
        }
        
        public function createBounds():void
        {
            var polygonShape:b2PolygonShape= new b2PolygonShape();
            var bodyDef:b2BodyDef = new b2BodyDef();
            var body:b2Body;
            var buffer:int = 10;
            var thickness:int = 100;
            
            polygonShape.SetAsBox(100/SCALE, HEIGHT/SCALE/2);
            bodyDef.position.Set( (-100 + buffer - WIDTH/2) / SCALE, 0);
            body = world.CreateBody(bodyDef);
            body.CreateFixture2(polygonShape);
            
            polygonShape.SetAsBox(WIDTH/SCALE/2, thickness/SCALE);
            bodyDef.position.Set(0, (-1*thickness + buffer - HEIGHT/2) / SCALE);
            body = world.CreateBody(bodyDef);
            body.CreateFixture2(polygonShape);
        }
        
        public function createFixture(x:Number, y:Number, width:Number, height:Number, type:uint = 0):b2Fixture
        {
            var bodyDef:b2BodyDef = new b2BodyDef();
            bodyDef.type = type;
            bodyDef.position.Set(x, y);
            
            var polygonShape:b2PolygonShape = new b2PolygonShape();
            polygonShape.SetAsBox(width/2/ SCALE, height/2 /SCALE);

            var body:b2Body;
            body = world.CreateBody(bodyDef);
            
            //var shape:b2Shape = body.
            /*var filterData:b2FilterData = new b2FilterData();
            filterData.categoryBits = 0;
            filterData.maskBits = 1;
            fire.SetFilterData(filterData);*/
            
            var fixture:b2Fixture = body.CreateFixture2(polygonShape);
            
            fixtures[fixture] = fixture;
            return fixture;
        }
        
        public function update():void
        {
            var physStart:uint = getTimer();
            world.Step(timeStep, velocityIterations, positionIterations);
            //world.ClearForces();
            
            world.DrawDebugData();
        }
    }
}
