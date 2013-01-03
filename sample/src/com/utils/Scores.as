package com.utils 
{
	import com.fonts.FontsManager;
	import com.save.Save;
	import com.settings.Settings;
	import com.sounds.SoundsManager;
	import starling.animation.Juggler;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Scores extends Sprite
	{
		
		private var instantScoreTextField: TextField;
		private var _staticScore:TextField;
		private var scoresVec:Vector.<TextField>;
		private var tweensVec:Vector.<Tween>;
		private var _tween:Tween;
		private var _score:int = 0;
		private var _increment:int = 0;
		private var _instantScore:String;
		private var _juggler:Juggler;
		public var _save:Save;
		private var _currentHighScore:uint;
		//public var _camera:Camera;
		private var _checkPointIncrement:uint = Settings.CHECK_POINT_INCREMENT;
		private var _checkPointTarget:uint = 200;
		private var _goalTextField:TextField;
		private var _timer:TextField;
		private var _time:uint = 60;
		private var _count:Boolean = false;
		private var _incrementTimer:uint = 0;
		public var _showCheckPoint:Function;
		public var _showLoseScreen:Function;
		private var _startCountDown:Boolean = false;
		private var _soundsManager:SoundsManager;
		
		public function Scores() 
		{
			TextField.registerBitmapFont(new BitmapFont(FontsManager.getFontTexture(), FontsManager.getFontXML()));
			scoresVec = new Vector.<TextField>;
			tweensVec = new Vector.<Tween>;
		
			_staticScore = new TextField(200, 50, "0"+"/"+_checkPointTarget, "AdLib BT", 40, 0xffffff);
			_staticScore.hAlign = HAlign.RIGHT;
			_staticScore.x = 250;
			_staticScore.y = 10;
			_staticScore.touchable = false;
			
			addChild(_staticScore);
			
			//_goalTextField = newText(50, 0, "Goal " + String(200));
			//addChild(_goalTextField);
			
			showTimer();
		}
		
		public function newInstantScore(posX:uint = 0, posY:uint = 0, content:String = "" ):TextField
		{
			instantScoreTextField = new TextField(200, 50, content, "AdLib BT", 30, 0xffffff);
			instantScoreTextField.touchable = false;
			instantScoreTextField.x = posX;
			instantScoreTextField.y = posY;
			return instantScoreTextField;
		}
		
		public function updateScore(posX:int = 0, posY:int = 0, missed:Boolean = false, good:String = "1"):void
		{
			var color:uint = 0xffffff;
			if (missed)
			{
				_instantScore = "- miss"
				_increment = 0;
			}
			else
			{
				if (good == "1")
				{
					if (_increment == 50)
					{
						_increment = 0;
					}
					
					_increment += 10;
					_score += _increment;
					
					if (_increment == 50)
					{
						_soundsManager.bigWinSound();
					}
				}
				else
				{
					color = 0xff0000;
					_increment = -10;
					//_camera.zoom(Camera.ACTION_SHAKE);
					if (_score != 0)
					{
						_score += _increment;
					}
				}
		
				_instantScore = String(_increment);
			}

			if (scoresVec.length == 0)
			{
				scoresVec.push(new TextField(200, 50, "", "AdLib BT", 30, 0xffffff))
			}
			
			instantScoreTextField = scoresVec.shift();
			instantScoreTextField.color = color
			instantScoreTextField.text = _instantScore;
			addTween(instantScoreTextField, posX, posY);
			
			_staticScore.text = String(_score+"/"+_checkPointTarget);
			
			if (good == "0")
			{
				_soundsManager.playBadSound();
				_increment = 0;
			}
		}
		
		public function showNextGoal():void
		{
			_checkPointTarget += _checkPointIncrement;
			_checkPointTarget = _checkPointTarget + Math.floor(_checkPointTarget * .3);
			_staticScore.text = String(_score+"/"+_checkPointTarget);
		}
		
		public function showTimer():void
		{
			_timer = newText(210, 50, String(_time+" sec"));
			addChild(_timer);
		}
		
		private function newText(posX:int = 0, posY:int = 0, content:String = "" ):TextField
		{
			var instantScoreTextField:TextField;
			instantScoreTextField = new TextField(400, 50, content, "AdLib BT", 30, 0xffffff);
			instantScoreTextField.touchable = false;
			instantScoreTextField.x = posX;
			instantScoreTextField.y = posY;
			instantScoreTextField.hAlign = HAlign.CENTER;
			return instantScoreTextField;
		}
		
		public function updateScoreMiss():void
		{
			_increment = 0;
			updateScore(0, 450, true);
		}
		
		private function addTween(target:TextField, posX:int, posY:int):void
		{
			addChild(target);
			target.alpha = 1;
			
			target.x = posX + 30;
			target.y = posY - 80;
			
			if (tweensVec.length == 0)
			{
				_tween = new Tween(target, .5);
				tweensVec.push(_tween)
			}
			
			_tween = tweensVec.shift();
			_tween.reset(target, _tween.totalTime);
			
			_tween.animate("alpha", 0);
			_tween.animate("y", target.y - 50);
			_tween.onCompleteArgs = [target, _tween]
			_tween.onComplete = cleanInstantScore;
			
			_juggler.add(_tween); 
		}
		
		private function cleanInstantScore(target:TextField, tween:Tween):void
		{
			scoresVec.push(target);
			removeChild(target);
			_juggler.remove(tween);
		}
		
		public function set juggler(val:Juggler):void
		{
			_juggler = val;
		}
		
		public function get elapsedTime():Number
		{
			return _juggler.elapsedTime;
		}
		
		public function get score():uint
		{
			return _score;
		}
		
		public function countDown():void
		{
			if (_count)
			{
				_incrementTimer++
				
				if (_time == 5)
				{
					_showCheckPoint();
					
				}
				if (_incrementTimer == Settings.CHECK_POINT_TIMER)
				{
					_time--
					
					if (_time == 0)
					{
						if (!lose())
						{
							_time = Settings.CHECK_POINT_TIMER;
							_soundsManager.playYupi();
							showNextGoal();
						}
						else
						{
							_soundsManager.playEndGame();
							showLoseScreen();
							_time = 60;
							_score = 0;
							_increment = 0;
							_staticScore.text = "0/200"
						}
						_soundsManager.playingTic = false;
						_timer.color = 0xffffff;
					}
					_incrementTimer = 0;
					
					if (_time < 10)
					{
						_soundsManager.playTicToc();
						_timer.color = 0xff0000;
					}
					
					_timer.text = String(_time + "sec");
				}
			}
		}
		
		private function showLoseScreen():void
		{
			_showLoseScreen();
		}
		
		public function lose():Boolean
		{
			if (_score < _checkPointTarget)
			{
				_checkPointTarget = 200;
				return true
			}
			else
			{
				return false;
			}
		}
		
		public function count():void
		{
			_count = true;
		}
		
		public function stopCount():void
		{
			_count = false;
		}
		
		public function startCountDown():void
		{
			_startCountDown = true;
		}
		
		public function set soundsManager(val:SoundsManager):void
		{
			_soundsManager = val;
		}
		
	}

}