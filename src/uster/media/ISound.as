package uster.media
{
    public interface ISound
    {
        function play():void;
        function pause():void;
        function stop():void;
        function set volume(value:Number):void;
        function get volume():Number;
        function set pan(value:Number):void;
        function get pan():Number;
        function set pitch(value:Number):void;
        function get pitch():Number;
        function set loops(value:int):void;
        function get loops():int;
    }
}