package com.assets 
{
	import com.gfx.SpritePool;
	import flash.net.URLLoader;
	import flash.system.System;
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	/**
	 * ...
	 * @author Alex Popescu
	 */
	 
	public class AssetsManager 
	{
		
		/**
		 * AssetsManager is singleton. Only one instance per game.
		 */
		private static var _instance:AssetsManager = new AssetsManager();
		private var _atlasXML:XML;
		private var _texture:Texture;
		private var _atlas:TextureAtlas;
	
		/**
		 * 
		 */
		public function AssetsManager() 
		{
			if (_instance != null)
			{
				throw new Error("AssetsManager is singleton !");
			}
		}
		
		/**
		 * Return an instance of the AssetsManager class
		 */
		public static function get instance():AssetsManager
		{
			return _instance;
		}
		
		/**
		 * 
		 */
		public function get assets():Class
		{
			return AssetsVO.santaAssets;
		}
		
		/**
		 * 
		 */
		public function get assetsXML():XML
		{
			return _atlasXML;
		}
		
		/**
		 * 
		 */
		public function parseAtlasXML():void
		{
			_atlasXML = new XML (new AssetsVO.santaAssetsXML)
		}
		
		public function get atlas():TextureAtlas
		{
			return _atlas;
		}
		
		/**
		 * 
		 */
		public function createSprites():void
		{
			
			parseAtlasXML();
			_texture = Texture.fromBitmap(new assets(), true, true);
			_atlas = new TextureAtlas(_texture, _atlasXML);
			
			/**
			 * @Init build an image buffer
			 */
			var imageBuffer:Image = new Image(_atlas.getTexture("Player/Bazooka"));
			
			/**
			 * @Init Add simple Sprites
			 */
			SpritePool.addImage(new Image(_atlas.getTexture("Background/Background")), BlendMode.NONE);
			SpritePool.addImage(new Image(_atlas.getTexture("Player/Bazooka")));
			/**
			 * @Init Build a 3 projectile pool
			 */
			SpritePool.addImage(new Image(_atlas.getTexture("Player/Gift")));
			SpritePool.addImage(new Image(_atlas.getTexture("Player/Gift-2")));
			SpritePool.addImage(new Image(_atlas.getTexture("Player/Gift-3")));

			/**
			 * @Init Build a 12 poofs pool
			 */
			SpritePool.addImage(new Image(_atlas.getTexture("Player/Poof")));
			SpritePool.addImage(new Image(_atlas.getTexture("Player/Poof")));
			SpritePool.addImage(new Image(_atlas.getTexture("Player/Poof")));
			SpritePool.addImage(new Image(_atlas.getTexture("Player/Poof")));
			SpritePool.addImage(new Image(_atlas.getTexture("Player/Poof")));
			SpritePool.addImage(new Image(_atlas.getTexture("Player/Poof")));
			SpritePool.addImage(new Image(_atlas.getTexture("Player/Poof")));
			SpritePool.addImage(new Image(_atlas.getTexture("Player/Poof")));
			SpritePool.addImage(new Image(_atlas.getTexture("Player/Poof")));
			SpritePool.addImage(new Image(_atlas.getTexture("Player/Poof")));
			SpritePool.addImage(new Image(_atlas.getTexture("Player/Poof")));
			SpritePool.addImage(new Image(_atlas.getTexture("Player/Poof")));
			/**
			 * @Init Build buildings
			 */
			//back
			SpritePool.addImage(new Image(_atlas.getTexture("Back/Back-House-1")));
			SpritePool.addImage(new Image(_atlas.getTexture("Back/Back-House-2")));
			SpritePool.addImage(new Image(_atlas.getTexture("Back/Back-Church")));
			//front
			SpritePool.addImage(new Image(_atlas.getTexture("Front/Igloo")));
			SpritePool.addImage(new Image(_atlas.getTexture("Front/House-4")));
			SpritePool.addImage(new Image(_atlas.getTexture("Front/House-2")));
			SpritePool.addImage(new Image(_atlas.getTexture("Front/House-3")));
			SpritePool.addImage(new Image(_atlas.getTexture("Front/House-1")));
			/**
			 * @Init Targets
			 */
			SpritePool.addImage(new Image(_atlas.getTexture("UI/Target")), BlendMode.NORMAL, true);
			SpritePool.addImage(new Image(_atlas.getTexture("UI/Target-Bad")), BlendMode.NORMAL, false);
			SpritePool.addImage(new Image(_atlas.getTexture("UI/Target-2")), BlendMode.NORMAL, true);
			SpritePool.addImage(new Image(_atlas.getTexture("UI/Target-Bad-2")), BlendMode.NORMAL, false);
			SpritePool.addImage(new Image(_atlas.getTexture("UI/Target")), BlendMode.NORMAL, true);
			SpritePool.addImage(new Image(_atlas.getTexture("UI/Target")), BlendMode.NORMAL, true);
			SpritePool.addImage(new Image(_atlas.getTexture("UI/Target-2")), BlendMode.NORMAL, true);
			SpritePool.addImage(new Image(_atlas.getTexture("UI/Target-Bad-2")), BlendMode.NORMAL, false);

			/**
			 * @Init CheckPoint
			 */
			SpritePool.addImage(new Image(_atlas.getTexture("Front/Check-Point")), BlendMode.NORMAL, true);
			/**
			 * Add MovieClips
			 */
			SpritePool.addMovieClip(new starling.display.MovieClip(_atlas.getTextures("Player/santa")));
			SpritePool.addMovieClip(new starling.display.MovieClip(_atlas.getTextures("Ground/Ground")));
			
			//_texture.dispose();
			//_atlas.dispose();
			
			System.gc();
			
		}
		
	}

}