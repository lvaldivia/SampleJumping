package
{

	public class GoalDoor extends InteractivePlatform
	{
		private var _active:Boolean;
		
		public function GoalDoor(name:String, params:Object=null)
		{
			super(name, params);
			this.rotation = 90;
		}
		
		public function setView():void{
			var bg:Class=Assets._ShadowPlatformPng;
			this.view=new bg();
		}
	}
}