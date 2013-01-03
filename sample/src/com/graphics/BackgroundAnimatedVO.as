package com.graphics 
{
	import com.assets.AssetsManager;
	import com.gfx.iSpriteModel;
	import com.gfx.SpriteModel;
	import com.gfx.SpritePool;
	import com.settings.Settings;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class BackgroundAnimatedVO
	{
		
		private var _ref:MovieClip;
		private var _tween:Tween;
		private var _hill:Image;
		public var _addChild:Function;
		
		public function BackgroundVO():void
		{
			buildSprite();
		}
		
		public function buildSprite():void
		{
			/**
			 * @TODO 
			 */
			
		}
		
		private function addTween(target:Image, isInBackground:Boolean = false, initialPosition:uint = 550, animTime:uint = 40):void 
		{
			/**
			 * Main Animation
			 */
			
			
		}
		
		private function resetTween(target:Image):void
		{
			addTween(target);
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
			_ref.scaleX = 1.35;
			_ref.scaleY = 1.35;
			_ref.loop = true;
			_ref.y = Settings.ANIMATED_PLATFORM_Y_OFFSET;
			_ref.fps = Settings.PLATFORM_FPS;
		}
		
		public function get reference():MovieClip
		{
			return _ref;
		}
		
		public function get backgroundHill():Image
		{
			var img:Image = new Image(AssetsManager.instance.atlas.getTexture("Background/Background-Snow"));
			img.scaleX = 1.35;
			img.scaleY = 1.35;
			img.y = Settings.STATIC_PLATFORM_Y_OFFSET;
			return img;
		}
		
	}

}