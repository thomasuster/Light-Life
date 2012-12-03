package
{
    public class EmbeddedAssets
    {
        [Embed(source="../media/assets/splash.swf")]
        public static var Splash:Class;
        
        public function EmbeddedAssets()
        {
        }
    }
}