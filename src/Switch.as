package 
{
	
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Sensor;

	public class Switch extends InteractivePlatform
	{
		private var _innerSensor:Sensor;
		private var _initialSensorSwitchX:Number;
		private var _initialSensorSwitchY:Number;
		private var _externalContact:Hero;
		private var _isTouchedByHero:Boolean;
		
		public function Switch(name:String, params:Object=null)
		{
			super(name, params);
			var bg:Class=Assets._SwitchPng;
			this.view=new bg();
		}
		
		public function get innerSensor():Sensor
		{
			if(_innerSensor == null)
			{
				_innerSensor = new Sensor("switch",{x:this.x, y:this.y-18, width:this.width-10, height:1});
				_innerSensor.onBeginContact.add(onSwitchContact);
				_initialSensorSwitchX = _innerSensor.x;
				_initialSensorSwitchY = _innerSensor.y;
			}
			return _innerSensor;
		}
		
		public function pushed(posY:Number):void{
			this.active = false;
			this.visible = false;
			this.innerSensor.visible = false;
			this.innerSensor.y =  posY;
			isTouchedByHero = false;
		}
		
		private function onSwitchContact(internalContact:b2Contact):void
		{
			collisionWithHero(internalContact, _externalContact);
		}
		
		public function release():void{
			this.active = true;
			this.visible = true;
			this.innerSensor.x = this.initialSensorSwitchX;
			this.innerSensor.y = this.initialSensorSwitchY;
			
	
		}
		
		private function collisionWithHero(contact:b2Contact, hero:Hero):void {
			if(contact.IsTouching()){
				//trace(hero.animation);
				if(hero.animation == "jump" || hero.animation == "idle" || hero.animation == "walk") {
					if(hero.y  + 20 <= this.y){
						//trace("press!");
						_isTouchedByHero = true;
					}
				}
			}
		}

		public function get isTouchedByHero():Boolean
		{
			return _isTouchedByHero;
		}

		public function set isTouchedByHero(value:Boolean):void
		{
			_isTouchedByHero = value;
		}

		public function set externalContact(value:Hero):void
		{
			_externalContact = value;
		}

		public function get initialSensorSwitchY():Number
		{
			return _initialSensorSwitchY;
		}
		
		public function get initialSensorSwitchX():Number
		{
			return _initialSensorSwitchX;
		}

	}
}