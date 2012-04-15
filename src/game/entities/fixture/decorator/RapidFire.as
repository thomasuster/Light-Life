package game.entities.fixture.decorator
{
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Body;
    import Box2D.Dynamics.b2FilterData;
    import Box2D.Dynamics.b2Fixture;
    
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    import flash.utils.flash_proxy;
    
    import game.WorldManager;

    public class RapidFire extends AFixtureDecorator
    {
        private var controls:Controls;
        private var worldManager:WorldManager;
        
        private var fireStarted:Boolean = false;
        private var timer:Timer;
        private var rate:Number = 100;
        private var _game:Game;
        
        public function RapidFire(controls:Controls, worldManager:WorldManager, game:Game)
        {
            this.controls = controls;
            timer = new Timer(rate);
            timer.addEventListener(TimerEvent.TIMER, timer_timerHandler);
            this.worldManager = worldManager;
            this._game = game;
        }
        
        protected override function behavior():void
        {
            if(fireStarted)
            {
                if(controls.mouseDown)
                {
                    //Continue firring
                }
                else
                {
                    timer.stop();
                    fireStarted = false;
                }
            }
            else
            {
                if(controls.mouseDown)
                {
                    timer.start();
                    fireStarted = true;
                    fire();
                }
                else
                {
                    //Continue not firring
                }
            }
        }
        
        private function timer_timerHandler(event:TimerEvent):void
        {
            fire();
        }
        
        private function fire():void
        {
            var fixturePosition:b2Vec2 = fixture.GetBody().GetPosition().Copy();
            var mousePosition:b2Vec2 = _game.cameraToWorld(controls.mouseX, controls.mouseY).Copy();
            
            var directionVector:b2Vec2 = mousePosition.Copy(); 
            directionVector.Subtract(fixturePosition);
            directionVector.Normalize();
            directionVector.Multiply(3);
            
            var firePosition:b2Vec2 = fixturePosition.Copy();
            firePosition.Add(directionVector);
            
            var fire:b2Fixture = worldManager.createFixture(firePosition.x, firePosition.y, 20, 20, b2Body.b2_dynamicBody);
            
            var impusle:b2Vec2 = fixture.GetBody().GetLinearVelocity().Copy();
            
            
            directionVector.Multiply(20);
            
            impusle.Add(directionVector);
            
            fire.GetBody().SetLinearVelocity(impusle);
        }
    }
}