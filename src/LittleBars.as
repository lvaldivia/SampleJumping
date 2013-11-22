package 
{

	public class LittleBars extends InteractivePlatform
	{
		public function LittleBars(name:String, params:Object=null)
		{
			super(name, params);
			var bg:Class=Assets._BarritaPng;
			this.view=new bg();
		}
		
	}
}