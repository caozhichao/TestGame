package czc.framework.component
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import czc.framework.event.BaseEvent;
	
	
	
	/**
	 *MovieClip Button
	 *作为2种按钮使用
	 * 1.简单按钮模拟SimpleButton 第4帧为不可点击状态 
	 * 2.多个按钮关联使用 停留在按下状态，按下状态是不可点击的
	 * 
	 * 	mc 一般分为3层
	 * 图片层
	 * 文本层
	 * 代码层 (可控制文本的颜色...)
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
		//不能点击状态帧
		public static const FRAME_CAN_NOT_CLICK:int = 4;
		//按钮当前帧
		protected var _curFrameIndex:int;
		//是否是简单按钮(和正常按钮一样自动弹起)
		protected var _isSimpleButton:Boolean;
		//按钮文本
		protected var _label:TextField;
		public static const MC_BUTTON_EVENT:String = "MC_BUTTON_EVENT";
		public function MCButton(_skin:MovieClip=null,_isSimpleButton:Boolean=false)
		{
			skin = _skin;
			isSimpleButton = _isSimpleButton;
			this.mouseChildren = false;
			_label = _skin.getChildByName("_label") as TextField;
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			addEventListener(MouseEvent.MOUSE_OVER,onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT,onMouseOut);
		}
		
		/**
		 * 设置为简单按钮 
		 * @param value
		 * 
		 */		
		public function set isSimpleButton(value:Boolean):void
		{
			_isSimpleButton = value;
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			frameButtonIndex = FRAME_UP;
		}
		
		protected function onMouseUp(event:MouseEvent):void
		{
			if(_isSimpleButton)
			{
				frameButtonIndex = FRAME_OVER;
			}
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
			if(_isSimpleButton && _curFrameIndex != FRAME_CAN_NOT_CLICK)
			{
				return true;
			} else if(!_isSimpleButton && _curFrameIndex != FRAME_DOWN)
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
		
		/**
		 * 设置按钮文字 
		 * @param value
		 * 
		 */		
		public function set label(value:String):void
		{
			_label.text = value;
		}
		
		private function set frameButtonIndex(value:int):void
		{
			if(hasMouseEvent)
			{
				setButtonState(value);
			}
		}
		
		/**
		 * 设置按状态 
		 * 
		 */		
		private function setButtonState(state:int):void
		{
			//记录按钮当前帧
			_curFrameIndex = state;
			_skin.gotoAndStop(state);
			//触发事件
			dispatch(_curFrameIndex);
		}
		
		
		/**
		 * 设置按钮当前状态 
		 * @param value
		 * 
		 */		
		public function set setCurButtonState(value:int):void
		{
			setButtonState(value);
		}
		
		/**
		 *  dispatch event
		 * @param value
		 * 
		 */		
		protected function dispatch(value:int):void
		{
			dispatchEvent(new BaseEvent(MC_BUTTON_EVENT,value));
		}
		
		public function get curFrameIndex():int
		{
			return _curFrameIndex;
		}
	}
}

