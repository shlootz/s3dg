package com.utils 
{
	import com.settings.Settings;
	import starling.animation.Juggler;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.display.Stage;
	import flash.system.Capabilities;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Camera
	{
		
		public static const ACTION_ZOOM_IN:String = "actionZoomIn";
		public static const ACTION_ZOOM_OUT:String = "actionZoomOut";
		public static const ACTION_ZOOM_MAIN_CHARACTER:String = "actionZoomMainCharacter";
		public static const ACTION_ZOOM_POINT_OF_INTEREST:String = "actionZoomPointOfInterest";
		public static const ACTION_SHAKE:String = "actionShake";
		
		private var _enabled:Boolean = true;
		private var _target:Sprite;
		private var _juggler:Juggler;
		private var _tween:Tween;
		
		private var _afterShake:uint = 5;
		
		public var _state:String = "neutral";
		
		private var _origW:int;
		private var _origH:int;
		
		public function Camera(target:Sprite, stage:Stage) 
		{
			_target = target;
			_origW = Capabilities.screenResolutionX;
			_origH = stage.stageHeight - stage.stageHeight * .2;
		}
		
		public function zoom(action:String):void
		{
			//switch(action)
			//{
				//case ACTION_ZOOM_IN:
					//zoomIn();
					//_enabled = true;
				//
					//break;
				//case ACTION_ZOOM_OUT:
					//zoomOut();
					//_enabled = true;
					//
					//break;
				//case ACTION_ZOOM_MAIN_CHARACTER:
					//_enabled = true;
				//
					//break;
				//case ACTION_ZOOM_POINT_OF_INTEREST:
					//_enabled = true;
				//
					//break;
				//case ACTION_SHAKE:
					//_enabled = true;
					//shake();
					//break;
				//default:
					//_enabled = false;
				//
					//break;
			//}
		}
		
		public function loop():void
		{
			
		}
		
		private function zoomIn():void
		{
			_tween = new Tween(_target, 3, Transitions.EASE_OUT);
			_tween.animate("width", _origW + _origW*.5);
			_tween.animate("height",_origH + _origH*.6);
			_tween.animate("y", _target.y + 220);
			_state = "zoomed";
			
			_juggler.add(_tween); 
		}
		
		private function zoomOut():void
		{
			_tween = new Tween(_target, 3, Transitions.EASE_OUT);
			_tween.animate("width", _origW);
			_tween.animate("height", _origH);
			_tween.animate("y", _target.y - 220);
			_state = "neutral";
			
			_juggler.add(_tween); 
		}
		
		private function shake():void
		{
			shakeIn();
		}
		
		private function shakeIn():void
		{
			_tween = new Tween(_target, .2, Transitions.EASE_OUT);
			_tween.animate("width", Settings.DEFAULT_ZOOM+.2);
			_tween.animate("height", Settings.DEFAULT_ZOOM_Y+.2);
			_tween.onComplete = shakeOut;
			
			_juggler.add(_tween); 
		}
		
		private function shakeOut():void
		{
			_tween = new Tween(_target, .2, Transitions.EASE_OUT);
			_tween.animate("width", Settings.DEFAULT_ZOOM);
			_tween.animate("height", Settings.DEFAULT_ZOOM_Y);
			//_tween.onComplete = shakeOut;
			
			_juggler.add(_tween); 
		}
		
		private function zoomMainCharacter():void
		{
			
		}
		
		private function zoomPointOfInterest():void
		{
			
		}
		
		public function set juggler(val:Juggler):void
		{
			_juggler = val;
		} 
		
	}

}