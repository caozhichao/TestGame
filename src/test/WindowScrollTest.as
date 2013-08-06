package test
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import czc.framework.manager.LoaderMaxManager;
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
		private var _speed:int = 5;
		private var _stepCount:int;
		private var _stepX:int;
		private var _stepY:int;
		private var _playerLayer:Sprite;
		
		public function WindowScrollTest()
		{
			super();
			
			var url:String = "assets/map8.jpg";
			LoaderMaxManager.instance.simpleLoader(url,success);
			function success(item:LoadItemVo):void
			{
				map.addChild(item.data);
//				map.addChild(p);
			}
			windowScroll = new WindowScroll();
			windowScroll.setWindowSize(400,300);
			windowScroll.setScrollWindowSize(4000,3000);
			map = new Sprite();
			this.addChild(map);
			p = new Sprite();
			p.graphics.beginFill(0xff0000);
			p.graphics.drawRect(0,0,10,10);
			p.graphics.endFill();
//			map.addChild(p);
			
			_playerLayer = new Sprite();
			_playerLayer.addChild(p);
			this.addChild(_playerLayer);
			
			map.addEventListener(MouseEvent.CLICK,onClick);
			addEventListener(Event.ENTER_FRAME,onFrame);
		}
		
		protected function onFrame(event:Event):void
		{
			if(_stepCount > 0)
			{
				p.x += _stepX;
				p.y += _stepY;
				var mapPoint:Point = windowScroll.scroll(new Point(p.x,p.y));
				map.x = mapPoint.x;
				map.y = mapPoint.y;
				_playerLayer.x = mapPoint.x;
				_playerLayer.y = mapPoint.y;
				
				_stepCount--;
			}
		}
		
		protected function onClick(event:MouseEvent):void
		{
			var mouseX:int = map.mouseX;
			var mouseY:int = map.mouseY;
			var angle : Number = Math.atan2(mouseY - p.y, mouseX - p.x);
			var ds : Number = Point.distance(new Point(mouseX,mouseY), new Point(p.x,p.y));
			_stepCount = ds / _speed;
			_stepX = _speed * Math.cos(angle);
			_stepY = _speed * Math.sin(angle);
		}
	}
}