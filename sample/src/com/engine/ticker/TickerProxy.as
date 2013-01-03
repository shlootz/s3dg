package com.engine.ticker 
{
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class TickerProxy 
	{
		/**
		 * Retrieves / Stores listeners from / into the TickerListenersVO
		 */
		public  function TickerProxy() 
		{
			//Constructor
		}
		
		/**
		 * Add a listener to the Game Tick.
		 * @param	callBack
		 */
		public static function addTickListener(callBack:Function):void
		{
			TickerListenersVO.tickListeners.push(callBack);
		}
		
		/**
		 * Remove a listener from the Game Tick.
		 * @param	callBack
		 */
		public static function removeTickListener(callBack:Function):void
		{
			
			var ticklistenersLength:uint = TickerListenersVO.tickListeners.length;
			
			for (var i:uint = 0; i < ticklistenersLength; i++ )
			{
				if (TickerListenersVO.tickListeners[i] == callBack)
				{
					TickerListenersVO.tickListeners.splice(i, 1);
				}
			}
		}
		
		/**
		 * Return all the listeners for the game tick
		 * @return
		 */
		public static function getTickListeners():Vector.<Function>
		{
			return TickerListenersVO.tickListeners;
		}
	}

}