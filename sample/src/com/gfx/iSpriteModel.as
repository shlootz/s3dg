package com.gfx 
{
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public interface iSpriteModel 
	{
		/**
		 * Grab a sprite from the pool
		 */
		function buildSprite():void
		
		/**
		 * Destroy a sprite. It returns it and stores it on the pool
		 */
		function destroySprite():void
	}
	
}