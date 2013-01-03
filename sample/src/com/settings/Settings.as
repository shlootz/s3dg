package com.settings 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Settings 
	{
		/**
		 * Preloader properties
		 */
		 public static const IOS:String = "ios";
		 public static const ANDROID:String = "android";
		 public static const BROWSER:String = "browser";
		 
		 public static const DEFAULT_DEVICE_EXPORT:String = "ios";
		 //public static const DEFAULT_DEVICE_EXPORT:String = "browser";
		 //public static const DEFAULT_DEVICE_EXPORT:String = "android";
		 
		 /**
		  * For desktop / web look into :
		  * ssounds manager for SoundMixer.audioPlaybackMode = AudioPlaybackMode.AMBIENT;
		  * user uinterface for : native
		  */
		 
		//--------------------------------------------------------------------------------------------------------------
		/**
		 * Canvas properties iOS
		 */ 
		//public static const DEFAULT_ZOOM:Number = 1.35;
		//public static const DEFAULT_ZOOM_Y:Number = 1.2;
		//public static const DEFAULT_SPLASH_TIMER:uint = 5;
		//public static const DEFAAULT_PRELOADER_TIMER:uint = 3;
		//public static const DEFAULT_BACKGROUND_SCALE:Number = 1.5;
		//public static const DEFAULT_BACKGROUND_SCALE_X:Number = 1.8;
		
		/**
		 * Canvas properties Website
		 */ 
		//public static const DEFAULT_ZOOM:Number = 1.35;
		//public static const DEFAULT_ZOOM_Y:Number = 1.2;
		//public static const DEFAULT_SPLASH_TIMER:uint = 5;
		//public static const DEFAAULT_PRELOADER_TIMER:uint = 3;
		//public static const DEFAULT_BACKGROUND_SCALE:Number = 1.5;
		//public static const DEFAULT_BACKGROUND_SCALE_X:Number = 1.8;
		
		/**
		 * Canvas properties FaceBook
		 */ 
		//public static const DEFAULT_ZOOM:Number = 1.35;
		//public static const DEFAULT_ZOOM_Y:Number = 1.2;
		//public static const DEFAULT_SPLASH_TIMER:uint = 5;
		//public static const DEFAAULT_PRELOADER_TIMER:uint = 3;
		//public static const DEFAULT_BACKGROUND_SCALE:Number = 1.5;
		//public static const DEFAULT_BACKGROUND_SCALE_X:Number = 1.8;
		
		/**
		 * Canvas properties Android
		 */
		
		public static const DEFAULT_ZOOM:Number = 1;
		public static const DEFAULT_ZOOM_Y:Number = 1;
		public static const DEFAULT_SPLASH_TIMER:uint = 5;
		public static const DEFAAULT_PRELOADER_TIMER:uint = 3;
		public static const DEFAULT_BACKGROUND_SCALE:Number = 1.35;
		public static const DEFAULT_BACKGROUND_SCALE_X:Number = 1.35;
		
		//--------------------------------------------------------------------------------------------------------------
		
		/**
		 * Platform properties
		 */
		public static const PLATFORM_FPS:uint = 30;
		
		//Android
		public static const ANDROID_Y_OFFSET:int = -30;
		public static const ANDROID_SCORE_X_OFFSET:int = -20;
		//iOS
		public static const IOS_Y_OFFSET:int = -140;
		public static const IOS_SCORE_X_OFFSET_IPAD:int = -100;
		public static const IOS_SCORE_X_OFFSET_IPHONE:int = -40;
		
		public static const ANIMATED_PLATFORM_Y_OFFSET:int = 710;
		public static const STATIC_PLATFORM_Y_OFFSET:int = 680;
		
		/**
		 * Buildings general properties
		 */
		public static const MAX_GEN_INTERVAL:uint = 120;
		public static const MIN_GEN_INTERVAL:uint = 40;
		public static const MIN_SPEED:uint = 2;
		public static const MAX_SPEED:uint = 1;
		public static const INIT_BUILDING_ROTATION:Number = .20;
		public static const END_BUILDING_ROTATION:Number = -0.31;
		public static const BUILDING_ANIMATION_DURATION:Number = 1;
		public static const BUILDINGS_SPAWN_X:uint = 250;
		public static const PIVOTY:uint = 1400;
		public static const GEN_BUILDING_X:uint = 225;
		
		//Front houses offsets
		public static const GEN_BUILDING_FRONT_Y:uint = 2130;
		
		//Back houses offsets
		public static const BACKGROUND_SPEED:uint = 15;
		public static const GEN_BUILDING_BACK_Y:uint = 2100;
		public static const BACK_BUILDING_1_OFFSET:uint = 0;
		public static const BACK_BUILDING_2_OFFSET:uint = 0;
		public static const BACK_BUILDING_3_OFFSET:uint = 0;
		 
		//Targets 
		public static const GEN_BUILDING_TARGET_Y:uint = 2000;
		public static const PIVOT_TARGET_Y:uint = 1400;
		
		//Targets
		public static const TARGET_0:Point = new Point(250, 2030);
		public static const TARGET_1:Point = new Point(250, 2020);
		public static const TARGET_2:Point = new Point(250, 2030);
		public static const TARGET_3:Point = new Point(250, 2020);
		public static const TARGET_4:Point = new Point(250, 2030);
		public static const TARGET_5:Point = new Point(250, 2020);
		public static const TARGET_6:Point = new Point(250, 2030);
		public static const TARGET_7:Point = new Point(250, 2020);
		
		//CheckPoint
		public static const CHECK_POINT_TIMER:uint = 60;
		public static const CHECK_POINT_SPEED:uint = 5;
		public static const CHECK_POINT_INCREMENT:uint = 200;
		public static const CHECK_POINT_INCREMENT_SCALAR:Number = 1.3;
		
	}

}