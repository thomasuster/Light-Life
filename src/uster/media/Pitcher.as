package uster.media
{
    import flash.events.SampleDataEvent;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;
    import flash.utils.ByteArray;
    
    /**
     * Original code from Andre Michelle (andre.michelle@gmail.com) 
     */
    internal class Pitcher implements ISoundChanger
    {
        private var sourceSound:flash.media.Sound;
        private var sound:flash.media.Sound;
        private var _target:ByteArray = new ByteArray();
        private const BLOCK_SIZE:int = 3072;
        private var _position:Number = 0;
        private var usterSound:uster.media.Sound;
        
        public function Pitcher(sound:flash.media.Sound, usterSound:uster.media.Sound)
        {
            sourceSound = sound;
            this.sound = new flash.media.Sound();
            this.usterSound = usterSound;
        }
        
        public function play(startTime:Number, loops:int, sndTransform:SoundTransform):SoundChannel
        {
            sound.addEventListener(SampleDataEvent.SAMPLE_DATA, sound_sampleDataHandler);
            return sound.play(startTime, loops, sndTransform);
        }
        
        private function sound_sampleDataHandler(event:SampleDataEvent):void
        {
            _target.position = 0;
            var data:ByteArray = event.data;
            
            var scaledBlockSize: Number = BLOCK_SIZE * usterSound.pitch;
            var positionInt: int = _position;
            var alpha: Number = _position - positionInt;
            
            var positionTargetNum: Number = alpha;
            var positionTargetInt: int = -1;
            
            //-- COMPUTE NUMBER OF SAMPLES NEED TO PROCESS BLOCK (+2 FOR INTERPOLATION)
            var need: int = Math.ceil( scaledBlockSize ) + 2;
            
            //-- EXTRACT SAMPLES
            var read: int = sourceSound.extract( _target, need, positionInt );
            
            var n: int = read == need ? BLOCK_SIZE : read / usterSound.pitch;
            
            var l0: Number;
            var r0: Number;
            var l1: Number;
            var r1: Number;
            
            for( var i: int = 0 ; i < n ; ++i )
            {
                //-- AVOID READING  EQUAL SAMPLES, IF RATE < 1.0
                if( int( positionTargetNum ) != positionTargetInt )
                {
                    positionTargetInt = positionTargetNum;
                    
                    //-- SET TARGET READ POSITION
                    _target.position = positionTargetInt << 3;
                    
                    //-- READ TWO STEREO SAMPLES FOR LINEAR INTERPOLATION
                    l0 = _target.readFloat();
                    r0 = _target.readFloat();
                    
                    l1 = _target.readFloat();
                    r1 = _target.readFloat();
                }
                
                //-- WRITE INTERPOLATED AMPLITUDES INTO STREAM
                data.writeFloat( l0 + alpha * ( l1 - l0 ) );
                data.writeFloat( r0 + alpha * ( r1 - r0 ) );
                
                //-- INCREASE TARGET POSITION
                positionTargetNum += usterSound.pitch;
                
                //-- INCREASE FRACTION AND CLAMP BETWEEN 0 AND 1
                alpha += usterSound.pitch;
                while( alpha >= 1.0 ) --alpha;
            }
            
            //-- FILL REST OF STREAM WITH ZEROs
            if( i < BLOCK_SIZE )
            {
                while( i < BLOCK_SIZE )
                {
                    data.writeFloat( 0.0 );
                    data.writeFloat( 0.0 );
                    
                    ++i;
                }
            }
            
            //-- INCREASE SOUND POSITION
            _position += scaledBlockSize;
        }
    }
}