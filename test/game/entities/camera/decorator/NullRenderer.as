package game.entities.camera.decorator {
import Box2D.Dynamics.b2Fixture;

import game.entities.fixture.IFixtureEntity;

import render.IDisplayObject;

import render.IRenderer;

public class NullRenderer implements IRenderer {
    public function NullRenderer() {
    }

    public function addDrawHero(fixture:IFixtureEntity):IFixtureEntity {
        return null;
    }

    public function addBadGuy(fixture:IFixtureEntity):IFixtureEntity {
        return null;
    }

    public function addSimpleQuadDecorator(fixture:IFixtureEntity, name:String = "", color:uint = 0xFF5555):IFixtureEntity {
        return null;
    }

    public function addBackGround(x:Number, y:Number, width:Number, height:Number, lod:String):IDisplayObject {
        return null;
    }

    public function remove(displayObject:IDisplayObject):void {
    }

    public function removeByFixture(fixture:b2Fixture):void {
    }
}
}
