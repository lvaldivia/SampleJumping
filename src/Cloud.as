package 
{
	
	import flash.utils.setTimeout;
	
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Sensor;

	public class Cloud extends InteractivePlatform
	{
		private var _innerSensor:Sensor;
		public var topLimit:Number;
		private var _initialSensorSwitchX:Number;
		private var _initialSensorSwitchY:Number;
		private var _initialCloudX:Number;
		private var _initialCloudY:Number;
		private var _externalContact:Hero;
		private var _isTouchedByHero:Boolean;
		
		public function Cloud(name:String, params:Object=null)
		{
			super(name, params);
			var bg:Class=Assets._CloudPng;
			this.view=new bg();
			_initialCloudX = this.x;
			_initialCloudY = this.y;
		}
		
		public function get innerSensor():Sensor
		{
			if(_innerSensor == null)
			{
				_innerSensor = new Sensor("switch",{x:this.x, y:this.y-18, width:this.width-10, height:1});
				_innerSensor.onBeginContact.add(onCloudContact);
				_initialSensorSwitchX = _innerSensor.x;
				_initialSensorSwitchY = _innerSensor.y;
			}
			return _innerSensor;
		}
		
		public function setLimitTop(limit:Number):void{
			topLimit=limit;
		}
		
		public function move():void{
			if(this.isTouchedByHero){
				this._innerSensor.x = -100;
				this.y+=5;
				if(this.y >= topLimit)
				{
					this.y = this.initialCloudY;
					this.x = this.initialCloudX;
					this._innerSensor.y = this.y - 18;
					this._innerSensor.x = this.x;
					this.isTouchedByHero = false;
				}
			}
		}
		
		public function setRandomXBetween(minNum:Number, maxNum:Number):void
		{
			this.x = (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
			_initialCloudX = this.x;
			_innerSensor.x = this._initialCloudX;
		}
		
		public function setRandomYBetween(minNum:Number, maxNum:Number):void
		{
			this.y = (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
			_initialCloudY = this.y;
			_innerSensor.y = this._initialCloudY-18;
		}
		
		private function onCloudContact(internalContact:b2Contact):void
		{
			collisionWithHero(internalContact, _externalContact);
		}
		
		private function collisionWithHero(contact:b2Contact, hero:Hero):void {
			if(contact.IsTouching()){
				//trace(hero.animation);
				if(hero.animation == "jump" || hero.animation == "idle" || hero.animation == "walk") {
					//trace("press!");
					setTimeout(afterSomeSeconds,500);
				}
			}
		}
		
		private function afterSomeSeconds():void
		{
			_isTouchedByHero = true;
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
		
		public function get initialCloudY():Number
		{
			return _initialCloudY;
		}
		
		public function get initialCloudX():Number
		{
			return _initialCloudX;
		}

	}
}