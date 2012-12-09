/**
 * Created with IntelliJ IDEA.
 * User: ustert
 * Date: 12/9/12
 * Time: 10:28 AM
 * To change this template use File | Settings | File Templates.
 */
package render.starling
{
    import org.flexunit.assertThat;
    import org.hamcrest.object.equalTo;

    import starling.display.Sprite;

    public class StarlingDisplayObjectTest
    {
        public var starlingDisplayObject:StarlingDisplayObject;

        [Before]
        public function setUp():void
        {
            starlingDisplayObject = new StarlingDisplayObject();
        }

        [Test]
        public function setDisplayObjectShouldAdjustDimensions():void
        {
            var object:Sprite = new Sprite();
            object.width = 100;
            object.height = 200;
            starlingDisplayObject.setDisplayObject(object);
            assertThat(starlingDisplayObject.width, equalTo(object.width));
            assertThat(starlingDisplayObject.height, equalTo(object.height));
        }
    }
}
