package com.actors 
{
	import com.assets.AssetsManager;
	import com.settings.Settings;
	import com.utils.DeviceCapabilities;
	import flash.geom.Point;
	import flash.utils.SetIntervalTimer;
	import starling.animation.Juggler;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.events.EnterFrameEvent;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Buildings 
	{
		
		
		public var _refFront:Vector.<Image>;
		public var _refBack:Vector.<Image>;
		public var _refCheckPoint:Image;
		private var _frontHousesTweens:Vector.<Tween>;
		private var _backHousesTweens:Vector.<Tween>;
		private var _targetsTweens:Vector.<Tween>;
		public var _refTargets:Vector.<Image>;
		private var _onScreenTargets:Vector.<Image>;
		private var _addChild:Function;
		private var _swapChildren:Function;
		private var _removeChild:Function;
		private var _tween:Tween;
		private var _tweenTargets:Tween;
		private var _randomHouse:uint = 0;
		private var _updateScore:Function;
		private var _juggler:Juggler;
		private var timeStamp:Number = 0;
		private var delay:uint = 2;
		private var bullsEye:Image;
		private var _started:Boolean = false;
		private var _generationTime:uint = Settings.MAX_GEN_INTERVAL;
		private var _targetIndex:uint = 0;
		private var _targetOffsets:Vector.<Point> = new Vector.<Point>;
		private var _checkPointTween:Tween;
		
		public static const MAX_BUIDLINGS_RENDERED:uint = 3;
		
		public function Buildings() 
		{
			_refFront = new Vector.<Image>;
			_refBack = new Vector.<Image>;
			_refTargets = new Vector.<Image>
			_onScreenTargets = new Vector.<Image>;
			_frontHousesTweens = new Vector.<Tween>;
			_backHousesTweens = new Vector.<Tween>;
			_targetsTweens = new Vector.<Tween>;
		}
		
		public function arrangeHouses():void
		{
			_targetIndex = 0;
			_started = true;
			_checkPointTween = new Tween(checkPoint, Settings.CHECK_POINT_SPEED);
		}
		
		public function startCheckPoint():void
		{
			_addChild(_refCheckPoint);
			_checkPointTween.reset(_checkPointTween.target, _checkPointTween.totalTime)
			checkPoint.rotation = Settings.INIT_BUILDING_ROTATION;
			_checkPointTween.animate("rotation", Settings.END_BUILDING_ROTATION);
			_checkPointTween.onComplete = resetCheckPoint;
			
			_juggler.add(_checkPointTween);
		}
		
		private function resetCheckPoint():void
		{
			_juggler.remove(_checkPointTween);
			_removeChild(_refCheckPoint);
		}
		
		private function checkLoseSituation():void
		{
			
		}
		
		public function tick(e:EnterFrameEvent):void
		{
			e.stopPropagation();
			
			if (_started)
			{
				timeStamp ++
			}

			if (timeStamp == 120 )
			{
				
				if (_refBack.length > 0) addTween(referenceBackHomes, true, 0);
				//if (_refBack.length > 0) addTween(referenceBackHomes, true, 4);
				//if (_refBack.length > 0) addTween(referenceBackHomes, true, 7);

				
				if (_refFront.length > 0)
				{
					addTween(referenceFrontHomes, false);
				}
				
				timeStamp = 0;
			}
		}

		private function addTween(target:Image, isInBackground:Boolean = false, extraDelay:uint = 0):void 
		{
			/**
			 * Main Animation
			 */
			var speed:uint = 0;
			delay = extraDelay;
			
			//target.pivotY = 1400 + target.height;
			target.rotation = Settings.INIT_BUILDING_ROTATION;

			if (isInBackground)
			{
				_tween = _backHousesTweens.shift();
				speed = Settings.BACKGROUND_SPEED;
			}
			else
			{
				_tween = _frontHousesTweens.shift();
				speed = Settings.MIN_SPEED;
			}

			_tween.reset(_tween.target, speed);
			_tween.onStartArgs = [target, bullsEye, isInBackground, delay];
			_tween.onStart = makeVisible;
			_tween.delay = delay;
			_tween.animate("rotation", Settings.END_BUILDING_ROTATION);
			
			 _tween.onCompleteArgs = [target, isInBackground, _tween]

			_tween.onComplete = resetTween;
			
			_juggler.add(_tween); 
			
		}
		
		private function addBullsEye(target:Image, animTime:uint, delay:uint ):void
		{
			if (_targetIndex == _targetOffsets.length - 1)
			{
				_targetIndex = 0;
			}
			else
			{
				_targetIndex ++
			}
			
			if (_refTargets.length == 0)
			{
				var tempImage:Image = new Image(AssetsManager.instance.atlas.getTexture("UI/Target") )
				_refTargets.push(tempImage);
			}
			else
			{
				bullsEye = referenceTargets;
			}
			
			bullsEye.rotation = Settings.INIT_BUILDING_ROTATION;
			
			bullsEye.visible = false;
			
			if (delay != 0)
			{
				bullsEye.x = 200;
			}
			
			_tween = _targetsTweens.shift();
			_tween.reset(bullsEye, animTime);
			_tween.delay = delay;
			_tween.animate("rotation", Settings.END_BUILDING_ROTATION);
			_tween.onStartArgs = [bullsEye]
			_tween.onStart = makeBullsEyeVisible;
			_tween.onCompleteArgs = [bullsEye, _tween, _onScreenTargets.length];
			_tween.onComplete = resetTargetTween;
				
			_addChild(bullsEye);
			_onScreenTargets.push(bullsEye);
			_juggler.add(_tween);
			
		}
		
		private function makeBullsEyeVisible(bullsEye:Image):void
		{
			bullsEye.visible = true;
		}
		
		private function makeVisible(target:Image, bullsEye:Image, isInBackground:Boolean = false, delay:Number = 0):void
		{
			if (target.parent == null)
			{
				_addChild(target);
				
				if (!isInBackground)
				{
					addBullsEye(target, Settings.MIN_SPEED, delay);
				}
				else
				{
					addBullsEye(target, Settings.BACKGROUND_SPEED, delay);
				}
			}
			
			target.visible = true;
		}
		
		private function makeTargetVisible(target:Image):void
		{
			target.visible = true;
		}
		
		private function resetTargetTween(target:Image, tween:Tween, index:uint):void
		{
		
			var i:uint = _onScreenTargets.length - 1;
			
			_refTargets.push(target);
			
			targetLoop : while (i > 0)
			{
				if (_onScreenTargets[i] == target)
				{
					_onScreenTargets.splice(i, 1);
					break targetLoop;
				}
				
				i -- ;
			}
			
			_removeChild(target);
			_targetsTweens.push(tween);
			
			_juggler.remove(tween);
		}
		
		private function resetTween(target:Image, isInBackground:Boolean = false, tween:Tween = null):void
		{
			_removeChild(target);
			
			if (isInBackground)
			{
				_refBack.push(target);
				_backHousesTweens.push(tween)
			}
			else
			{
				_refFront.push(target);
				_frontHousesTweens.push(tween)
			}
			
			_juggler.remove(tween)
			
		}
		
		private function removeTween(target:Tween):void
		{
			_juggler.remove(target)
		}
		
		public function set referenceFront(val:Image):void
		{
			if (!_refFront)
			{
				_refFront = new Vector.<Image>
			}
			
			_refFront.push(val);
			_refFront[_refFront.length - 1].touchable = false;
			_refFront[_refFront.length - 1].blendMode = BlendMode.NORMAL;
			
			_frontHousesTweens.push(new Tween(val, 2))
		}
		
		public function set referenceBack(val:Image):void
		{
			if (!_refBack)
			{
				_refBack = new Vector.<Image>
			}
			
			_refBack.push(val);
			_refBack[_refBack.length - 1].touchable = false;
			_refBack[_refBack.length - 1].blendMode = BlendMode.NORMAL;
		
			_backHousesTweens.push(new Tween(val, 2))
		}
		
		public function set referenceTarget(val:Image):void
		{
			if (!_refTargets)
			{
				_refTargets = new Vector.<Image>
			}
			
			_refTargets.push(val);
			_refTargets[_refTargets.length - 1].touchable = false;
			_refTargets[_refTargets.length - 1].blendMode = BlendMode.NORMAL;
			_targetsTweens.push(new Tween(val, 2))
		}
		
		public function set checkPoint(val:Image):void
		{
			_refCheckPoint = val;
		}
		
		public function set addChild(func:Function):void
		{
			_addChild = func;
		}
		
		public function set swapChildren(func:Function):void
		{
			_swapChildren = func;
		}
		
		public function set removeChild(func:Function):void
		{
			_removeChild = func;
		}
		
		public function get referenceFrontHomes():Image
		{
			return _refFront.shift();
		}
		
		public function get referenceBackHomes():Image
		{
			return _refBack.shift();
		}
		
		public function get referenceTargets():Image
		{
			return _refTargets.shift();
		}
		
		public function get checkPoint():Image
		{
			return _refCheckPoint;
		}
		
		public function getOnScreenTargets():Vector.<Image>
		{
			return _onScreenTargets;
		}
		
		public function removeFromCollision(img:Image):void
		{
			
		}
		
		public function set juggler(val:Juggler):void
		{
			_juggler = val;
		}
		
	}

}