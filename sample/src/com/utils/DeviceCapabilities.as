package com.utils
{
	//
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import starling.display.Sprite;
	import starling.display.Stage;
 
	public class DeviceCapabilities extends Sprite
	{
		public static function getScreenSize():Point
		{
			return new Point(Capabilities.screenResolutionX, Capabilities.screenResolutionY);
		}
	}
}