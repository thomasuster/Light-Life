package game.entities.camera.decorator {
import org.flexunit.assertThat;
import org.flexunit.asserts.assertNotNull;
import org.hamcrest.object.notNullValue;

import render.IRenderer;

[RunWith("mockolate.runner.MockolateRunner")]
public class DynamicBackgroundTest {

    public var background:DynamicBackground;

    [Mock(type="nice")]
    public var renderer:IRenderer;

    [Before]
    public function setUp():void {
        background = new DynamicBackground(renderer);
    }

    [Test]
    public function testAdd():void {
        assertThat(background, notNullValue());
    }
}
}
