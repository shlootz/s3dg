package com.preloader.ui 
{
	import com.assets.AssetsManager;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class PreloaderUI extends Sprite
	{
		/**
		 * 
		 */

		public function PreloaderUI() 
		{
			
		}
		
		public function load():void
		{
			var lImage:Image = new Image(AssetsManager.instance.atlas.getTexture("UI/Logo") );
		}
		
	}

}