package render.starling.decorator
{
    import Box2D.Collision.b2AABB;
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Fixture;

    import com.junkbyte.console.Cc;

    import flash.display.Bitmap;
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;

    import game.entities.fixture.IFixtureEntity;
    import game.entities.fixture.WorldManager;

    import render.Assets;
    import render.IDisplayObject;
    import render.NullDisplayObject;
    import render.starling.StarlingDisplayObject;

    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;
    import starling.display.Image;
    import starling.textures.Texture;

    public class StarlingRenderer
    {
        public var textureProxy:TextureProxy = new TextureProxy()
        public var assets:Assets;
        public var container:DisplayObjectContainer;

        private var displayObjects:Dictionary = new Dictionary();
        private var displayObjectsByb2Fixtures:Dictionary = new Dictionary();
        private var image:Image;

        public function init():void
        {
            image = makeImage();
        }

        private function makeImage():Image
        {
            var texture:Texture = getStarsTexture();
            const _image:Image = new Image(texture);
            container.addChild(_image);
            return _image;
        }

        public function addDrawHero(fixtureEntity:IFixtureEntity):IFixtureEntity
        {
            var sprite:HeroDecorator = new HeroDecorator(100, 100);
            sprite.add(fixtureEntity);

            addFixtureChild(fixtureEntity.fixture, sprite, sprite);
            return sprite;
        }

        public function addBadGuy(fixtureEntity:IFixtureEntity):IFixtureEntity
        {
            var sprite:SimpleQuadDecorator = new SimpleQuadDecorator(100, 100, 0xFF0000, "Bad Guy");
            sprite.add(fixtureEntity);

            addFixtureChild(fixtureEntity.fixture, sprite, sprite);
            return sprite;
        }

        public function addSimpleQuadDecorator(fixtureEntity:IFixtureEntity, name:String="", color:uint=0xFF5555):IFixtureEntity
        {
            var aabb:b2AABB = fixtureEntity.fixture.GetAABB();
            var lowerBound:b2Vec2 = aabb.lowerBound.Copy();
            var upperBound:b2Vec2 = aabb.upperBound.Copy();
            upperBound.Subtract(lowerBound);
            var width:Number = Math.abs(upperBound.x * WorldManager.SCALE);
            var height:Number = Math.abs(upperBound.y * WorldManager.SCALE);
            var sprite:SimpleQuadDecorator = new SimpleQuadDecorator(width, height, color, name);
            var position:b2Vec2 = fixtureEntity.fixture.GetBody().GetPosition();
            sprite.add(fixtureEntity);
            sprite.x = position.x;
            sprite.y = position.y;

            addFixtureChild(fixtureEntity.fixture, sprite, sprite);
            return sprite;
        }

        public function renderStars(rect:Rectangle):void
        {
            var texture:Texture = getStarsTexture();
            image.texture = texture;
        }

        private function getStarsTexture():Texture
        {
            var bitmap:Bitmap = assets.getStars(0);
            var texture:Texture = textureProxy.fromBitmap(bitmap);
            return texture;
        }

        public function remove(displayObject:IDisplayObject):void
        {
            removeChild(displayObject);
            delete displayObjects[displayObject];
        }

        private function addFixtureChild(fixture:b2Fixture, displayObject:IDisplayObject, starlingDisplayObject:DisplayObject):void
        {
            displayObjectsByb2Fixtures[fixture] = displayObject;
            addChild(displayObject, starlingDisplayObject);
        }
        public function removeByFixture(fixture:b2Fixture):void
        {
            var displayObject:IDisplayObject = displayObjectsByb2Fixtures[fixture];
            removeChild(displayObject);
        }

        //Render only add/remove
        private function addChild(displayObject:IDisplayObject, starlingDisplayObject:DisplayObject, zIndex:int = -1):void
        {
            if(zIndex == -1)
            {
                container.addChild(starlingDisplayObject);
            }
            else
            {
                container.addChildAt(starlingDisplayObject, zIndex);
            }
            displayObjects[displayObject] = starlingDisplayObject;
        }
        private function removeChild(displayObject:IDisplayObject):void
        {
            var starlingDisplayObject:DisplayObject = displayObjects[displayObject];
            if(container.contains(starlingDisplayObject))
            {
                container.removeChild(starlingDisplayObject,true);
            }
            else
            {
                Cc.log("StarlingRenderer.removeChild: invalid displayObject to remove.");
            }
            delete displayObjects[displayObject];
        }


    }
}