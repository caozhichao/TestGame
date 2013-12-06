package test
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import czc.framework.manager.LoaderMaxManager;
	import czc.framework.manager.TimerManager;
	import czc.framework.utils.WindowScroll;
	import czc.framework.vo.LoadItemVo;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-6 下午4:44:04
	 * 
	 */
	public class WindowScrollTest extends Sprite
	{
		private var windowScroll:WindowScroll;
		private var map:Sprite;
		private var p:Sprite;
		private var _speed:Number = 7;
		private var _stepCount:int;
		private var _stepX:int;
		private var _stepY:int;
		private var _playerLayer:Sprite;
		//屏幕尺寸
		private var _screenW:int;
		private var _screenH:int;
		
		private var _mapBMD:BitmapData;
		private var _curMapBMD:BitmapData;
		private var _curMapBitmap:Bitmap;
		private var _curMapPoint:Point;
		
		
		public function WindowScrollTest()
		{
			super();
			
			var url:String = "assets/map8.jpg";
			LoaderMaxManager.instance.simpleLoader(url,success);
			function success(item:LoadItemVo):void
			{
				_mapBMD = (item.data as Bitmap).bitmapData;
				map.addChild(item.data);
//				map.addChild(p);
				onResieze(null);
			}
			windowScroll = new WindowScroll();
//			windowScroll.setWindowSize(800,600);
			setWindowSize();
			windowScroll.setScrollWindowSize(4000,3000);
			map = new Sprite();
			map.alpha = 0.5;
			this.addChild(map);
			p = new Sprite();
			p.graphics.beginFill(0xff0000);
			p.graphics.drawRect(0,0,10,10);
			p.graphics.endFill();
//			map.addChild(p);
			_curMapBitmap = new Bitmap();
//			_curMapBitmap.alpha = 0.5;
			this.addChild(_curMapBitmap);
			
			
			_playerLayer = new Sprite();
			_playerLayer.addChild(p);
			this.addChild(_playerLayer);
			
//			map.addEventListener(MouseEvent.CLICK,onClick);
			stage.addEventListener(MouseEvent.CLICK,onClick);
			
//			addEventListener(Event.ENTER_FRAME,onFrame);
			
			stage.addEventListener(Event.RESIZE,onResieze);
			
			TimerManager.instance.init(30);
			TimerManager.instance.setInterval(onFrame,33);
			
		}
		
		protected function onResieze(event:Event):void
		{
			_curMapPoint = null;
			setWindowSize();
			//窗口大小改变更新位置
			update();
		}
		
		private function setWindowSize():void
		{
			if(_screenW != stage.stageWidth || _screenH != stage.stageHeight)
			{
				_screenW = stage.stageWidth;
				_screenH = stage.stageHeight;
				windowScroll.setWindowSize(_screenW,_screenH);
				_curMapBMD = new BitmapData(_screenW,_screenH,false,0);
			}
			if(_curMapBitmap && _curMapBitmap.bitmapData != _curMapBMD)
			{
				_curMapBitmap.bitmapData = _curMapBMD;
			}
		}
		
		
		protected function onFrame(/*event:Event*/):void
		{
			if(_stepCount > 0)
			{
				p.x += _stepX;
				p.y += _stepY;
				_stepCount--;
				update();
			}
		}
		private function update():void
		{
			var mapPoint:Point = windowScroll.scroll(new Point(p.x,p.y));
//			trace(mapPoint);
//			map.x = mapPoint.x;
//			map.y = mapPoint.y;
			_playerLayer.x = mapPoint.x;
			_playerLayer.y = mapPoint.y;
			if(_curMapPoint == null)
			{
				_curMapPoint = new Point(mapPoint.x,mapPoint.y);
				drawMap(_curMapPoint);
			} else 
			{
				if(mapPoint.x != _curMapPoint.x || mapPoint.y != _curMapPoint.y)
				{
					_curMapPoint.x = mapPoint.x;
					_curMapPoint.y = mapPoint.y;
					drawMap(_curMapPoint);
				}
			}
		}
		
		/**
		 * 绘制屏幕地图
		 * 
		 */		
		private function drawMap(startPoint:Point):void
		{
			_curMapBMD.lock();
			_curMapBMD.copyPixels(_mapBMD,new Rectangle(Math.abs(startPoint.x),Math.abs(startPoint.y),_screenW,_screenH),new Point());
			_curMapBMD.unlock();
		}
		
		protected function onClick(event:MouseEvent):void
		{
//			var mouseX:int = map.mouseX;
//			var mouseY:int = map.mouseY;
			
			var mouseX:int = stage.mouseX;
			var mouseY:int = stage.mouseY;
			mouseX -= _curMapPoint.x;
			mouseY -= _curMapPoint.y;
			
			var angle : Number = Math.atan2(mouseY - p.y, mouseX - p.x);
			var ds : Number = Point.distance(new Point(mouseX,mouseY), new Point(p.x,p.y));
			_stepCount = ds / _speed;
			_stepX = _speed * Math.cos(angle);
			_stepY = _speed * Math.sin(angle);
		}
	}
}