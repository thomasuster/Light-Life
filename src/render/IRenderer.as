package render
{
    import Box2D.Dynamics.b2Fixture;
    
    import game.entities.fixture.IFixtureEntity;

    public interface IRenderer
    {
        function addDrawHero(fixture:IFixtureEntity):IFixtureEntity;
        function addBadGuy(fixture:IFixtureEntity):IFixtureEntity;
        function addSimpleQuadDecorator(fixture:IFixtureEntity, name:String="", color:uint=0xFF5555):IFixtureEntity
        function addBackGround(x:Number, y:Number, width:Number, height:Number, lod:String):IDisplayObject;
        function remove(displayObject:IDisplayObject):void;
        function removeByFixture(fixture:b2Fixture):void;
    }
}