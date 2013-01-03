package com.utils 
{
	
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class McFromSpriteSheet extends Sprite
	{
		private var _atlasXML:XML;
		private var _path:String;
		private var _spriteSheetClass:Class;
		private var _width:uint = 0;
		private var _height:uint = 0;
		private var _dim:Point = new Point(0, 0);
		private var _sheetX:uint = 0;
		private var _sheetY:uint = 0;
		private var _fps:uint = 30;
		private var _totalFrames:uint = 0;
		private var _movie:MovieClip;
		
		/**
		 * 
		 * @param	path
		 * @param	spriteSheet
		 * @param	spriteSheetDimensions
		 * @param	elementWidth
		 * @param	elementHeight
		 * @param	totalFrames
		 * @param	fps
		 */
		public function McFromSpriteSheet(path:String, spriteSheet:Class,spriteSheetDimensions:Point, elementWidth:uint, elementHeight:uint, totalFrames:uint, fps:uint = 30) 
		{
			_path = path;
			_spriteSheetClass = spriteSheet;
			_dim = spriteSheetDimensions;
			_width = elementWidth;
			_height = elementHeight;
			_fps = fps;
			_totalFrames = totalFrames;
			
			createXml();
		}
		
		/**
		 * 
		 */
		private function createXml():void
		{
			var xmlString:String = "";
			var current:uint = 0;
			var curr:String = "";
			var count:uint = 0;
			
			_atlasXML = <TextureAtlas imagePath="">
							
						</TextureAtlas>;
						
			_atlasXML.@imagePath = _path
			
			for (var i:uint = 0; i < _dim.x; i++ )
			{
				for (var j:uint = 0; j < _dim.y; j++ )
				{
					if (current < 10)
					{
						curr = "0" + String(current);
					}
					else
					{
						curr = String(current);
					}
					if (current < _totalFrames)
					{
						xmlString = '<SubTexture name="' + "frame_" + curr + '" x="' + int(j * _width) + '" y="' + int(i * _height) + '" width="' + _width + '" height="' + _height + '"/>'
						_atlasXML.appendChild(XML(xmlString)); 
					}
					current++;
				}
			}
			createMc();
		}
		/**
		 * 
		 */
		private function createMc(): void
		{
			// create atlas
			var texture:Texture = Texture.fromBitmap(new _spriteSheetClass());
			var xml:XML = _atlasXML;
			var atlas:TextureAtlas = new TextureAtlas(texture, xml);
			 
			// create movie clip
			var movie:MovieClip = new MovieClip(atlas.getTextures("frame_"), _fps);
			movie.loop = true; // default: true
			addChild(movie);
			// control playback
			movie.play();
			
			_movie = movie;
			 
			// important: add movie to juggler
			Starling.juggler.add(movie);
		}
		
		/**
		 * 
		 */
		public function get mc():MovieClip
		{
			return _movie;
		}
		
	}

}