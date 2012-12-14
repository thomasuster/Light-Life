package uster.media
{
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;

    public class Sound implements ISound
    {
        private var _volume:Number = 1;
        private var _pan:Number = 0;
        private var _loops:Number = 1;
        private var _pitch:Number = 1;

        private var sound:flash.media.Sound;
        private var playing:Boolean = false;
        private var position:Number = 0;
        private var pitcher:Pitcher;
        private var soundChannel:SoundChannel = new SoundChannel();
        
        public function Sound(sound:flash.media.Sound)
        {
            this.sound = sound;
        }
        
        public function play():void
        {
            if(playing)
            {
                return;   
            }
            
            var soundTransform:SoundTransform = new SoundTransform(_volume, _pan);
            
            if(_pitch.toPrecision(2) != "1.0")
            {
                pitcher = new Pitcher(sound, this);
                soundChannel = pitcher.play(position, _loops, soundTransform);
            }
            else
            {
                soundChannel  = sound.play(position, _loops, soundTransform);
            }
            
            playing = true;
        }
        
        public function pause():void
        {
            soundChannel.stop();
            position = soundChannel.position;
            playing = false; 
        }
        
        public function stop():void
        {
            soundChannel.stop();
            position = 0;
            playing = false;
        }
        
        public function set volume(value:Number):void
        {
            _volume = value;
        }
        public function get volume():Number
        {
            return _volume;
        }
        
        public function set pan(value:Number):void
        {
            _pan = value;
        }
        public function get pan():Number
        {
            return _pan;
        }
        
        public function set pitch(value:Number):void
        {
            _pitch = value;
        }
        public function get pitch():Number
        {
            return _pitch;
        }
        
        public function set loops(value:int):void
        {
            _loops = value;
        }
        public function get loops():int
        {
            return _loops;
        }
    }
}