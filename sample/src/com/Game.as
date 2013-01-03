package com 
{
	import com.actors.CanonVO;
	import com.assets.AssetsManager;
	import com.engine.Engine;
	import com.engine.ticker.Ticker;
	import com.engine.ticker.TickerProxy;
	import com.gfx.SpritePool;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Game extends Sprite implements iGame
	{
		/**
		 * Starts the Engine
		 */
		private var _engine:Engine; 
		private var _assetsManager:AssetsManager;
		protected var _juggler:Juggler;
		 
		/**
		 * Init game
		 */
		public function Game()
		{
			 addEventListener(starling.events.Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			_juggler = new Juggler();
			Starling.juggler.add(_juggler);
			_engine = getEngine();	
			_assetsManager = AssetsManager.instance;
			init();
		}
		
		/**
		 * init all resources for commom
		 */
		protected function init():void
		{
			SpritePool.initialize(0, 1);
			AssetsManager.instance.createSprites();
			addInitAssetsOnStage();
			initEventListeners();
		}
		
		/**
		 * init all common event listeners
		 */
		protected function initEventListeners():void
		{
			
		}
		
		/**
		 * add basic graphics on stage
		 */
		protected function addInitAssetsOnStage():void
		{
			
		}
	
		/**
		 * Instance of Engine
		 * @return
		 */
		public function getEngine():Engine
		{
			return Engine.instance;
		}
		
		/**
		 * begin Starling Tick
		 */
		private function beginTick():void
		{
			addEventListener(Event.ENTER_FRAME, tick);
		}
		
		/**
		 * Receive Starling Tick Event
		 * @param	e
		 */
		private function tick(e:Event):void
		{
			(Ticker.instance as Ticker).tickOnce(e);
		}
		
		/**
		 * 
		 * @param	callBack
		 */
		protected function addTickListener(callBack:Function):void
		{
			TickerProxy.addTickListener(callBack);
		}
		
		/**
		 * 
		 * @param	callBack
		 */
		protected function removeTickListener(callBack:Function):void
		{
			TickerProxy.removeTickListener(callBack);
		}
		
		/**
		 * 
		 * @param	e
		 */
		
	}

}