package render.starling.decorator
{
    import flash.display.Bitmap;

    import starling.textures.Texture;

    public class TextureProxy
    {
        public function fromBitmap(bitmap:Bitmap):Texture
        {
            return Texture.fromBitmap(bitmap);
        }
    }
}
