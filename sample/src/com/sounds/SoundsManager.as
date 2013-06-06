package com.sounds 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;
	import flash.media.SoundMixer;
	import flash.media.AudioPlaybackMode;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class SoundsManager
	{
		[Embed(source = "/sounds/menuLoop.mp3")]
		private var MenuSound : Class; 
		
		[Embed(source = "/sounds/gameLoop.mp3")]
		private var GameSound : Class; 
		
		[Embed(source = "/sounds/turbine_fire.mp3")]
		private var Turbine : Class; 
		
		[Embed(source = "/sounds/shoot.mp3")]
		private var Shoot : Class; 
		
		[Embed(source = "/sounds/hit_target1.mp3")]
		private var Hit0 : Class; 
		
		[Embed(source = "/sounds/hit_target2.mp3")]
		private var Hit1 : Class; 
		
		[Embed(source = "/sounds/hit_target3.mp3")]
		private var Hit2 : Class; 
		
		[Embed(source = "/sounds/hit_target4.mp3")]
		private var Hit3 : Class; 
		
		[Embed(source = "/sounds/hit_target5.mp3")]
		private var Hit4 : Class; 
		
		[Embed(source = "/sounds/hit_other_houses.mp3")]
		private var Miss : Class; 
		
		[Embed(source = "/sounds/hit_big_house.mp3")]
		private var Miss2 : Class; 
		
		[Embed(source = "/sounds/bad_target.mp3")]
		private var BadHouse : Class; 
		
		[Embed(source = "/sounds/end_game.mp3")]
		private var EndGame : Class; 
		
		[Embed(source = "/sounds/yupi.mp3")]
		private var Yupi : Class; 
		
		[Embed(source = "/sounds/timer.mp3")]
		private var TicToc : Class; 
		
		[Embed(source = "/sounds/5_in_a_row.mp3")]
		private var InRow : Class; 
		
		[Embed(source = "/sounds/Button_Press.mp3")]
		private var ButtonSound : Class; 
		
		[Embed(source = "/sounds/ho_ho_ho.mp3")]
		private var BigWinSound : Class; 
		
		//[Embed(source = "/sounds/shoot.wav")]
		//private var Shoot : Class; 
		
		private var toggle:Boolean = false;
		
		private var mSound:Sound;
		private var gSound:Sound;
		private var shoot:Sound;
		private var hit0:Sound;
		private var hit1:Sound;
		private var hit2:Sound;
		private var hit3:Sound;
		private var hit4:Sound;
		private var miss:Sound;
		private var miss2:Sound;
		private var ticToc:Sound;
		private var badHouse:Sound;
		private var endGame:Sound;
		private var yupi:Sound;
		private var inRow:Sound;
		private var btnSound:Sound;
		private var bigWinSnd:Sound;
		private var hitSoundIndex:uint = 0;
		private var hitSounds:Vector.<Sound> = new Vector.<Sound>
		private var turbine:Sound;
		
		private var channel:SoundChannel = new SoundChannel();
		private var shootChannel :SoundChannel = new SoundChannel();
		private var effectsChannel :SoundChannel = new SoundChannel();
		
		private var state:Boolean = true; // is in menu
		private var muted:Boolean = false;
		
		public function SoundsManager() 
		{
			
			/**
			 * Only for iOS
			 */
			SoundMixer.audioPlaybackMode = AudioPlaybackMode.AMBIENT;
			
			mSound = new MenuSound() as Sound;
			gSound = new GameSound() as Sound;
			shoot = new Shoot() as Sound;
			hit0 = new Hit0() as Sound;
			hitSounds.push(hit0);
			hit1 = new Hit1() as Sound;
			hitSounds.push(hit1);
			hit2 = new Hit2() as Sound;
			hitSounds.push(hit2);
			hit3 = new Hit3() as Sound;
			hitSounds.push(hit3);
			hit4 = new Hit4() as Sound;
			hitSounds.push(hit4);
			miss = new Miss() as Sound;
			miss2 = new Miss2() as Sound;
			turbine = new Turbine() as Sound;
			badHouse = new BadHouse() as Sound;
			endGame = new EndGame() as Sound;
			yupi = new Yupi() as Sound;
			ticToc = new TicToc() as Sound;
			inRow = new InRow() as Sound;
			btnSound = new ButtonSound() as Sound;
			bigWinSnd = new BigWinSound() as Sound;
		}
		
		public function playMenuSound():void
		{
			state = true;
			if (!muted)
			{
				channel = mSound.play(0, 9999999);
			}
		}
		
		public function pauseMenuSound():void
		{
			state = false;
			channel.stop();
			playGameSound();
		}
		
		public function playGameSound():void
		{
			state = false;
			if (!muted)
			{
				channel = gSound.play(0, 9999999);
				effectsChannel = turbine.play(0, 9999999);
			}
		}
		
		public function pauseGameSound():void
		{
			state = true;
			channel.stop();
			if(!muted)
			playMenuSound();
		}
		
		public function pauseAllSound():void
		{
			channel.stop();
		}
		
		public function mute():void
		{
			channel.stop();
		}
		
		public function playShootSound(): void
		{
			if(!muted)
			shootChannel = shoot.play(0);
		}
		
		public function playhitSound(): void
		{
			shootChannel.stop();
			
			if (!muted)
			{
				shootChannel = hitSounds[hitSoundIndex].play(0);
			}
			
			hitSoundIndex++;
			
			if (hitSoundIndex == 5)
			{
				hitSoundIndex = 0;
			}
		}
		
		public function playMissSound(): void
		{
			hitSoundIndex = 0;
			
			if (toggle)
			{
				if(!muted)
				shootChannel = miss.play(0);
			}
			else
			{
				if(!muted)
				shootChannel = miss2.play(0);
			}
			
			toggle = !toggle;
		}
		
		public function playBadSound():void
		{
			hitSoundIndex = 0;
			if(!muted)
			badHouse.play();
		}
		
		public function playEndGame():void
		{
			if(!muted)
			endGame.play();
		}
		
		public function playYupi():void
		{
			if(!muted)
			yupi.play();
		}
		
		public function muteAll():void
		{
			muted = true;
			effectsChannel.stop();
			channel.stop();
		}
		
		public function unMuteAll():void
		{
			if (state)
			{
				channel  = mSound.play(0, 9999999);
			}
			else
			{
				channel = gSound.play(0, 9999999)
			}
			
			effectsChannel = turbine.play(0, 99999)
			muted = false;
		}
		
		public var playingTic:Boolean = false;
		
		public function playTicToc():void
		{
			if (!playingTic && !muted)
			{
				ticToc.play();
				playingTic = true;
			}
		}
		
		public function playBigWin():void
		{
			if (!muted)
			{
				inRow.play();
			}
		}
		
		public function playButtonSound():void
		{
			if (!muted)
			{
				btnSound.play();
			}
		}
		
		public function bigWinSound():void
		{
			if (!muted)
			{
				bigWinSnd.play();
			}
		}
		
	}

}