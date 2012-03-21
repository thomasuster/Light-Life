package render.starling
{
    import game.entities.fixture.IFixture;
    
    import render.IRenderFactory;
    
    public class StarlingRenderFactory implements IRenderFactory
    {
        public function StarlingRenderFactory()
        {
        }
        
        public function createDrawHero():IFixture
        {
            return null;
        }
        
        /*public function drawDrone():void
        {
        }*/
    }
}