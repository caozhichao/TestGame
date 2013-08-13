package czc.framework.manager
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import czc.framework.display.IDrag;
	
	/**
	 * @author caozhichao
	 * 创建时间：2013-5-23 上午11:25:32
	 * 
	 */
	public final class DragManager
	{
		private var _container:DisplayObjectContainer;
		public static var instance:DragManager = new DragManager();
		private var _dic:Dictionary;
		private var _downEventDic:Dictionary;
		private var _stage:Stage;
		private var _isDrag:Boolean;
		//当前拖动的对象
		private var _curDragObj:IDrag;
		
		public function DragManager()
		{
			if(instance)
			{
				throw new Error("DragManager a single");
			}
			_dic = new Dictionary();
			_downEventDic = new Dictionary();
		}
		public function init(spr:Sprite):void
		{
			_container = spr;
			if(_container.stage)
			{
				initEvent();
			} else 
			{
				_container.addEventListener(Event.ADDED_TO_STAGE,addToStage,false,0,true);
			}
		}
		
		private function initEvent():void
		{
			_stage = _container.stage;
		}
		
		protected function addToStage(event:Event):void
		{
			_container.removeEventListener(Event.ADDED_TO_STAGE,addToStage);
			initEvent();
		}
		
		public function addDrag(target:IDrag):void
		{
			_dic[target] = target;
			_downEventDic[target] = onMouseDown;
			var moveDisplayObject:DisplayObject
			var downX:int;
			var downY:int;
			function onMouseDown(evt:MouseEvent):void
			{
				_stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
				_stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
				moveDisplayObject = target.dragDisplay;
				var p:Point = target.dragDisplayPoint;
				moveDisplayObject.x = p.x;
				moveDisplayObject.y = p.y;
				//记录按钮的位置
				downX = _stage.mouseX;
				downY = _stage.mouseY;
			}
			
			function onMouseMove(evt:MouseEvent):void
			{
				var curMouseX:int = _stage.mouseX;
				var curMouseY:int = _stage.mouseY;
				if(!_isDrag && Point.distance(new Point(curMouseX,curMouseY),new Point(downX,downY)) > 3)
				{
					_isDrag = true;
					_curDragObj = target;
					target.start();
					_container.addChild(moveDisplayObject);
				} 
				if(_isDrag)
				{
					//计算鼠标拖动的位置
					moveDisplayObject.x += curMouseX - downX;
					moveDisplayObject.y += curMouseY - downY;
					downX = curMouseX;
					downY = curMouseY;
					target.draging();
				}
			}
			
			function onMouseUp(evt:MouseEvent):void
			{
				_stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
				_stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
				if(_isDrag)
				{
					_container.removeChild(moveDisplayObject);
					target.stop();
					_isDrag = false;
					_curDragObj = null;
				}
			}
			target.content.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		}
		
		public function get curDragObj():IDrag
		{
			return _curDragObj;
		}
		public function removeDrag(target:IDrag):void
		{
			var onMouseDown:Function = _downEventDic[target];
			target.content.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			delete _dic[target];
			delete _downEventDic[target];
		}
	}
}