package com.utils 
{
	import flash.geom.Rectangle;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Collisions 
	{
		
		private var _source1:Vector.<Image>;
		private var _source2:Vector.<Image>
		private var _targetSpace:DisplayObject;
		public var getProjectiles:Function;
		public var getTargets:Function;
		private var _collisionVectorProjectiles:Vector.<Image>
		private var _collisionVectorTargets:Vector.<Image>
		
		public function Collisions() 
		{
			_source1 = new Vector.<Image>;
			_source2 = new Vector.<Image>;
			_collisionVectorProjectiles = new Vector.<Image>
			_collisionVectorTargets = new Vector.<Image>
		}

		private var i:uint = 0;
		private var j:uint = 0;
		private var projectileRect:Rectangle;
		private var targetRect:Rectangle;
		private var isColliding:Boolean = false;
		
		public function checkCollision():void
		{
			//if (_source1 != null && _source2 != null )
			//{
				//if (_source1.length > 0 && _source2.length > 0)
				//{
					//for (i = 0; i < _source1.length; i++ )
					//{
						//if (_source1[i].parent != null)
						//{
							//projectileRect = _source1[i].getBounds(_targetSpace);
							//for (j = 0; j < _source2.length; j++ )
							//{
								//targetRect = _source2[j].getBounds(_targetSpace);
								//
								//if (projectileRect.intersects(targetRect))
								//{
									///**
									 //* Calculate collision area
									 //*/
									//
									//if (projectileRect.intersection(targetRect).size.y *
										//projectileRect.intersection(targetRect).size.x >= 
										//projectileRect.width * projectileRect.height 
										//- projectileRect.width* projectileRect.height * .8)
										//{
											//if (i < _source1.length)
											//{
												//if (_source1[i].visible && _source2[j].visible)
												//{
													//_source1[i].visible = false;
													//
													//_source2[j].visible = false;
												//}
											//}
										//}
								//}
							//}
						//}
					//}
				//}
			//}
		}
		
		/**
		 * TRY THIS
		 */
		//private static var sHelperPoint1:Point = new Point();
		//private static var sHelperPoint2:Point = new Point();
 
		//private function shoot():void{
		  //sHelperPoint1.x = _currentMouseX;
		  //sHelperPoint1.y = _currentMouseY;
		  //for each(var enemy:Enemy in _enemies){
			//if(enemy._alive && !enemy._dying){
			  //enemy.globalToLocal( sHelperPoint1, sHelperPoint2);
			  //partHit = enemy.hitTest(sHelperPoint2, false);
			  //if(partHit){
				//trace(enemy);
				//enemyHit = enemy;
				//break;
			  //}
			//}
		  //}
		//}
		 /**
		  * END TRY THIS
		  */
		
		private function markAsShot():void
		{
			if (_collisionVectorProjectiles.length > 0 && _collisionVectorTargets.length > 0)
			{
				_collisionVectorProjectiles[0].visible = false;
				_collisionVectorTargets[0].visible = false;
				
				_collisionVectorProjectiles.length = 0;
				_collisionVectorTargets.length = 0;
			}
		}
		
		public function set display(val:DisplayObject):void
		{
			_targetSpace = val;
		}
		
		public function set projectiles(val:Vector.<Image>):void
		{
			_source1 = val;
		}
		
		public function set targets(val:Vector.<Image>):void
		{
			_source2 = val;
		}
		
	}

}