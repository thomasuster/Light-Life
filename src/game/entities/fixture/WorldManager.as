package game.entities.fixture
{
    import Box2D.Collision.Shapes.b2PolygonShape;
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Body;
    import Box2D.Dynamics.b2BodyDef;
    import Box2D.Dynamics.b2ContactListener;
    import Box2D.Dynamics.b2DebugDraw;
    import Box2D.Dynamics.b2Fixture;
    import Box2D.Dynamics.b2World;

    import flash.display.Sprite;
    import flash.utils.Dictionary;
    import flash.utils.getTimer;

    import game.Game;

    import game.entities.IEntity;
    import game.entities.fixture.decorator.AFixtureDecorator;
    import game.entities.fixture.decorator.IFixtureEntityDecorator;
    import game.entities.fixture.decorator.decorations.CameraFollow;
    import game.entities.fixture.decorator.decorations.CullEventually;
    import game.entities.fixture.decorator.decorations.KeyboardMove;
    import game.entities.fixture.decorator.decorations.MouseLook;
    import game.entities.fixture.decorator.decorations.MoveToward;
    import game.entities.fixture.decorator.decorations.RapidFire;

    import render.ICamera;
    import render.starling.decorator.StarlingRenderer;

    public class WorldManager
    {
        public static const SCALE:Number = 50;
        public static const FIRE:String = "fire";
        
        private var world:b2World;
        private var sprite2D:Sprite;
        private var timeStep:Number = 1.0/30.0;
        private var velocityIterations:int = 10;
        private var positionIterations:int = 10;
        private var WIDTH:int = 1024;
        private var HEIGHT:int = 768;
        private var renderer:StarlingRenderer;
        private var debugDraw:Boolean = false;
        private var hero:IFixtureEntity = new FixtureEntity(new b2Fixture());
        
        private var fixtureEntitys:Dictionary = new Dictionary(); /*b2Fixture -> IFixture */
        private var entities:Dictionary = new Dictionary(); /* IEntity -> IEntity */
        
        public function WorldManager(camera:Sprite, renderer:StarlingRenderer)
        {
            this.renderer = renderer;
            sprite2D = camera;
            createWorld();
        }
        
        private function createWorld():void
        {
            var gravity:b2Vec2 = new b2Vec2(0, 0);
            var doSleep:Boolean = true;
            world = new b2World(gravity, doSleep);
            var fireContactListener:b2ContactListener = new FireContactListener(this);
            world.SetContactListener(fireContactListener);
            entities[fireContactListener] = fireContactListener;
            toggleDebug();
        }
        
        public function toggleDebug():void
        {
            if(debugDraw)
            {
                debugDraw = false;
                world.SetDebugDraw(null);
            }
            else
            {
                debugDraw = true;
                var dbgDraw:b2DebugDraw = new b2DebugDraw();
                dbgDraw.SetSprite(sprite2D);
                dbgDraw.SetDrawScale(SCALE);
                dbgDraw.SetFillAlpha(0.3);
                dbgDraw.SetLineThickness(1.0);
                dbgDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
                world.SetDebugDraw(dbgDraw);
            }
        }
        
        private function createFixture(x:Number, y:Number, width:Number, height:Number, type:uint = 0):b2Fixture
        {
            var bodyDef:b2BodyDef = new b2BodyDef();
            bodyDef.type = type;
            bodyDef.position.Set(x, y);
            
            var polygonShape:b2PolygonShape = new b2PolygonShape();
            polygonShape.SetAsBox(width/2/ SCALE, height/2 /SCALE);

            var body:b2Body;
            body = world.CreateBody(bodyDef);
            
            var fixture:b2Fixture = body.CreateFixture2(polygonShape);
            
            return fixture;
        }
        
        public function update():void
        {
            var physStart:uint = getTimer();
            world.Step(timeStep, velocityIterations, positionIterations);
            //world.ClearForces();
            world.DrawDebugData();
            
            for each (var entity:IEntity in fixtureEntitys) 
            {
                entity.update();
            }
            
            for each (entity in entities)
            {
                entity.update();
            }
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
            var fixture:b2Fixture = body.CreateFixture2(polygonShape);
            renderer.addSimpleQuadDecorator(new FixtureEntity(fixture), "", 0xAABBCC);
            
            polygonShape.SetAsBox(WIDTH/SCALE/2, thickness/SCALE);
            bodyDef.position.Set(0, (-1*thickness + buffer - HEIGHT/2) / SCALE);
            body = world.CreateBody(bodyDef);
            fixture = body.CreateFixture2(polygonShape);
            renderer.addSimpleQuadDecorator(new FixtureEntity(fixture), "", 0xAABBDD);
        }
        
        public function createHero(controls:Controls, camera:ICamera, game:Game):IFixtureEntity
        {
            var fixture:b2Fixture = createFixture(0, 0, 100, 100, b2Body.b2_dynamicBody);
            
            var mouseRotation:MouseLook = new MouseLook(controls, game);
            var controledMovement:KeyboardMove = new KeyboardMove(controls);
            var cameraFollow:CameraFollow = new CameraFollow(camera);
            var rapidFire:RapidFire = new RapidFire(controls, this, game);
            cameraFollow.add(mouseRotation);
            mouseRotation.add(controledMovement);
            controledMovement.add(rapidFire);
            rapidFire.add(new FixtureEntity(fixture));
            var render:IFixtureEntity = renderer.addDrawHero(cameraFollow);
            
            fixtureEntitys[fixture] = render;
            hero = render;
            return render;
        }
        
        public function createBadGuy():IFixtureEntity
        {
            var fixture:b2Fixture = createFixture(10, 10, 133, 133, b2Body.b2_dynamicBody);
            
            var fixtureEntity:IFixtureEntity = new FixtureEntity(fixture);
            fixtureEntity = renderer.addBadGuy(fixtureEntity);
            var decoration:AFixtureDecorator = new MoveToward(hero.fixture.GetBody());
            decoration.add(fixtureEntity);
            
            fixtureEntitys[fixture] = decoration;
            return decoration;
        }
        
        public function createFire(x:int, y:int):IFixtureEntity
        {
            var fixture:b2Fixture = createFixture(x, y, 20, 20, b2Body.b2_dynamicBody);
            fixture.SetUserData(FIRE);
            
            var fixtureEntity:IFixtureEntity = new FixtureEntity(fixture);
            fixtureEntity = renderer.addSimpleQuadDecorator(fixtureEntity, "");
            var decoration:IFixtureEntityDecorator = new CullEventually(this);
            decoration.add(fixtureEntity);
            
            fixtureEntitys[fixture] = decoration;
            return decoration;
        }
        
        public function cull(fixture:b2Fixture):void
        {
            world.DestroyBody(fixture.GetBody());
            renderer.removeByFixture(fixture);
            delete fixtureEntitys[fixture];
        }
    }
}
