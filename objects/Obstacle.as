﻿package objects
{	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.core.Starling;
	
	public class Obstacle extends Sprite
	{
		private var _type:int;
		private var _speed:int;
		private var _distance:int;
		private var _watchOut:Boolean;
		private var _alreadyHit:Boolean;
		private var _position:String;
		private var obstacleImage:Image;
		private var obstacleCrashImage:Image;
		private var obstacleAnimation:MovieClip;
		private var watchOutAnimation:MovieClip;

		public function Obstacle(_type:int, _distance:int, _watchOut:Boolean = true, _speed:int = 0)
		{
			super();
			
			this._type = _type;
			this._distance = _distance;
			this._watchOut = _watchOut;
			this._speed = _speed;
			
			_alreadyHit = false;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createObstacleArt();
			createObstacleCrashArt();
			createWatchOutAnimation();
		}
		
		private function createObstacleArt():void
		{
			//type 5 is the mine animation
			if(_type == 5)
			{
				obstacleAnimation = new MovieClip(Assets.getAtlas().getTextures("obstacle" + _type + "_0"), 10);
				Starling.juggler.add(obstacleAnimation);
				obstacleAnimation.x = 0;
				obstacleAnimation.y = 0;
			}
			//all other types are static images
			else
			{
				obstacleImage = new Image(Assets.getAtlas().getTexture("Obstacle0" + _type)); 
				obstacleImage.x = 0;
				obstacleImage.y = 0;
				this.addChild(obstacleImage);
			}

		}
		
		private function createObstacleCrashArt():void
		{
				//obstacleCrashImage = new Image(Assets.getAtlas().getTexture("obstacle" + _type + "_crash"));
			obstacleCrashImage = new Image(Assets.getAtlas().getTexture("Obstacle0" + 1 + "_crash"));
			obstacleCrashImage.visible = false;
			this.addChild(obstacleCrashImage);
		}
		
		private function createWatchOutAnimation():void
		{
			
			//only watch out for mines, which are type 4
			if(_type == 4)
			{
				watchOutAnimation = new MovieClip(Assets.getAtlas().getTextures("alert_mine_"), 7);
				Starling.juggler.add(watchOutAnimation);
				watchOutAnimation.x = -watchOutAnimation.texture.width;
				this.addChild(watchOutAnimation);
				//watchOutAnimation.y = obstacleAnimation.y + (obstacleAnimation.texture.height * 0.5) - (watchOutAnimation.texture.height * 0.5);
			}
			/*else
			{
				watchOutAnimation.x = -watchOutAnimation.texture.width;
				watchOutAnimation.y = obstacleImage.y + (obstacleAnimation.texture.height * 0.5) - (watchOutAnimation.texture.height * 0.5);
			}*/
			
			
		}
		
		public function get watchOut():Boolean
		{
			return _watchOut;
		}
		
		public function set watchOut(value:Boolean):void
		{
			_watchOut = value;
			
			if(watchOutAnimation)
			{
				if(value) watchOutAnimation.visible = true;
				else watchOutAnimation.visible = false;
			}
		}
		
		public function get alreadyHit():Boolean
		{
			return _alreadyHit;
		}
		
		public function set alreadyHit(value:Boolean):void
		{
			_alreadyHit = value;
			
			if(value)
			{
				obstacleCrashImage.visible = true;
				if (_type == 4) obstacleAnimation.visible = false;
				else obstacleImage.visible = false;
			}
		}
		
		public function get speed():int
		{
			return _speed;
		}
		
		public function set speed(value:int):void
		{
			_speed = value;
		}
		
		public function get position():String
		{
			return _position;
		}
		
		public function set position(value:String):void
		{
			_position = value;
		}
		
		public function get distance():int
		{
			return _distance;
		}
		
		public function set distance(value:int):void
		{
			_distance = value;
		}

	}
	
}
