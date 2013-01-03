package com.actors 
{
	import com.gfx.iSpriteModel;
	import com.utils.McFromSpriteSheet;
	import flash.geom.Point;
	import starling.animation.Juggler;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class CharacterLogic
	{
		
		private var _target:MovieClip;
		private var _tween:Tween;
		private var _juggler:Juggler;
		
		public function CharacterLogic() 
		{
			
		}
		
		public function startAnim(target:MovieClip):void
		{
			_target = target;
			_tween = new Tween(_target, 5, Transitions.EASE_IN_OUT);
			_tween.animate("y", _target.y + 50);
			_tween.onComplete = goUp;
			_juggler.add(_tween); 
		}
		
		private function goUp():void
		{
			_juggler.remove(_tween); 
			_tween = new Tween(_target, 5, Transitions.EASE_IN_OUT);
			_tween.animate("y", _target.y - 50);
			
			_tween.onComplete = goDown;
			_juggler.add(_tween); 
		}
		
		private function goDown():void
		{
			Starling.juggler.remove(_tween); 
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