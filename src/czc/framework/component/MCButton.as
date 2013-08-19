package czc.framework.component
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import czc.framework.event.BaseEvent;
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-15 上午9:16:48
	 * 
	 */
	public class MCButton extends Sprite
	{
		//skin
		protected var _skin:MovieClip;
		//弹起状态
		public static const FRAME_UP:int = 1;
		//经过状态
		public static const FRAME_OVER:int =2;
		//按下状态
		public static const FRAME_DOWN:int = 3;
		//按钮当前帧
		protected var curFrameIndex:int;
		//是否是简单按钮(和正常按钮一样自动弹起)
		protected var _isSimpleButton:Boolean;
		public static const MC_BUTTON_EVENT:String = "MC_BUTTON_EVENT";
		public function MCButton(_skin:MovieClip=null,isSimpleButton:Boolean=false)
		{
			skin = _skin;
			_isSimpleButton = isSimpleButton;
			this.mouseChildren = false;
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			frameButtonIndex = FRAME_UP;
		}
		
		protected function onMouseUp(event:MouseEvent):void
		{
			frameButtonIndex = FRAME_UP;
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			frameButtonIndex = FRAME_OVER;
		}
		
		protected function onMouseDown(event:MouseEvent):void
		{
			frameButtonIndex = FRAME_DOWN;
		}
		
		private function get hasMouseEvent():Boolean
		{
			if(_isSimpleButton || curFrameIndex != FRAME_DOWN)
			{
				return true;
			}
			return false;
		}
		
		public function set skin(skin:MovieClip):void
		{
			_skin = skin;
			if(_skin)
			{
				addChild(_skin);
				frameButtonIndex = FRAME_UP;
			}
		}
		
		public function set frameButtonIndex(value:int):void
		{
			if(hasMouseEvent)
			{
				_skin.gotoAndStop(value);
				//记录按钮当前帧
				curFrameIndex = value;
				//触发事件
				dispatch(curFrameIndex);
			}
		}
		
		protected function dispatch(value:int):void
		{
			dispatchEvent(new BaseEvent(MC_BUTTON_EVENT,value));
		}
	}
}