package com.graphics 
{
	import com.gfx.iSpriteModel;
	import com.gfx.SpriteModel;
	import com.gfx.SpritePool;
	import com.settings.Settings;
	import starling.display.Image;
	import starling.display.Sprite;
	import flash.display.BlendMode;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class BackgroundVO
	{
		
		private var _ref:Image;
		
		public function BackgroundVO() 
		{
			buildSprite();
		}
		
		private function buildSprite():void
		{
			// overriden in Santa Class
		}
		
		/**
		 * Destroy a sprite. It returns it and stores it on the pool
		 */
		private function destroySprite():void
		{
			
		}
		
		public function set reference(val:Image):void
		{
			_ref = val;
			_ref.touchable = false;
			_ref.blendMode = BlendMode.NORMAL;
			//_ref.scaleY = Settings.DEFAULT_BACKGROUND_SCALE;
			//_ref.scaleX = Settings.DEFAULT_BACKGROUND_SCALE_X;
			//_ref.scaleX = _ref.scaleY = .8;
			_ref.y = 0;
		}
		
		public function get reference():Image
		{
			return _ref;
		}
		
	}

}