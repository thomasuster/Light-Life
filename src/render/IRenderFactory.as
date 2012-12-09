package render
{
import game.entities.fixture.IFixtureEntity;

public interface IRenderFactory
    {
        function createDrawHero():IFixtureEntity;
        //function drawDrone():void;
    }
}