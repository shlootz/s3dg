package com.utils 
{
	import com.Game;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
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
	import starling.display.Stage;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;
	import flash.events.KeyboardEvent;
	/**
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class newSanta extends Game
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
		//private var _camera:Camera;
		private var _ui:UserInterface;
		private var _scores:Scores;
		private var _sounds:SoundsManager;
		private var preloadImage:Image;
		private var _touchPoint:Point = new Point(0, 0);
		private var _saveManager:Save;
		private var timeStamp:Number = 0;
		private var _stage:Stage;
		
		public function newSanta() 
		{
			super();
			
			addChild(new TextField(500, 50, "Assets loaded into GPU | Sprite Pool loaded | ", "Verdana", 20, 0xffffff));
			_stage = stage;

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
			//_camera = new Camera(_canvas, stage);
			_background = new BackgroundVO();
			_backgroundAnimated = new BackgroundAnimatedVO();
			_santaVO = new SantaVO();
			_santaLogic = new CharacterLogic();
			_canonVO = new CanonVO();
			_projectileVO = new ProjectileVO();
			_buildings = new Buildings();
			_scores = new Scores();
			_sounds = new SoundsManager();
			
			//_camera.juggler = _juggler;
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
			//_scores._camera = _camera;
			_backgroundAnimated._addChild = addChild;
			_ui._saveManager = _saveManager;
			_ui._scoreManager = _scores;
			//_ui._camera = _camera;
			
			_canvas.visible = false;
			_ui.visible = false;
			_scores.visible = false;
			
			_scores.scaleX = Settings.DEFAULT_ZOOM;
			_scores.scaleY = Settings.DEFAULT_ZOOM_Y;
			
			super.init();

		}
		
	}

}