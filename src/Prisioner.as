package 
{
	
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.objects.platformer.box2d.Coin;
	
	public class Prisioner extends Coin
	{
		
		private var _isCollected:Boolean;
		
		public function Prisioner(name:String, params:Object=null)
		{
			super(name, params);
			this.onBeginContact.add(collisionWithHero);
			var bg:Class=Assets._BerryPng;
			this.view=new bg();
		}
		
		private function collisionWithHero(contact:b2Contact):void {
			if(contact.IsTouching()){
				_isCollected = true;
			}
		}
		
		public function get isCollected():Boolean
		{
			return _isCollected;
		}

		public function set isCollected(value:Boolean):void
		{
			_isCollected = value;
		}


		override public function destroy():void
		{
			// TODO Auto Generated method stub
			super.destroy();
		}
		
	}
}