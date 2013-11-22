package 
{
	public class Assets
	{
		[Embed(source = "/imgs/mario.png")]
		public static const MarioAtlasTexture:Class;
		
		[Embed(source="/imgs/mario.xml", mimeType="application/octet-stream")]
		public static const MarioAtlasXML:Class;
		

		
		[Embed(source="/tmx/level1/level1-3.tmx", mimeType="application/octet-stream")]
		public static const _MapLevel3:Class;
		
		
		[Embed(source="/tmx/tileset5m.xml", mimeType="application/octet-stream")]
		public static const _MapAtlasConfig:Class;
		
		[Embed(source="/imgs/minifresa.png")]
		public static const _BerryPng:Class;
		
		[Embed(source="/tmx/tileset-5metros.png")]
		public static const _MapAtlasPng:Class;
		
		[Embed(source="/imgs/bloque-hueco.png")]
		public static const _ShadowPlatformPng:Class;
		
		[Embed(source="/imgs/switch.png")]
		public static const _SwitchPng:Class;
		
		[Embed(source="/imgs/barrita.png")]
		public static const _BarritaPng:Class;
		
		[Embed(source="/imgs/cloud.png")]
		public static const _CloudPng:Class;
		
		[Embed(source="/imgs/falsopiso.png")]
		public static const _FalsePng:Class;
		
		[Embed(source="/imgs/barritaMini.png")]
		public static const _FalseMiniPng:Class;
		
		[Embed(source="/imgs/spike.png")]
		public static const _SpikePng:Class;
	}
}