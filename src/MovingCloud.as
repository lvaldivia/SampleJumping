package 
{
	import citrus.objects.platformer.box2d.MovingPlatform;
	public class MovingCloud extends MovingPlatform
	{
		private var limitTop:Number;
		public function MovingCloud(name:String, params:Object=null)
		{
			super(name, params);
			var bg:Class=Assets._CloudPng;
			this.view=new bg();
			this.oneWay=true;
		}

		override public function update(timeDelta:Number):void
		{
			if(_passengers.length>0){
			}
			super.update(timeDelta);
		}
		
	}
}