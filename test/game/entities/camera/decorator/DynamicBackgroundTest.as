package game.entities.camera.decorator {
import org.flexunit.assertThat;
import org.hamcrest.object.notNullValue;

    import render.IDisplayObject;

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
    public function ratio2ShouldBe3times1():void {
        assertThat(background, notNullValue());

//        var lod1:IDisplayObject = renderer.addBackGround(0, 0, 100, 100, String("1");
//        var lod2:IDisplayObject = renderer.addBackGround(0, 0, 100, 100, String("2");

        background.update();
    }
}
}
