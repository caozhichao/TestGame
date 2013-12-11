package test.starlingtest
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	import test.starlingtest.gem.GemAssets;
	import test.starlingtest.gem.GemItem;
	
	import world.items.items.Gem1_1;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-11-28 下午1:38:14
	 * 
	 */
	public class StarlingGame2 extends Sprite
	{
		[Embed(source="../../assets/3.png")]
		private var Person:Class;
		private var texture:Texture;
		private var _stepCount:int;
		private var _stepX:Number;
		private var _stepY:Number;
		private var _speed:Number = 5;
		private var image:Image;
		
		private static const ROWS:int = 10;
		private static const COLS:int = 8;
		
		private var assets:AssetManager;
		
		public function StarlingGame2()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,onStage);
		}
		
		
		private function createGemList():void
		{
			var item:GemItem;
			for (var i:int = 0; i < ROWS; i++) 
			{
				for (var j:int = 0; j < COLS; j++) 
				{
					texture = assets.getTexture(["Gem1","Gem2","Gem3","Gem4","Gem5","Gem6"][int(Math.random() * 6)]);
					item = new GemItem(texture);
					item.x = j * 42;
					item.y = i * 42;
					addChild(item);
				}
			}
		}
		
		private function test2():void
		{
			function onTouch(evt:TouchEvent):void
			{
				var touch:Touch = evt.getTouch(stage);
				if(touch)
				{
					var pos:Point = touch.getLocation(stage);
					trace(pos,touch.phase);
				}
			}
			stage.addEventListener(TouchEvent.TOUCH,onTouch);
		}
		
		private function onStage(evt:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onStage);
//			test2();
//			return;
			assets = new AssetManager();
			assets.verbose = Capabilities.isDebugger;
//			assets.enqueue(EmbeddedAssets);
			assets.enqueue(GemAssets);
			function progress(value:Number):void
			{
				trace(value);
				if(value == 1)
				{
//					test();
					createGemList();
				}
			}
			assets.loadQueue(progress);
			
			function test():void
			{
				texture = assets.getTexture("Gem1");
//				image = new Image(texture);
//				addChild(image);
				var item:GemItem = new GemItem(texture);
				addChild(item);
				/*
				texture = assets.getTexture("res_2_mc0000");
				image = new Image(texture);
//				addChild(image);
				var frames:Vector.<Texture> = assets.getTextures("res_2");
				var mMovie:MovieClip = new MovieClip(frames, 30);
				addChild(mMovie);
				Starling.juggler.add(mMovie);
				*/
			}
			/*
			var texture:Texture = Texture.fromEmbeddedAsset(Person);
			var image:Image = new Image(texture);
			addChild(image);
			function onFrame(evt:Event):void
			{
				if(_stepCount > 0)
				{
					image.x += _stepX;
					image.y += _stepY;
					_stepCount--;
				}
			}
			addEventListener(Event.ENTER_FRAME,onFrame);
			function onTriggered(evt:TouchEvent):void
			{
				var touch:Touch = evt.getTouch(stage);
				if(touch)
				{
					if(!evt.interactsWith(stage))
					{
						trace(touch.globalX,touch.globalY);
						var mouseX:int = touch.globalX;
						var mouseY:int = touch.globalY;
						var currX:int = image.x;
						var currY:int = image.y;
						var angle : Number = Math.atan2(mouseY - currY, mouseX - currX);
						var ds : Number = Point.distance(new Point(mouseX,mouseY), new Point(currX,currY));
						_stepCount = ds / _speed;
						_stepX = _speed * Math.cos(angle);
						_stepY = _speed * Math.sin(angle);
					}
				}
			}
			stage.addEventListener(TouchEvent.TOUCH ,onTriggered);
			*/
			/*
			var bmd:BitmapData = new BitmapData(50,20,true,0xffff0000);
			texture = Texture.fromBitmapData(bmd);
			var button:Button = new Button(texture,"按钮测试");
			button.fontColor = 0x00ff00;
//			button.fontBold = true;
//			button.enabled = false;
			button.fontSize = 14;
//			button.rotation = 50;
			button.x = 100;
			button.y = 100;
			addChild(button);
			button.addEventListener(Event.TRIGGERED,onClick);
			function onClick(evt:Event):void
			{
				trace("点击:",button.fontSize);
			}
			*/
		}
	}
}