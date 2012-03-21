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
            // positions it by default in the center of the stage
            // we add half width because of the registration point of the custom sprite (middle)
            customSprite.x = (stage.stageWidth - customSprite.width >> 1 ) + (customSprite.width >> 1);
            customSprite.y = (stage.stageHeight - customSprite.height >> 1) + (customSprite.height >> 1);
            // show it
            stage.addChild(customSprite);
            return customSprite;
        }
    }
}