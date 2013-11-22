package 
{
	import citrus.view.starlingview.AnimationSequence;
	
	
	
	import flash.display.Bitmap;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class AnimationsController
	{
		public static function getMario():AnimationSequence {
			var bmpMario:Class= Assets.MarioAtlasTexture;
			var bitmap:Bitmap = new bmpMario();
			var texture:Texture = Texture.fromBitmap(bitmap);
			
			var xmlMario:Class=Assets.MarioAtlasXML;
			var xml:XML = XML(new xmlMario());
			
			var sTextureAtlas:TextureAtlas = new TextureAtlas(texture,xml);
			
			var anim:AnimationSequence = new AnimationSequence(sTextureAtlas, ["walk","idle","jump","jumpfall"], "idle",9); 
			return anim;
		}
	}
}