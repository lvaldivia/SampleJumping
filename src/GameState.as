package
{
	
	
	import com.area51.elfder.objects.Cloud;
	import com.area51.elfder.objects.Elf;
	import com.area51.elfder.objects.GoalDoor;
	import com.area51.elfder.objects.LittleBars;
	import com.area51.elfder.objects.Prisioner;
	import com.area51.elfder.objects.Switch;
	
	import flash.display.Bitmap;
	
	import citrus.core.starling.StarlingState;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMakerStarling;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class GameState extends StarlingState
	{
		private var box2D:Box2D;
		private var hero:Elf;
		public function GameState()
		{
			super();
			var objects:Array = [Elf,Prisioner,Platform,Cloud,LittleBars,Switch,GoalDoor];
		}
		
		protected function createHero(heroName:String):void
		{
			hero = getObjectByName(heroName) as Elf;
			//hero.deadPoint = stage.stageHeight + 50;
		}
		
		override public function initialize():void
		{
			super.initialize();
			createPhysics();
			
			createMap();
			createHero("elf");
			createBerries();
		}
		
		private function createBerries():void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function createPhysics():void
		{
			box2D= new Box2D("box2D");
			box2D.gravity.y = 15;
			add(box2D);
		}
		
		protected function createMap():void
		{
			var currentMapBitmap:Class=Assets._MapAtlasPng as Class;
			var bitmap:Bitmap =new currentMapBitmap();
			var texture:Texture = Texture.fromBitmap(bitmap);
			var atlasConfig:Class=Assets._MapAtlasConfig as Class;
			var xml:XML = XML(new atlasConfig());
			var sTextureAtlas:TextureAtlas = new TextureAtlas(texture,xml);
			ObjectMakerStarling.FromTiledMap(XML(new Assets._MapLevel3()), sTextureAtlas);
		}
	}
}