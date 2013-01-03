package com.ui 
{
	import com.save.Save;
	import com.settings.Settings;
	import com.sounds.SoundsManager;
	import com.utils.Camera;
	import com.utils.Scores;
	import flash.desktop.NativeApplication;
	import flash.geom.Point;
	import flash.system.System;
	import starling.animation.DelayedCall;
	import starling.animation.Juggler;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import com.assets.AssetsManager;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.utils.HAlign;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class UserInterface extends Sprite
	{
		
		public var startAction:Function = new Function();
		public var enableGameTouch:Function;
		public var disableGameTouch:Function;
		private var _touchPoint:Point = new Point(0, 0);
		private var logo:Image;
		//private var facebook:Image;
		private var start:Image;
		private var pause:Image;
		private var resume:Image;
		private var restart:Image;
		private var endGameUI:Image;
		private var quit:Image;
		private var mute:Image;
		private var sound:Image;
		private var _soundsManager:SoundsManager;
		private var _isPaused:Boolean = false;
		private var _tween:Tween;
		private var _juggler:Juggler;
		private var _mainJuggler:Juggler;
		public var _saveManager:Save;
		public var _scoreManager:Scores;
		private var _bestScoreTextField:TextField;
		private var hints:Vector.<Image> = new Vector.<Image>;
		private var hintsUserd:Vector.<Image> = new Vector.<Image>;
		private var countDown:TextField;
		private var _hint:Image;
		private var delayedCall:DelayedCall;
		private var cDown:uint = 4;
		//public var _camera:Camera;
		private var _hintIndex:uint = 0;
		private var mutted:Boolean = false;
		private var _isPauseAvailable:Boolean = false;
		
		public function UserInterface() 
		{
		delayedCall = new DelayedCall(doCountDown, 1);
		delayedCall.repeatCount = int.MAX_VALUE;
		}
		
		private function doCountDown():void
		{

			if (cDown == 0)
			{
				Starling.juggler.remove(delayedCall);
				beginGame();
				cDown = 5;
			}
			
			countDown.text = String(cDown);
			
			cDown --
		}
		
		
		public function addButtons():void
		{
			logo = new Image(AssetsManager.instance.atlas.getTexture("UI/Logo") );
			//facebook = new Image(AssetsManager.instance.atlas.getTexture("UI/Facebook-Button") );
			start = new Image(AssetsManager.instance.atlas.getTexture("UI/Start-Button") );
			pause = new Image(AssetsManager.instance.atlas.getTexture("UI/Pause-Button") );
			resume = new Image(AssetsManager.instance.atlas.getTexture("UI/Resume") );
			restart = new Image(AssetsManager.instance.atlas.getTexture("UI/Restart-Button") );
			endGameUI =  new Image(AssetsManager.instance.atlas.getTexture("Lose/Lose-Screen") );
			quit = new Image(AssetsManager.instance.atlas.getTexture("UI/Quit-Button") );
			mute = new Image(AssetsManager.instance.atlas.getTexture("UI/Sound-Off") );
			sound = new Image(AssetsManager.instance.atlas.getTexture("UI/Sound-On") );
			
			hints.push( new Image(AssetsManager.instance.atlas.getTexture("Countdown/Hint-1") ));
			hints.push( new Image(AssetsManager.instance.atlas.getTexture("Countdown/Hint-2") ));
			hints.push( new Image(AssetsManager.instance.atlas.getTexture("Countdown/Hint-3") ));
			
			hints[0].touchable = hints[1].touchable = hints[2].touchable = false;
			
			logo.touchable = false;
			start.addEventListener(TouchEvent.TOUCH, onStartTouch);
			
			logo.x = 90;
			logo.y = 20;
			
			start.x = 130;
			start.y = 600;
			
			//facebook.x = 250;
			//facebook.y = 700;
			
			addChild(logo);
			//addChild(facebook);
			addChild(start);
			
			mute.addEventListener(TouchEvent.TOUCH, onMuteTouch)
			sound.addEventListener(TouchEvent.TOUCH, onSoundTouch)
			
			sound.x = 15;
			sound.y = 100;
			sound.scaleX = sound.scaleY = .7;
			addChild(sound);
			sound.visible = false;
			
			mute.y = 100;
			mute.x = 15;
			mute.scaleX = mute.scaleY = .7;
			
			addChild(mute);
			addChild(sound);
			
			//_bestScoreTextField = newText(120, 650, "Best Highscore : " + String(_saveManager.getCurrentHighScore()));
			
			//addChild(_bestScoreTextField);
		}
		
		private function onMuteTouch(e:TouchEvent):void
		{
			_touchPoint = e.touches[0].getLocation(this);
			
			if (e.touches[0].phase == TouchPhase.ENDED)
			{
				_soundsManager.playButtonSound();
				_soundsManager.muteAll();
				//removeChild(mute);
				mute.visible = false;
				sound.visible = true;
				addChild(sound);
				
			}
		}
		
		private function onSoundTouch(e:TouchEvent):void
		{
			_touchPoint = e.touches[0].getLocation(this);
			
			if (e.touches[0].phase == TouchPhase.ENDED)
			{
				_soundsManager.unMuteAll();
				_soundsManager.playButtonSound();
				//removeChild(sound);
				mute.visible = true;
				sound.visible = false;
				addChild(mute);
			}
		}
		
		
		private function onStartTouch(e:TouchEvent):void
		{
			_touchPoint = e.touches[0].getLocation(this);
			
			if (e.touches[0].phase == TouchPhase.ENDED)
			{
				e.currentTarget.removeEventListener(TouchEvent.TOUCH, onStartTouch);
				doStartAction();
				_soundsManager.playButtonSound();
			}
		}
		
		private function doStartAction():void
		{
			
				if ( hints.length == 0)
				{
					hints = hintsUserd;
					hintsUserd.splice(0, hintsUserd.length - 1);
				}
			
				_hintIndex = Math.floor(Math.random() * hints.length);
				_hint = hints[_hintIndex];
				
				hintsUserd.push(_hint);
				hints.splice(_hintIndex, 1);

				addChild(_hint);
				_hint.x = 95;
				_hint.y = 50;

				animateOut(logo);
				//animateOut(facebook);
				animateOut(start);
				addChild(pause);
				pause.x = 0;
				pause.y = 10;
				
				if (countDown == null)
				{
					countDown = newText(255, 500, "5");
					countDown.scaleX = countDown.scaleY = 1.5;
				}
				
				countDown.scaleX = countDown.scaleY = 1.5;
				_soundsManager.pauseMenuSound();
				addChild(countDown);
				countDown.touchable = false;
				startAction();
				Starling.juggler.add(delayedCall);
				
				System.gc();
		}
		
		private function beginGame():void
		{
			removeChild(_hint);
			removeChild(countDown);
			
			_scoreManager.visible = true;
			_scoreManager.count();
			//startAction();
			
			_isPauseAvailable = true;
			
			pause.addEventListener(TouchEvent.TOUCH, onPauseTouch);
			_isPaused = false;
				
			enableGameTouch();

			_scoreManager.visible = true;
		}
		
		public function physicalPause():void
		{
			if (_isPauseAvailable)
			{
				_isPaused = !_isPaused;
				
				if (!_isPaused)
				{
					_scoreManager.count();
					
					_soundsManager.pauseMenuSound();
					_mainJuggler.add(_juggler);
					enableGameTouch();
					_tween = new Tween(resume, .5);
					_tween.animate("alpha", 0);
					_tween.onCompleteArgs = [_tween, resume];
					_tween.onComplete = cleanTween;
					_juggler.add(_tween);
					
					if (Settings.DEFAULT_DEVICE_EXPORT == Settings.ANDROID)
					{
						removeChild(quit);
						quit.removeEventListener(TouchEvent.TOUCH, onQuitTouch)
					}
					//removeChild(_bestScoreTextField);
				}
				else
				{
					addChild(resume);
					resume.alpha = 1;
					resume.x = 100;
					resume.y = 400;
					
					_scoreManager.stopCount();
					
					if (Settings.DEFAULT_DEVICE_EXPORT == Settings.ANDROID)
					{
						addChild(quit);
						quit.x = 170;
						quit.y = 550;
						quit.addEventListener(TouchEvent.TOUCH, onQuitTouch)
					}
							
					resume.addEventListener(TouchEvent.TOUCH, onPauseTouch)
					//addChild(_bestScoreTextField);
					//_bestScoreTextField.y = 450;
					_soundsManager.pauseGameSound();
					_mainJuggler.remove(_juggler);
				}
				System.gc();
				
				//_saveManager.doSave(_scoreManager.score);
			}
			
			else
			
			{
				NativeApplication.nativeApplication.exit();
			}
		}
		
		private function animateOut(target:Image):void
		{
			_tween = new Tween(target, 1);
			_tween.animate("alpha", 0);
			_tween.onCompleteArgs = [_tween, target];
			_tween.onComplete = cleanTween;
			_juggler.add(_tween);
		}
		
		private function cleanTween(t:Tween, target:Image = null ):void
		{
			_juggler.remove(t);
			if (target != null)
			{
				removeChild(target);
			}
		}
		
		private function onPauseTouch(e:TouchEvent):void
		{
			_touchPoint = e.touches[0].getLocation(this);
			
			if (e.touches[0].phase == TouchPhase.BEGAN && _isPauseAvailable)
			{
				disableGameTouch();
				_soundsManager.playButtonSound();
			}
			if (e.touches[0].phase == TouchPhase.ENDED && _isPauseAvailable)
			{
				physicalPause();
			}
			
			
		}
		
		private function onRestartTouch(e:TouchEvent):void
		{
			_touchPoint = e.touches[0].getLocation(this);
			
			if (e.touches[0].phase == TouchPhase.ENDED)
			{
				removeChild(_bestScoreTextField);
				removeChild(restart);
				if (Settings.DEFAULT_DEVICE_EXPORT == Settings.ANDROID)
				{
					removeChild(quit);
				}
				removeChild(endGameUI);
				cDown = 4;
				doStartAction();
				_soundsManager.playButtonSound();
			}
		}
		
		private function onQuitTouch(e:TouchEvent):void
		{
			if (e.touches[0].phase == TouchPhase.ENDED)
			{
				_soundsManager.playButtonSound();
				NativeApplication.nativeApplication.exit();
			}
		}
		
		public function showLoseScreen():void
		{
			_isPauseAvailable = false;
			
			_soundsManager.playEndGame();
			
			disableGameTouch();
			_scoreManager.stopCount();
			//_camera.zoom(Camera.ACTION_ZOOM_IN);
			
			_soundsManager.pauseAllSound();
			_scoreManager.visible = false;
			
			addChild(endGameUI);
			endGameUI.x = 75;
			endGameUI.y = 50;
			if (Settings.DEFAULT_DEVICE_EXPORT == Settings.ANDROID)
			{
				addChild(quit);
				quit.x = 170;
				quit.y = 200;
				quit.addEventListener(TouchEvent.TOUCH, onQuitTouch)
			}
			addChild(restart);
			restart.x = 170;
			restart.y = 280;
			
			_bestScoreTextField = newText(80, 100, "Score : " + String(_scoreManager.score));
			_bestScoreTextField.hAlign = HAlign.CENTER;
			_bestScoreTextField.scaleX = _bestScoreTextField.scaleY = 1.7;
			addChild(_bestScoreTextField);
			
			restart.addEventListener(TouchEvent.TOUCH, onRestartTouch);
		}
		
		private function newText(posX:uint = 0, posY:uint = 0, content:String = "" ):TextField
		{
			var instantScoreTextField:TextField;
			instantScoreTextField = new TextField(200, 50, content, "AdLib BT", 30, 0xffffff);
			instantScoreTextField.touchable = false;
			instantScoreTextField.x = posX;
			instantScoreTextField.y = posY;
			instantScoreTextField.hAlign = HAlign.LEFT;
			return instantScoreTextField;
		}
		
		public function set soundsManager(val:SoundsManager):void
		{
			_soundsManager = val;
		}
		
		public function set juggler(val:Juggler):void
		{
			_juggler = val;
		}
		
		public function set mainJuggler(val:Juggler):void
		{
			_mainJuggler = val;
		}
	}

}