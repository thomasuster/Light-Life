package render.starling.decorator
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Fixture;
	
	import game.entities.fixture.FixtureManager;
	import game.entities.IEntity;
	import game.entities.fixture.IFixture;
	import game.entities.fixture.decorator.IFixtureDecorator;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	public class HeroDecorator extends Sprite implements IFixtureDecorator
	{
        private var simpleQuadDecorator:SimpleQuadDecorator;
        private var rDest:Number;
        private var gDest:Number;
        private var bDest:Number;
        private var r:Number = 0;
        private var g:Number = 0;
        private var b:Number = 0;
        
		public function HeroDecorator(width:Number, height:Number, color:uint=16777215)
		{
            simpleQuadDecorator = new SimpleQuadDecorator(width, height, color, "HERO!");
            addChild(simpleQuadDecorator);
			resetColors();
		}
        
        public function add(decoratedFixture:IFixture):void
        {
            simpleQuadDecorator.add(decoratedFixture);   
        }
        
        public function get fixture():b2Fixture
        {
            return simpleQuadDecorator.fixture;
        }
        
		private function resetColors():void
		{
			// pick random color components
			rDest = Math.random()*255;
			gDest = Math.random()*255;
			bDest = Math.random()*255;
		}
		/**
		 * Updates the internal behavior
		 * 
		 */
		public function update():void
		{
            simpleQuadDecorator.update();
            
			// easing on the components
			r -= (r - rDest) * .01;
			g -= (g - gDest) * .01;
			b -= (b - bDest) * .01
			// assemble the color
			var color:uint = r << 16 | g << 8 | b;
			simpleQuadDecorator.color = color;
			// when reaching the color, pick another one
			if ( Math.abs( r - rDest) < 1 && Math.abs( g - gDest) < 1 && Math.abs( b - bDest) )
				resetColors();
			// rotate it!
			//rotation += .01;
		}
	}
}