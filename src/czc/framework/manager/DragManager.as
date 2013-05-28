package czc.framework.manager
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
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
		public function DragManager()
		{
			if(instance)
			{
				throw new Error("DragManager a single");
			}
			_dic = new Dictionary();
		}
		public function init(spr:Sprite):void
		{
			_container = spr;
		}
		
		public function addDrag(target:DisplayObject):void
		{
			var stage:Stage;
			_dic[target] = target;
			function onMouseDown(evt:MouseEvent):void
			{
				stage  = target.stage;
				stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
				stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			}
			function onMouseMove(evt:MouseEvent):void
			{
				
			}
			function onMouseUp(evt:MouseEvent):void
			{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
				stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			}
			target.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		}
		
		private function removeDrag():void
		{
			
		}
	}
}