package 
{
	
	import flash.geom.Point;
	
	import Box2D.Collision.b2Manifold;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.input.controllers.Keyboard;
	import citrus.math.MathVector;
	import citrus.objects.Box2DPhysicsObject;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.physics.box2d.IBox2DPhysicsObject;
	
	public class Elf extends Hero
	{
		private var _deadPoint:Number;
		private var _alive:Boolean = true;
		private var originalMax:Number;
		private var isRunning:Boolean;
		private var runnigVelocity:Number;
		private var kb:Keyboard;
		public function Elf(name:String, params:Object=null)
		{
			isRunning=true;
			super(name, params);
			this.canDuck=false;
			originalMax=1.5;
			this.maxVelocity=originalMax;
			this.view = AnimationsController.getMario();
			kb=_ce.input.keyboard;
			runnigVelocity=originalMax*1.3;
			registerKeyBoard();
		}
		
		private function registerKeyBoard():void
		{

			kb.addKeyAction("shift",Keyboard.SHIFT);
			kb.addKeyAction("p1",Keyboard.NUMBER_1);
			kb.addKeyAction("p2",Keyboard.NUMBER_2);
			kb.addKeyAction("p3",Keyboard.NUMBER_3);
			kb.addKeyAction("p4",Keyboard.NUMBER_4);
			kb.addKeyAction("p5",Keyboard.NUMBER_5);
			_ce.input.actionTriggeredOFF.add(checkkeyDown);
		}
		
		private function checkkeyDown(a:Object):void{
			if(a.name=="shift"){
				if(isRunning){
					isRunning=false;
					this.maxVelocity=originalMax;
				}
			}
		}
		
		override public function update(timeDelta:Number):void
		{
			var velocity:b2Vec2 = _body.GetLinearVelocity();
			if(controlsEnabled){
				var moveKeyPressed:Boolean = false;

				if(_ce.input.isDoing("p1",inputChannel)){
					runnigVelocity=originalMax*1.3;
				}
				if(_ce.input.isDoing("p2",inputChannel)){
					runnigVelocity=originalMax*1.6;
				}
				if(_ce.input.isDoing("p3",inputChannel)){
					runnigVelocity=originalMax*1.9;
				}
				if(_ce.input.isDoing("p4",inputChannel)){
					runnigVelocity=originalMax*2.2;
				}
				if(_ce.input.isDoing("p5",inputChannel)){
					runnigVelocity=originalMax*2.5;
				}
				if(_ce.input.isDoing("shift",inputChannel)){
					if(!isRunning){
						
						isRunning=true;
					}
				}
				
				if(_ce.input.isDoing("right",inputChannel)){
					
					velocity.Add(getSlopeBasedMoveAngle());
					if(isRunning){
						this.maxVelocity=runnigVelocity;
					}
					moveKeyPressed=true;
				}
				else if(_ce.input.isDoing("left",inputChannel)){
					velocity.Subtract(getSlopeBasedMoveAngle());
					moveKeyPressed = true;
					if(isRunning){
						this.maxVelocity=runnigVelocity;
					}
				}
				if (moveKeyPressed && !_playerMovingHero)
				{
					_playerMovingHero = true;
					_fixture.SetFriction(0);
				}
				else if (!moveKeyPressed && _playerMovingHero)
				{
					_playerMovingHero = false;
					_fixture.SetFriction(_friction);
				}
			}
			updateAnimation();
			super.update(timeDelta);
		}
		
		override protected function updateAnimation():void
		{
			var prevAnimation:String = _animation;
			
			var walkingSpeed:Number = getWalkingSpeed();
			if(!_onGround){
				_animation = "jump";
				if (walkingSpeed < -acceleration)
					_inverted = true;
				else if (walkingSpeed > acceleration)
					_inverted = false;
			}
			else {
				if (walkingSpeed < -acceleration) {
					_inverted = true;
					_animation = "walk";
					
				} else if (walkingSpeed > acceleration) {
					_inverted = false;
					_animation = "walk";
				}
			}
			super.updateAnimation();
		}
		
		
		override public function handleBeginContact(contact:b2Contact):void
		{
			var collider:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);
			//trace("collider "+collider);
			if (contact.GetManifold().m_localPoint && !(collider is Sensor)) 
			{                                
				var normalPoint:Point = new Point(contact.GetManifold().m_localPoint.x, contact.GetManifold().m_localPoint.y);
				var collisionAngle:Number = new MathVector(normalPoint.x, normalPoint.y).angle * 180 / Math.PI;
				var collName:String = collider.body.GetDefinition().userData.name;
				//trace("colName "+collName);
				if ((collisionAngle > 45 && collisionAngle < 135) || (collisionAngle > -30 && collisionAngle < 10 && collisionAngle != 0) || collisionAngle == -90 || (collName == "Nube" && collisionAngle == 180))
				{
					if (collider is MovingCloud && (collider as MovingCloud).oneWay && collider.y < y){
						//trace("Nube");
						return;
					}
					//trace("es cualquier otra cosa");
					_groundContacts.push(collider.body.GetFixtureList());
					_onGround = true;
					updateCombinedGroundAngle();
				}
			}
			super.handleBeginContact(contact);
		}
		
		
		
		override public function handleEndContact(contact:b2Contact):void
		{
			var collider:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);
			var collName:String = collider.body.GetDefinition().userData.name;
			var index:int = _groundContacts.indexOf(collider.body.GetFixtureList());
			if (index != -1)
			{
				_groundContacts.splice(index, 1);
				if (_groundContacts.length == 0)
					_onGround = false;
				updateCombinedGroundAngle();
			}
			super.handleEndContact(contact);
		}
		
		override public function handlePreSolve(contact:b2Contact, oldManifold:b2Manifold):void
		{
			if (!_ducking)
				return;
			
			var other:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);
			if (!((other as Box2DPhysicsObject).name.substr(0, 3) == "bri"))
			{
				var heroTop:Number = y;
				var objectBottom:Number = other.y + (other.height / 2);
				
				if (objectBottom < heroTop)
					contact.SetEnabled(false);
			}
			super.handlePreSolve(contact, oldManifold);
		}
		
		
		override public function destroy():void
		{
			//kb.resetAllKeyActions();
			//kb.destroy();
			super.destroy();
		}
		
		public function get deadPoint():Number
		{
			return _deadPoint;
		}

		public function set deadPoint(value:Number):void
		{
			_deadPoint = value;
		}

		public function get alive():Boolean
		{
			if(this.y >= deadPoint)
			{
				_alive = false;
			}else
			{
				_alive = true;
			}
			return _alive;
		}

		public function set alive(value:Boolean):void
		{
			_alive = value;
		}

		
	}
}