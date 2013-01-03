package com.gfx
{ 
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	
   import flash.sampler.getSize;
   import starling.display.BlendMode;
   import starling.display.Image;
   import starling.display.MovieClip;
   import starling.display.Sprite;
     
    public final class SpritePool 
    { 
        private static var MAX_VALUE:uint; 
        private static var GROWTH_VALUE:uint; 
        private static var counter:uint; 
        private static var pool:Vector.<MovieClip> 
		private static var imagePool:Vector.<Image>
        private static var currentMovieClip:MovieClip; 
  
		/**
		 * 
		 * @param	maxPoolSize
		 * @param	growthValue
		 */
        public static function initialize( maxPoolSize:uint, growthValue:uint ):void 
        {
            MAX_VALUE = maxPoolSize; 
            GROWTH_VALUE = growthValue; 
            counter = maxPoolSize; 
           
            var i:uint = maxPoolSize; 
             
			imagePool = new Vector.<Image>;
            pool = new Vector.<MovieClip>(MAX_VALUE); 
            while( --i > -1 ) 
                pool[i] = new MovieClip(null); 
        } 
         
		/**
		 * 
		 * @return
		 */
        public static function getMovieClip():MovieClip 
        { 
           var temp:MovieClip = pool.shift();
			return temp;
        } 
		
		/**
		 * 
		 * @return
		 */
        public static function getImage():Image 
        { 
			/**
			 * Set the image scale
			 */
			var temp:Image = imagePool.shift();
			return temp;
        } 
  
		/**
		 * 
		 * @param	disposedMovieClip
		 */
        public static function disposeMovieClip(disposedSprite:MovieClip):void 
        { 
            pool[counter++] = disposedSprite; 
        } 
		
		/**
		 * 
		 * @param	newMovieClip
		 */
		public static function addMovieClip(newMovieClip:MovieClip, blendMode:String = BlendMode.NORMAL):void
		{
			newMovieClip.blendMode = blendMode;
			newMovieClip.touchable = false;
			//newMovieClip.smoothing = "none";
			pool.push(newMovieClip);
		}
		
		/**
		 * 
		 * @param	newImage
		 */
		public static function addImage(newImage:Image, blendMode:String = BlendMode.NORMAL, good:Boolean = true):void
		{
			var appendix:String = good?"1":"0";
			newImage.name = appendix;
			newImage.texture.repeat = false;
			newImage.blendMode = blendMode;
			//newImage.smoothing = "none";
			newImage.touchable = false;
			imagePool.push(newImage);
		}

    } 
}