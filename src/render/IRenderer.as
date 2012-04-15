package render
{
    import game.entities.fixture.IFixture;

    public interface IRenderer
    {
        function addDrawHero(fixture:IFixture):IFixture;
        function addBadGuy(fixture:IFixture):IFixture;
        function addBackGround(x:Number, y:Number, width:Number, height:Number):IDisplayObject;
        function remove(displayObject:IDisplayObject):void;
    }
}