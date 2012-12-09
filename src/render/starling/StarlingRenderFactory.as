package render.starling
{
import game.entities.fixture.IFixtureEntity;

import render.IRenderFactory;

public class StarlingRenderFactory implements IRenderFactory
    {
        public function StarlingRenderFactory()
        {
        }
        
        public function createDrawHero():IFixtureEntity
        {
            return null;
        }
        
        /*public function drawDrone():void
        {
        }*/
    }
}