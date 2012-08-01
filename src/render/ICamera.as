package render
{
    public interface ICamera
    {
        function set zoom(value:Number):void;
        function get zoom():Number;
        function get height():Number;
        function set height(value:Number):void;
        function get width():Number;
        function set width(value:Number):void;
        function get y():Number;
        function set y(value:Number):void;
        function get x():Number;
        function set x(value:Number):void;
    }
}