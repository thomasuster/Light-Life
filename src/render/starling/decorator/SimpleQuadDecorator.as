package render.starling.decorator
{
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Fixture;
    
    import game.entities.fixture.FixtureManager;
    import game.entities.fixture.IFixture;
    import game.entities.fixture.decorator.AFixtureDecorator;
    import game.entities.fixture.decorator.IFixtureDecorator;
    
    import starling.display.Quad;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;
    
    public class SimpleQuadDecorator extends Sprite implements IFixtureDecorator
    {
        private var quadWidth:Number;
        private var quadHeight:Number;
        private var _quadColor:uint;
        private var quad:Quad;
        private var label:String;
        private var legend:TextField;
        private var decoratedFixture:IFixture;
        
        public function SimpleQuadDecorator(quadWidth:Number, quadHeight:Number, color:uint=16777215, label:String = "")
        {
            this.quadWidth = quadWidth;
            this.quadHeight = quadHeight;
            this._quadColor = color;
            this.label = label;
            addEventListener(Event.ADDED_TO_STAGE, activate);
        }
        
        public function set color(value:uint):void
        {
            quad.color = value;
        }

        public function get fixture():b2Fixture
        {       
            return decoratedFixture.fixture;   
        }
        
        public function add(decoratedFixture:IFixture):void
        {
            this.decoratedFixture = decoratedFixture;   
        }
        
        private function activate(event:Event):void
        {
            quad = new Quad(quadWidth, quadHeight);
            legend = new TextField(100, 20, label, "Arial", 14, 0xFFFFFF);
            quad.color = _quadColor;
            addChild(quad);
            addChild(legend);
            pivotX = quadWidth >> 1;
            pivotY = quadHeight >> 1;
        }
        
        public function update():void
        {
            decoratedFixture.update();
            
            var position:b2Vec2 = fixture.GetBody().GetPosition();
            x = position.x * FixtureManager.SCALE; 
            y = position.y * FixtureManager.SCALE;
            var rotation:Number= fixture.GetBody().GetAngle();
            this.rotation = rotation;
        }
    }
}