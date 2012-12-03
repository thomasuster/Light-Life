package render
{
    import flash.display.Bitmap;

    public class Assets
    {
        [Embed (source="../../media/assets/stars/stars1.gif" )]
        private static const Stars1:Class;
        private var stars1:Bitmap = new Stars1();

        [Embed (source="../../media/assets/stars/stars2.gif" )]
        private static const Stars2:Class;
        private var stars2:Bitmap = new Stars2();

        [Embed (source="../../media/assets/stars/stars3.gif" )]
        private static const Stars3:Class;
        private var stars3:Bitmap = new Stars3();

        [Embed (source="../../media/assets/stars/stars4.gif" )]
        private static const Stars4:Class;
        private var stars4:Bitmap = new Stars4();

        [Embed (source="../../media/assets/stars/stars5.gif" )]
        private static const Stars5:Class;
        private var stars5:Bitmap = new Stars5();

        [Embed (source="../../media/assets/stars/stars6.gif" )]
        private static const Stars6:Class;
        private var stars6:Bitmap = new Stars5();
        
        private static var _instance:Assets;
        
        public var stars:Object = {1:stars1, 2:stars2, 3:stars3, 4:stars4, 5:stars5, 6:stars6};
        
        public function Assets(singletonEnforcer:SingletonEnforcer)
        {
        }
        
        public static function get instance():Assets
        {
            if(_instance == null)
            {
                _instance = new Assets(new SingletonEnforcer());
            }
            return _instance;   
        }
    }
}

internal class SingletonEnforcer {}