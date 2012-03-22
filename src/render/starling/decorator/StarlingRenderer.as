package render.starling.decorator
{
    import game.entities.fixture.IFixture;
    
    import render.IRenderer;
    
    import starling.display.Stage;
    
    public class StarlingRenderer implements IRenderer
    {
        private var stage:Stage;
        
        public function StarlingRenderer(stage:Stage)
        {
            this.stage = stage;
        }
        
        public function addDrawHero(fixture:IFixture):IFixture
        {
            var customSprite:HeroDecorator = new HeroDecorator(200, 200);
            customSprite.add(fixture);
            stage.addChild(customSprite);
            return customSprite;
        }
        
        public function addBackground():void
        {
            
        }
    }
}