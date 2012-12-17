package game.entities.camera.decorator {
    import flash.geom.Rectangle;

    import mockolate.allow;
    import mockolate.arg;
    import mockolate.capture;
    import mockolate.expect;
    import mockolate.ingredients.Capture;

    import org.flexunit.assertThat;
    import org.hamcrest.core.anything;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.notNullValue;

    import render.ICamera;
    import render.IDisplayObject;
    import render.starling.decorator.StarlingRenderer;

    [RunWith("mockolate.runner.MockolateRunner")]
    public class LeanRenderedBackgroundTest {

        public var background:LeanRenderedBackground;

        [Mock(type="nice")]
        public var backgroundFactory:StarlingRenderer;

        [Mock(type="nice")]
        public var camera:ICamera;

        [Mock(type="nice")]
        public var display:IDisplayObject;

        [Before]
        public function setUp():void {
            background = new LeanRenderedBackground().setFactory(backgroundFactory);
            background.add(camera);
        }

        [Test]
        public function onAddCameraShouldGetBackground():void {

            injectCameraProperties();
            var captured:Capture = new Capture();
            expect(backgroundFactory.getStars(arg(capture(captured))));
            background.update();
            const rect:Rectangle = captured.value;
            assertBackgroundHasCameraProperties(rect);
        }

        private function injectCameraProperties():void
        {
            allow(camera.x).returns(1);
            allow(camera.y).returns(2);
            allow(camera.width).returns(100);
            allow(camera.height).returns(200);
        }

        private function assertBackgroundHasCameraProperties(rect:Rectangle):void
        {
            assertThat(rect.x, equalTo(camera.x));
            assertThat(rect.y, equalTo(camera.y));
            assertThat(rect.width, equalTo(camera.width));
            assertThat(rect.height, equalTo(camera.height));
        }
    }
}
