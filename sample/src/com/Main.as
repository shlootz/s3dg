package com
{
	//import flash.desktop.NativeApplication;
	import com.settings.Settings;
	import com.utils.newSanta;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.SoundTransform;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import starling.core.Starling;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import flash.media.SoundMixer;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	/**
	 * Some documentation
	 * http://wiki.starling-framework.org/extensions/start
	 */
	
	public class Main extends Sprite 
	{
		private static const SPLASH_INTERVAL_TIMEOUT:uint = 2000;
		/**
		 * Splash
		 */
		
		[Embed (source = "/assets/splash.png")]
		private var Splash:Class;
		private var splash:Bitmap; 
		
		private var splashInter:Number = setInterval(clearSplash, SPLASH_INTERVAL_TIMEOUT);
		 
		/**
		 * Starling reference
		 */ 
		protected var _starling:Starling;
		
		public var playerTouchPhase:String;
		public var playerTouchPoint:Point;
		public var touchPhase:String;
		public var touchPoint:Point;
		/**
		 * Entry point to the game.
		 * Initializes Starling, Nape and Game
		 */
		public function Main():void 
		{
			//stage.quality = StageQuality.MEDIUM;
			//stage.align = StageAlign.TOP_LEFT; 
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			addEventListener(Event.ADDED_TO_STAGE, onInit, false, 0, true);
			
			/**
			 * Add a splash image while initializing.
			 */
			

			/**
			 * Add event listeners for minimizing / maximizing app
			 */
			addEventListener(Event.DEACTIVATE, deactivate);
			addEventListener(Event.ACTIVATE, activate);
			
			// entry point
		}
		
		private function onInit (event:Event):void 
		{
			//if (Settings.DEFAULT_DEVICE_EXPORT == Settings.ANDROID)
			//{
				splash = new Splash();
				splash.smoothing = true;
				//splash.width = stage.stageWidth;
				//splash.height = stage.stageHeight;
				
				splash.width = Capabilities.screenResolutionX;
				splash.height = Capabilities.screenResolutionY;
				addChild(splash);
			//}
			// touch or gesture?
			removeEventListener(Event.ADDED_TO_STAGE, onInit)
			Starling.multitouchEnabled = false;
			_starling = new Starling(Santa, stage);
			//_starling.viewPort.width = stage.stageWidth;
			//_starling.viewPort.height = stage.stageHeight;
			//_starling.showStats = true;
			_starling.start();
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function deactivate(e:Event):void 
		{
			// auto-close
			//NativeApplication.nativeApplication.exit();
			SoundMixer.soundTransform = new SoundTransform(0);
			stage.frameRate = 1;
			_starling.stop();
			
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function activate(e:Event):void 
		{
			// auto-close
			//NativeApplication.nativeApplication.exit();
			SoundMixer.soundTransform = new SoundTransform(1);
			stage.frameRate = 60;
			_starling.start();
		}
		
		private function clearSplash():void
		{
			System.gc();
			clearInterval(splashInter);
			//if (Settings.DEFAULT_DEVICE_EXPORT == Settings.ANDROID)
			//{
				removeChild(splash);
				splash.bitmapData.dispose();
				splash = null;
			//}
		}
	
	}
	
}