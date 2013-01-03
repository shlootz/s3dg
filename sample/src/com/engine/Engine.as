package com.engine 
{
	import com.engine.ticker.Ticker;
	import starling.display.Stage;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public final class Engine 
	{
		
		private var _ticker:Ticker;
		
		/**
		 * Engine is singleton. Only one instance per game.
		 */
		private static var _instance:Engine = new Engine();
		/**
		 * At init starts Ticker
		 * Provides game functionality
		 */
		public function Engine() 
		{
			if (_instance != null)
			{
				throw new Error("Engine is singleton !");
			}
		}
		
		/**
		 * 
		 */
		public static function get instance():Engine
		{
			return _instance;
		}
		
		/**
		 * Starts the Enter Frame event
		 */
		public function startEngine():void
		{
			
		}
		
		/**
		 * Pauses the game
		 */
		public function pauseEngine():void
		{
			Ticker.instance.setPause();
		}
		
		/**
		 * Resumes the game
		 */
		public function resumeEngine():void
		{
			Ticker.instance.setPause(false);
		}
		
		/**
		 * Resets the engine followed by the Start Engine
		 */
		public function resetEngine():void
		{
			
		}
		
		/**
		 * Stops the game
		 */
		public function stopEngine():void
		{
			
		}
		
		/**
		 * Chages the frame rate of the entire game
		 * @param	value
		 */
		public function setFrameRate(value:uint):void
		{
			
		}
		
	}

}