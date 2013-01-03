package com.actors 
{
	import com.gfx.iSpriteModel;
	import com.gfx.SpriteModel;
	import com.gfx.SpritePool;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import flash.display.BlendMode;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class SantaVO
	{
		
		public static var _ref:MovieClip;
		
		public function SantaVO() 
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
		
		public function set reference(val:MovieClip):void
		{
			_ref = val;
			_ref.touchable = false;
			_ref.blendMode = BlendMode.NORMAL;
			//_ref.scaleX = _ref.scaleY = 1.2;
			//_ref.scaleX = _ref.scaleY = .6;
			_ref.fps = 30;
			_ref.y = 250;
		}
		
		public function get reference():MovieClip
		{
			return _ref;
		}
		
	}

}