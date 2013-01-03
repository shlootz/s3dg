package com 
{
	import com.actors.Buildings;
	import com.actors.CanonVO;
	import com.actors.CharacterLogic;
	import com.actors.ProjectileVO;
	import com.actors.SantaVO;
	import com.assets.AssetsManager;
	import com.fonts.FontsManager;
	import com.gfx.SpritePool;
	import com.graphics.BackgroundAnimatedVO;
	import com.graphics.BackgroundVO;
	import com.preloader.ui.PreloaderUI;
	import com.save.Save;
	import com.settings.Settings;
	import com.sounds.SoundsManager;
	import com.ui.UserInterface;
	import com.utils.Camera;
	import com.utils.Collisions;
	import com.utils.Scores;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.system.System;
	import starling.animation.Juggler;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Santa extends Game implements iGame
	{
		/**
		 * Game specific logic
		 */
		private static const PRELOAD_DELAY:uint = 3;
		 
		private var _collisions:Collisions;
		 
		private var _background:BackgroundVO;
		private var _backgroundAnimated:BackgroundAnimatedVO;
		private var _santaVO:SantaVO;
		private var _santaLogic:CharacterLogic;
		private var _canonVO:CanonVO;
		private var _projectileVO:ProjectileVO;
		private var _buildings:Buildings;
		private var _canvas:Sprite
		private var _camera:Camera;
		private var _ui:UserInterface;
		private var _scores:Scores;
		private var _sounds:SoundsManager;
		private var preloadImage:Image;
		private var _touchPoint:Point = new Point(0, 0);
		private var _saveManager:Save;
		private var timeStamp:Number = 0;
		private var _stage:Stage;
		 
		public function Santa() 
		{
			super();
			
		}
		
		/**
		 * Init all the variables / pools / graphics
		 */
		
		 
		override protected function init():void
		{
			//addChild(new TextField(500, 50, "--------------- Starling OK -> Hello Cou1sin!", "Verdana", 20, 0xffffff));
			//addChild(new Quad(100, 100, 0xff0000) );
			_stage = stage;
			
			_stage.addEventListener(Event.RESIZE, handleResize);
			 //call handleResize to initialize the first time
			
			
			_saveManager = new Save();
			 //Game Canvas
			_canvas = new Sprite();
			
			_ui = new UserInterface();
			_canvas.touchable = false;
			_canvas.blendMode = BlendMode.NORMAL;
			
			addChild(_canvas);
			_canvas.scaleX = _canvas.scaleY = Settings.DEFAULT_ZOOM;
			
			_canvas.scaleX = _canvas.scaleY = Settings.DEFAULT_ZOOM;
			_ui.scaleX = _ui.scaleY = Settings.DEFAULT_ZOOM;
			
			_collisions = new Collisions();
			_camera = new Camera(_canvas, stage);
			_background = new BackgroundVO();
			_backgroundAnimated = new BackgroundAnimatedVO();
			_santaVO = new SantaVO();
			_santaLogic = new CharacterLogic();
			_canonVO = new CanonVO();
			_projectileVO = new ProjectileVO();
			_buildings = new Buildings();
			_scores = new Scores();
			_sounds = new SoundsManager();
			
			_camera.juggler = _juggler;
			_canonVO.juggler = _juggler;
			_scores.juggler = _juggler;
			_scores._showCheckPoint = _buildings.startCheckPoint;
			_scores._showLoseScreen = _ui.showLoseScreen;
			_scores.soundsManager = _sounds;
			_santaLogic.juggler = _juggler;
			_projectileVO.juggler = _juggler;
			_projectileVO.soundManager = _sounds;
			_buildings.juggler = _juggler;
			_scores._save = _saveManager;
			_backgroundAnimated._addChild = addChild;
			_ui._saveManager = _saveManager;
			_ui._scoreManager = _scores;
			
			_canvas.visible = false;
			_ui.visible = false;
			_scores.visible = false;
			
			_scores.scaleX = Settings.DEFAULT_ZOOM;
			_scores.scaleY = Settings.DEFAULT_ZOOM_Y;
			
			super.init();
			
			preload();
			
			if (Settings.DEFAULT_DEVICE_EXPORT == Settings.ANDROID)
			{
				Starling.current.nativeStage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, keyPressed);
			}
			
			handleResize();
		}
		
		private function handleResize(...ig) :void
		{
			//-----------------------------------------------------------------------------------------------
			
			/**
			 * MANUAL RESIZE
			 */
			_canvas.width = stage.stageWidth;
			_canvas.height = stage.stageHeight - stage.stageHeight * .2;
			_canvas.y = -100;
			
			_ui.width = stage.stageWidth - stage.stageWidth * .1;
			_ui.height = stage.stageHeight - stage.stageHeight * .2 ;
			_ui.y = -10;
			
			_scores.width = stage.stageWidth;
			_scores.height = stage.stageHeight / 8;
			
			//-----------------------------------------------------------------------------------------------
			
			/**
			 * AUTOMATIC RESIZE
			 */
			//var width:uint = Capabilities.screenResolutionX;
			//var height:uint = Capabilities.screenResolutionY;
			//
			//_canvas.width = width;
			//_canvas.height = height - height * .2;
			//
			//_ui.width = width - width * .1;
			//_ui.height = height - height * .2 ;
			//_ui.y = -10;
			//
			//_scores.width = width;
			//_scores.height = height / 8;
			
			//-----------------------------------------------------------------------------------------------
			
			//if (Settings.DEFAULT_DEVICE_EXPORT == Settings.IOS)
			//{
				_canvas.y = Settings.IOS_Y_OFFSET;
				_scores.x = Settings.IOS_SCORE_X_OFFSET_IPAD;
			//}
			
			if (Settings.DEFAULT_DEVICE_EXPORT == Settings.ANDROID)
			{
				_scores.x = Settings.ANDROID_SCORE_X_OFFSET;
				_canvas.y = Settings.ANDROID_Y_OFFSET;
			}
		} 
		
		private function keyPressed(e:flash.events.KeyboardEvent):void
		{
			e.preventDefault();
			_ui.physicalPause();
		}
		
		private function preload():void
		{
			//preloadImage = new Image(AssetsManager.instance.atlas.getTexture("UI/Loading-Message") );
			//preloadImage.scaleX = preloadImage.scaleY = .7;
			
			//preloadImage.x = stage.stageWidth / 2 - preloadImage.width / 2;
			//preloadImage.y = 250;
			
			//var _tween:Tween = new Tween(preloadImage, 1);
			
			//_tween.animate("alpha", 0);
			//_tween.delay = PRELOAD_DELAY;
			//_tween.onCompleteArgs = [_tween];
			//_tween.onComplete = cleanPreload;
			//addChild(preloadImage);
			//_juggler.add(_tween);
			
			//_juggler.remove(t);
			removeChild(preloadImage);
			preloadImage = null;
			
			_canvas.visible = true;
			_ui.visible = true;
			_scores.visible = false;
			
			addChild(_scores);
			
			/**
			 * Camera init position
			 */
			_camera.zoom(Camera.ACTION_ZOOM_IN);
			
		}
		
		private function cleanPreload(t:Tween):void
		{
			_juggler.remove(t);
			removeChild(preloadImage);
			preloadImage = null;
			
			_canvas.visible = true;
			_ui.visible = true;
			_scores.visible = false;
			
			addChild(_scores);
			
			/**
			 * Camera init position
			 */
			_camera.zoom(Camera.ACTION_ZOOM_IN);
		}
		
		/**
		 * Touch Handler
		 * @param	e
		 */
		 
		private function onTouch(e:TouchEvent):void
		{
			_touchPoint = e.touches[0].getLocation(_canvas);
				
			if (e.touches[0].phase == TouchPhase.BEGAN)
			{
				/**
				 * Fire up Missle
				 */
				if (_juggler.elapsedTime > timeStamp + .5 )
				{
					_sounds.playShootSound();
					timeStamp = _juggler.elapsedTime;
					CanonVO.rotate(_touchPoint);
					fire(_touchPoint);
				}
			}
		}
		
		private function fire(touchPoint:Point):void
		{
			_projectileVO.fire(touchPoint, null);
			_projectileVO.getTargets(_buildings.getOnScreenTargets());
		}
		
		private function addImageToStage(target:Image):void
		{
			_canvas.addChild(target);
		}
		
		private function removeImageFromStage(target:Image):void
		{
			_canvas.removeChild(target);
		}
		
		/**
		 * Add touch or tick event listeners
		 */
		override protected function initEventListeners():void
		{
			
		}
		
		private var temp:MovieClip;
		
		override protected function addInitAssetsOnStage():void
		{
			trace("smth");
			//add background
			_background.reference = SpritePool.getImage();
			//_background.reference.width = stage.stageWidth;
			//_background.reference.height = stage.stageHeight;
			_background.reference.width = stage.stageWidth;
			_background.reference.height = stage.stageHeight;
			addChild(_background.reference);
			
			swapChildren(_background.reference, _canvas);
			
			//add santa
			_santaVO.reference = SpritePool.getMovieClip();
			_canvas.addChild(_santaVO.reference);
			_juggler.add(_santaVO.reference);
			_santaLogic.startAnim(_santaVO.reference);
		
			//add rolling floor
			_backgroundAnimated.reference = SpritePool.getMovieClip();
			_backgroundAnimated.buildSprite();
			_canvas.addChild(_backgroundAnimated.backgroundHill);
			_canvas.addChild(_backgroundAnimated.reference);
			_juggler.add(_backgroundAnimated.reference);
			
			//add Cannon
			_canonVO.reference = SpritePool.getImage();
			_canvas.addChild(_canonVO.reference);
			
			//add Projectiles
			_projectileVO.removeChild = removeImageFromStage;
			_projectileVO.addChild = addImageToStage;
			_projectileVO.updateScores = _scores.updateScore;
			var i:uint = 0;
			for (i = 0; i < 3; i++ )
			{
				_projectileVO.reference = SpritePool.getImage();
			}
			
			//add poofs to Projectiles
			for (i = 0; i < 12; i++ )
			{
				_projectileVO.referencePoofs = SpritePool.getImage();
			}
			
			//add buildings & targets
			_buildings.removeChild = removeImageFromStage;
			_buildings.addChild = addImageToStage;
			_buildings.swapChildren = swapChildren;
			_canvas.addEventListener(EnterFrameEvent.ENTER_FRAME, _buildings.tick)
			_canvas.addEventListener(EnterFrameEvent.ENTER_FRAME, _scores.countDown);

			for (i = 0; i < 3; i++ )
			{
				_buildings.referenceBack = SpritePool.getImage();
				_buildings._refBack[_buildings._refBack.length -1].pivotY = Settings.PIVOTY + _buildings._refBack[_buildings._refBack.length -1].height;
				_buildings._refBack[_buildings._refBack.length -1].x = Settings.GEN_BUILDING_X;
				_buildings._refBack[_buildings._refBack.length -1].y = Settings.GEN_BUILDING_BACK_Y;
			}
			
			for (i = 0; i < 5; i++ )
			{
				_buildings.referenceFront = SpritePool.getImage();
				_buildings._refFront[_buildings._refFront.length -1].pivotY = Settings.PIVOTY + _buildings._refFront[_buildings._refFront.length -1].height;
				_buildings._refFront[_buildings._refFront.length -1].x = Settings.GEN_BUILDING_X;
				_buildings._refFront[_buildings._refFront.length -1].y = Settings.GEN_BUILDING_FRONT_Y;
			}
			
			for (i = 0; i < 8; i++ )
			{
				_buildings.referenceTarget = SpritePool.getImage();
				_buildings._refTargets[_buildings._refTargets.length -1].pivotY = Settings.PIVOTY + _buildings._refTargets[_buildings._refTargets.length -1].height;
				_buildings._refTargets[_buildings._refTargets.length -1].x = Settings["TARGET_"+i].x;
				_buildings._refTargets[_buildings._refTargets.length -1].y = Settings["TARGET_"+i].y;
			}
			
			_buildings.checkPoint = SpritePool.getImage();
			_buildings._refCheckPoint.pivotY = Settings.PIVOTY + _buildings._refCheckPoint.height;
			_buildings._refCheckPoint.x = Settings.GEN_BUILDING_X;
			_buildings._refCheckPoint.y = Settings.GEN_BUILDING_FRONT_Y;
		
			//link projectiles and targets to collision detector
			_projectileVO.display = stage;
			
			/**
			 * Arange Assets Layers
			 */
			_canvas.setChildIndex(_backgroundAnimated.reference, 90);
			
			/**
			 * SET START GAME UI
			 */
			setUI();
			setSounds();
			 
			System.gc();
		}
		
		private function setUI():void
		{
			addChild(_ui);
			_ui.juggler = _juggler;
			_ui.enableGameTouch = stageTouchEnable;
			_ui.disableGameTouch = stageTouchDisable;
			_ui.mainJuggler = Starling.juggler;
			_ui.startAction = _buildings.arrangeHouses;
			_ui.addButtons();
			_ui.soundsManager = _sounds;
		}
		
		private function setSounds():void
		{
			 _sounds.playMenuSound();
		}
		
		private var temporizer:uint = 0;
		
		private function updateActiveObjects():void
		{
			if (temporizer == 4)
			{
				_collisions.projectiles = _projectileVO.getOnScreenProjectiles();
				_collisions.targets = _buildings.getOnScreenTargets();
				
				temporizer = 0;
			}
			temporizer++
		}
		
		private function stageTouchEnable():void
		{
			if (_camera._state != "neutral")
			{
				_camera.zoom(Camera.ACTION_ZOOM_OUT);
			}
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function stageTouchDisable():void
		{
			stage.removeEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function inchesToPixels(inches:Number):uint
		{
		   return Math.round(Capabilities.screenDPI * inches);
		}
		
	}

}