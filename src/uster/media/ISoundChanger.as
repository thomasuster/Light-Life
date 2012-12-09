package uster.media
{
import flash.media.SoundChannel;
import flash.media.SoundTransform;

public interface ISoundChanger
    {
        function play(startTime:Number, loops:int, sndTransform:SoundTransform):SoundChannel;
    }
}