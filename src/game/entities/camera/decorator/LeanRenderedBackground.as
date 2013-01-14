package game.entities.camera.decorator
{
    import flash.geom.Rectangle;

    import render.starling.decorator.StarlingRenderer;

    public class LeanRenderedBackground extends ACameraDecorator
    {
        private var renderer:StarlingRenderer;

        public function setFactory(value:StarlingRenderer):LeanRenderedBackground
        {
            renderer = value;
            return this;
        }

        protected override function behavior():void
        {
            var rect:Rectangle = new Rectangle(camera.x, camera.y, camera.width, camera.height);
            renderer.renderStars(rect);
        }
    }
}