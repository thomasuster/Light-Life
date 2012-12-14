package render
{
    import flash.display.Bitmap;

    public class Assets
    {
        [Embed (source="../../media/assets/stars/stars1.gif" )]
        private static const Stars1:Class;

        [Embed (source="../../media/assets/stars/stars2.gif" )]
        private static const Stars2:Class;

        [Embed (source="../../media/assets/stars/stars3.gif" )]
        private static const Stars3:Class;

        [Embed (source="../../media/assets/stars/stars4.gif" )]
        private static const Stars4:Class;

        [Embed (source="../../media/assets/stars/stars5.gif" )]
        private static const Stars5:Class;

        [Embed (source="../../media/assets/stars/stars6.gif" )]
        private static const Stars6:Class;

        private static const stars:Array = makeStars();

        private static function makeStars():Array
        {
            return [new Stars1(), new Stars2(), new Stars3(), new Stars4(), new Stars5(), new Stars6()];
        }

        public function getStars(index:int):Bitmap
        {
            return stars[index];
        }

        public function hasStars(index:int):Boolean
        {
            return (index in stars);
        }

    }
}