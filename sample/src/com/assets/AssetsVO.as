package com.assets 
{
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	
	public class AssetsVO
	{
		/**
		 * Main Sprite Sheet
		 */
		[Embed(source = "/assets/santaAssets.png")]
		public static const santaAssets:Class; 
		/**
		 * Main Sprite Sheet XML
		 */
		[Embed(source = "/assets/santaAssets.xml", mimeType = "application/octet-stream")]
		public static const santaAssetsXML:Class;
		
		public static const objectsMap:Vector.<String> = new Vector.<String>;
	}
}