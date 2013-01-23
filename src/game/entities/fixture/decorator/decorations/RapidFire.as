package game.entities.fixture.decorator.decorations
{
    import Box2D.Common.Math.b2Vec2;

    import game.Game;

    import game.entities.fixture.IFixtureEntity;
    import game.entities.fixture.WorldManager;
    import game.entities.fixture.decorator.AFixtureDecorator;

    public class RapidFire extends AFixtureDecorator
    {
        private var controls:Controls;
        private var worldManager:WorldManager;
        
        private var fireStarted:Boolean = false;
        private var rateCounter:int = 0; 
        private var rate:int = 1;
        private var _game:Game;
        private var speed:Number = 7.5/2;

        public function RapidFire(controls:Controls, worldManager:WorldManager, game:Game)
        {
            this.controls = controls;
            this.worldManager = worldManager;
            this._game = game;
        }
        
        protected override function behavior():void
        {
            rateCounter++;
            if(fireStarted)
            {
                if(controls.mouseDown)
                {
                    if(rateCounter>rate)
                    {
                        rateCounter=0;
                        fire();
                    }
                }
                else
                {
                    fireStarted = false;
                }
            }
            else
            {
                if(controls.mouseDown)
                {
                    fireStarted = true;
                    rateCounter = 0;
                    fire();
                }
                else
                {
                    //Continue not firring
                }
            }
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
            
            var fire:IFixtureEntity = worldManager.createFire(firePosition.x, firePosition.y);
            
            var impusle:b2Vec2 = fixture.GetBody().GetLinearVelocity().Copy();
            
            directionVector.Multiply(speed);
            
            impusle.Add(directionVector);
            
            fire.fixture.GetBody().SetLinearVelocity(impusle);
            
            //worldManager.cull(fire.fixture);
        }
    }
}