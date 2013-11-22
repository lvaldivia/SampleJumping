package
{
	import citrus.core.starling.StarlingCitrusEngine;
	
	import starling.events.Event;
	[SWF(width="1024", height="608", frameRate="60", backgroundColor="#000000")]
	public class sampleJump extends StarlingCitrusEngine
	{
		public function sampleJump()
		{
			setUpStarling(true);
		}
		
		override protected function _context3DCreated(evt:Event):void
		{
			super._context3DCreated(evt);
			state=new GameState();
		}
	}
}