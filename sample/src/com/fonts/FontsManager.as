package com.fonts 
{
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class FontsManager 
	{
		
		[Embed(source="/fonts/santa.fnt", mimeType="application/octet-stream")]
		public static const FontXml:Class;
 
		[Embed(source = "/fonts/santa_0.png")]
		public static const FontTexture:Class;
 
		private static var texture:Texture = Texture.fromBitmap(new FontTexture());
		private static var xml:XML = XML(new FontXml());
	
		public static function getFontTexture():Texture
		{
			return texture;
		}
		
		public static function getFontXML():XML
		{
			return xml;
		}
		
	}

}