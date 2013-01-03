package com.engine.ticker 
{
	import starling.events.Event;
	import starling.events.EventDispatcher;

	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Ticker 
	{
		/**
		 * Keeps track of all the ticker listeners
		 */
		private static var _instance:Ticker = new Ticker();
		private var _isPaused:Boolean = false;
		/**
		 * At init starts Ticker
		 * Provides game functionality
		 */
		public function Ticker() 
		{
			if (_instance != null)
			{
				throw new Error("Engine is singleton !");
			}
		}
		
		/**
		 * 
		 */
		public static function get instance():Ticker
		{
			return _instance;
		}
		
		
		/**
		 * Gives a tick
		 * @param	e
		 */
		public function tickOnce(e:Event):void
		{
			
		var listenersLength:uint = TickerProxy.getTickListeners().length;	
			
		if (!_isPaused)
			{	
				for (var i:uint = 0; i < listenersLength; i++ )
				{
					TickerProxy.getTickListeners()[i].call();
				}
			}
		}
		
		public function setPause(isPased:Boolean = true):void
		{
			_isPaused = isPased;
		}
		
	}

}