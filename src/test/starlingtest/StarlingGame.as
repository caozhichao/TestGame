package test.starlingtest
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import czc.framework.manager.TimerManager;
	import czc.framework.utils.WindowScroll;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-11-20 下午1:58:19
	 * 
	 */
	public class StarlingGame extends Sprite
	{
		[Embed(source="../../assets/map52.jpg")]
		public var cla:Class;
		
		private var _map:Sprite;
		private var _player:Image;
		private var windowScroll:WindowScroll;
		private var _stepCount:int;
		private var _stepX:Number;
		private var _stepY:Number;
		private var _speed:Number = 5;
		private var _curMapPoint:Point = new Point();
		
		public function StarlingGame()
		{
			super();
			//文本
			/*
			var textField:TextField = new TextField(400, 300, "Welcome to Starling!");
			addChild(textField);
			*/
			//图片
			
			_map = new Sprite();
			var bmp:Bitmap = new cla();
			var texture:Texture = Texture.fromBitmap(bmp);
			var image:Image = new Image(texture);
			_map.addChild(image);
			addChild(_map);
			var bmd:BitmapData = new BitmapData(10,10,false,0xff0000);
			_player = new Image(Texture.fromBitmapData(bmd));
			_map.addChild(_player);
			
			windowScroll = new WindowScroll();
			
			windowScroll.setWindowSize(800,600);
			windowScroll.setScrollWindowSize(2000,1000);
			
			TimerManager.instance.init(60);
			TimerManager.instance.setInterval(onFrame,20);
			
			_map.addEventListener(TouchEvent.TOUCH,onClick);
		}
		
		protected function onFrame(/*event:Event*/):void
		{
			if(_stepCount > 0)
			{
				_player.x += _stepX;
				_player.y += _stepY;
				_stepCount--;
				update();
			}
		}
		
		private function update():void
		{
			var mapPoint:Point = windowScroll.scroll(new Point(_player.x,_player.y));
			_map.x = mapPoint.x;
			_map.y = mapPoint.y;
		}
		
		protected function onClick(touchEvent:TouchEvent):void
		{
			var myTouch:Touch = touchEvent.getTouch(_map, TouchPhase.ENDED);
			if (myTouch) {
				var instance:DisplayObject = touchEvent.currentTarget as DisplayObject;
				var myPoint:Point = myTouch.getLocation(instance);
				var mouseX:int = myPoint.x;
				var mouseY:int = myPoint.y;
				trace(mouseX,mouseY);
				var angle : Number = Math.atan2(mouseY - _player.y, mouseX - _player.x);
				var ds : Number = Point.distance(new Point(mouseX,mouseY), new Point(_player.x,_player.y));
				_stepCount = ds / _speed;
				_stepX = _speed * Math.cos(angle);
				_stepY = _speed * Math.sin(angle);
			}
		}
	}
}