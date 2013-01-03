package com.save 
{
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Save 
	{
		
		private var _saveSO:SharedObject;
		
		public function Save() 
		{
			_saveSO = SharedObject.getLocal("sf");
			if (_saveSO.data)
			{
				_saveSO.data.hs = {score:0}
				_saveSO.flush();
			}
		}
		
		public function doSave(currentScore:uint):void
		{
			if (_saveSO.data.hs["score"] < currentScore)
			{
				_saveSO.data.hs = { score:currentScore };
				_saveSO.flush();
			}
		}
		
		public function getCurrentHighScore():uint
		{
			if (_saveSO.data.hs["score"] != undefined)
			{
				return _saveSO.data.hs["score"];
			}
			return 0;
		}
		
	}

}