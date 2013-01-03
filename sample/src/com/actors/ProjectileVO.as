package com.actors 
{
	import com.gfx.iSpriteModel;
	import com.gfx.SpriteModel;
	import com.gfx.SpritePool;
	import com.sounds.SoundsManager;
	import flash.geom.Point;
	import starling.animation.Juggler;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import flash.display.BlendMode;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class ProjectileVO
	{
		
		public var _ref:Vector.<Image>;
		public var _refPoofs:Vector.<Image>;
		private var _onScreenProjectiles:Vector.<Image>
		private var _onScreenPoofs:Vector.<Image>;
		private var _projectileTweenVec:Vector.<Tween>;
		private var _poofTweenVec:Vector.<Tween>;
		private var _tween:Tween;
		private var _addChild:Function;
		private var _removeChild:Function;
		private var _updateScore:Function;
		private var _targets:Vector.<Image>;
		private var _targetSpace:DisplayObject;
		private var dx:Number;
		private var dy:Number;
		private var angleDeg:Number;
		private var destX:Number;
		private var destY:Number;
		private static const PITransformed:Number  = 565.4866776461627;
		private var _inc:uint = 0;
		private var poof:Image;
		private var cannon:Image;
		private var _temporizer:uint = 0;
		private var _juggler:Juggler;
		private var _soundManager:SoundsManager;
		
		public function ProjectileVO() 
		{
			_ref = new Vector.<Image>;
			_refPoofs = new Vector.<Image>;
			_onScreenProjectiles = new Vector.<Image>;
			_onScreenPoofs = new Vector.<Image>;
			_projectileTweenVec = new Vector.<Tween>;
			_poofTweenVec = new Vector.<Tween>;
			
			buildSprite();
		}
		
		private function buildSprite():void
		{
			// overriden in Santa Class
		}
		
		public function set addChild(func:Function):void
		{
			_addChild = func;
		}
		
		public function set removeChild(func:Function):void
		{
			_removeChild = func;
		}
		
		/**
		 * Destroy a sprite. It returns it and stores it on the pool
		 */
		private function destroySprite():void
		{
			
		}
		
		public function set reference(val:Image):void
		{
			_ref.push(val);
			_ref[_ref.length - 1].touchable = false;
			_ref[_ref.length - 1].blendMode = BlendMode.NORMAL;
		
			_ref[_ref.length - 1].y = CanonVO._ref.y;
			_ref[_ref.length - 1].x = CanonVO._ref.x;
			
			_projectileTweenVec.push(new Tween(val, .8))
		}
		
		public function set referencePoofs(val:Image):void
		{
			
			_refPoofs.push(val);
			_refPoofs[_refPoofs.length - 1].touchable = false;
			_refPoofs[_refPoofs.length - 1].blendMode = BlendMode.NORMAL;

			_refPoofs[_refPoofs.length - 1].y = CanonVO._ref.y;
			_refPoofs[_refPoofs.length - 1].x = CanonVO._ref.x;
			
			_poofTweenVec.push(new Tween(val, 1))
		}
		
		public  function fire(pt:Point, target:Image):void
		{
			if (cannon == null)
			{
				cannon = CanonVO._ref;
			}
			
			target = _ref.shift();
			target.pivotX = 22;
			target.pivotY = 28;
			_tween = _projectileTweenVec.shift();
			_tween.reset(_tween.target, _tween.totalTime);
			
			_onScreenProjectiles.push(target);  
			_addChild(target);
			
			target.x = cannon.x + 40 * Math.cos(cannon.rotation);
			target.y = cannon.y + 40 * Math.sin(cannon.rotation);
			
			dx = pt.x - target.x;
			dy = pt.y - target.y;
			angleDeg = Math.atan2(dy, dx) / PITransformed;

			destX = target.x + 400 * Math.cos(cannon.rotation);
			destY = target.y + 400 * Math.sin(cannon.rotation);
			
			_tween.animate("x", destX);
			_tween.animate("y", destY);
			
			_tween.onUpdateArgs = [target, _tween]
			_tween.onUpdate = updatedTween;
			
			_tween.onCompleteArgs = _tween.onUpdateArgs;
			_tween.onComplete = recycleProjectile;
			
			_juggler.add(_tween); 
			
			addTrail(target);
		}
		
		private function recycleProjectile(img:Image, tween:Tween, succesful:Boolean = false):void
		{
			var i:uint = _onScreenProjectiles.length - 1;
			
			_ref.push(img);
			
			targetLoop : while (i > 0)
			{
				if (_onScreenProjectiles[i] == img)
				{
					_onScreenProjectiles.splice(i, 1);
					break targetLoop;
				}
				
				i -- ;
			}
			
			_projectileTweenVec.push(tween);
			_juggler.remove(tween);
			
			_removeChild(img);
			
			if (!succesful)
			{
				_soundManager.playMissSound();
				_updateScore(img.x - 30, img.y, true)
			}
		}

		private function updatedTween(target:Image, tween:Tween):void
		{
			
			_temporizer ++
		
			if ( _targets.length > 0 && _temporizer > 5 && target.visible)
			{
				var i:uint =  _targets.length;
				
				addTrail(target, true);
				
				targetLoop : while (i > 0)
				{
					i--
					if (target.parent != null && _targets[i].parent != null)
					{
						if (_targets[i].visible)
						{
							if (target.getBounds(_targetSpace).intersects(_targets[i].getBounds(_targetSpace)))
							{
								/**
								 * Collision is true
								 */
								_soundManager.playhitSound();
								_updateScore(target.x - 100, target.y, false, _targets[i].name);
								recycleProjectile(target, tween, true);
								tween.onUpdate = null;
								tween.onComplete = null;
								_removeChild(_targets[i]);
								break targetLoop;
							}
						}
					}
				}
				_temporizer = 0;
			}
		}
		
		public function getTargets(val:Vector.<Image>):void
		{
			_targets = val;
		}

		private function recyclePoof(img:Image, tween:Tween):void
		{
			var i:uint = 0;
		
			_removeChild(img);
			_refPoofs.push(img);
			_poofTweenVec.push(tween);
			_juggler.remove(tween);
		}
		
		public function get reference():Image
		{
			var temp:Image = _ref.shift();
			_onScreenProjectiles.push(temp)
			return temp;
		}
		
		public function get referencePoof():Image
		{
			var temp:Image = _refPoofs.shift();
			return temp;
		}
		
		private function addTrail(target:Image, isSmall:Boolean = false):void
		{
			if (_refPoofs.length > 0)
			{
				poof = referencePoof;
				poof.alpha = 1;
				poof.x = target.x-35;
				poof.y = target.y - 35;
				
				if (isSmall)
				{
					poof.scaleX = poof.scaleY = .7;
				}
				else
				{
					poof.scaleX = poof.scaleY = 1;
				}
				
				_addChild(poof);
				
				_tween = _poofTweenVec.shift();
				_tween.reset(_tween.target, _tween.totalTime);
				_tween.animate("alpha", 0);
				_tween.onCompleteArgs = [poof, _tween]
				_tween.onComplete = recyclePoof;
				
				_juggler.add(_tween); 
				
			}
		}
		
		public function getOnScreenProjectiles():Vector.<Image>
		{
			return _onScreenProjectiles;
		}
		
		public function removeFromCollision(img:Image):void
		{
			
		}
		
		public function set display(val:DisplayObject):void
		{
			_targetSpace = val;
		}
		
		public function set updateScores(val:Function):void
		{
			_updateScore = val;
		}
		
		public function set juggler(val:Juggler):void
		{
			_juggler = val;
		}
		
		public function set soundManager(val:SoundsManager):void
		{
			_soundManager = val;
		}
		
	}

}