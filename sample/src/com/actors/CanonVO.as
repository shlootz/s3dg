package com.actors 
{
	import com.gfx.iSpriteModel;
	import com.gfx.SpriteModel;
	import com.gfx.SpritePool;
	import flash.geom.Point;
	import starling.animation.Juggler;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import flash.display.BlendMode;
	import starling.utils.deg2rad;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class CanonVO
	{
		
		public static var _ref:Image;

		private static var cy:Number;
		private static var cx:Number;
		// find out the angle
		private static var Radians:Number;
		// convert to degrees to rotate
		private static var Degrees:Number;
		
		private var _tween:Tween;
		private var _target:Image;
		
		private var _juggler:Juggler;
		
		private static var _pt:Point;
		
		public function CanonVO() 
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
			_ref.y = SantaVO._ref.y + 35;
			_ref.x = SantaVO._ref.x + 150;
			//_ref.scaleX = _ref.scaleY = 1.2;
			_ref.pivotX = 25;
			_ref.pivotY = 15;
			_target = _ref;
			startAnim();
		}
	
		private static var angleRad:Number;
		private static const PITransformed:Number  = 565.4866776461627;
		
		public static function rotate(pt:Point):void
		{
			cx = pt.x - _ref.x;
			cy = pt.y - _ref.y;
			angleRad = Math.atan2(cy, cx) / PITransformed ;
			Radians =  angleRad * PITransformed;
			_ref.rotation = Radians ;
		}
		
		public function get reference():Image
		{
			return _ref;
		}
		
		public static function get destPoint():Point
		{
			return _pt;
		}
		
		private function startAnim():void
		{
			_tween = new Tween(_target, 5, Transitions.EASE_IN_OUT);
			_tween.animate("y", _target.y + 50);
			//_tween.animate("x", _target.x + int(Math.random()*50));
			_tween.onComplete = goUp;
			_juggler.add(_tween); 
		}
		
		private function goUp():void
		{
			_juggler.remove(_tween); 
			_tween = new Tween(_target, 5, Transitions.EASE_IN_OUT);
			_tween.animate("y", _target.y - 50);
			//_tween.animate("x", _target.x - int(Math.random()*50));
			_tween.onComplete = goDown;
			_juggler.add(_tween); 
		}
		
		private function goDown():void
		{
			_juggler.remove(_tween); 
			_tween = new Tween(_target, 5, Transitions.EASE_IN_OUT);
			_tween.animate("y", _target.y + 50);
			//_tween.animate("x", _target.x + int(Math.random()*50));
			_tween.onComplete = goUp;
			_juggler.add(_tween); 
		}

		public function set juggler(val:Juggler):void
		{
			_juggler = val;
		}
	}

}