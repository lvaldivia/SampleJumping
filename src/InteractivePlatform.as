package 
{
	import citrus.objects.platformer.box2d.Platform;
	
	public class InteractivePlatform extends Platform
	{
		private var _active:Boolean;
		
		public function InteractivePlatform(name:String, params:Object=null)
		{
			super(name, params);
		}
		
		public function set active(value:Boolean):void
		{
			this.body.SetActive(value);
			_active = value;
		}

		public function get active():Boolean
		{
			return _active;
		}

		
	}
}