package test
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.getTimer;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-10-10 下午3:11:19
	 * 
	 */
	public class KeyboardEventTest extends Sprite
	{
		private var keyDownList:Array;
		private var executeState:int;
		private var t1:Number = 0;
		private var commandStr:String;
		
		public function KeyboardEventTest()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,onAdded,false,0,true);
			keyDownList = [];
			commandStr = "";
		}
		
		protected function onAdded(event:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			addEventListener(Event.ENTER_FRAME,onFrame);
		}
		
		protected function onFrame(event:Event):void
		{
			if(executeState == ExecuteState.READ_EXECUTE)
			{//准备处理
				var t:Number = getTimer();
				if(t1 == 0)
				{
					t1 = t;
				} else if(t - t1 > 300)
				{
					t1 = 0;
					executeState = ExecuteState.EXECUTE;
				} 
			}else if(executeState == ExecuteState.EXECUTE)
			{//处理
				trace("处理指令:" + commandStr);
				executeState = ExecuteState.NO_EXECUTE;
				commandStr = "";
			}
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			executeState = ExecuteState.READ_EXECUTE;
			var vo:KeyDownVo = KeyDownVo.createKeyDownVo(event.keyCode,event.keyLocation,getTimer());
			keyDownList.push(vo);
			trace("按下 keyCode:" + event.keyCode + " keyLocation:" + event.keyLocation + " 时间:" + getTimer());
			commandStr += getCharByCode(event.keyCode);
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
//			trace("弹起 keyCode:" + event.keyCode + " keyLocation:" + event.keyLocation + " 时间:" + getTimer());
		}
		
		private function getCharByCode(keyCode:int):String
		{
			var char:String;
			switch(keyCode)
			{
				case 65:
					char = "A";
					break;
				case 68:
					char = "D";
					break;
				case 83:
					char = "S";
					break;
				case 87:
					char = "W";
					break;
				case 74:
					char = "J";
					break;
			}
			return char;
		}
		
	}
}

class KeyDownVo
{
	public var keyCode:int;
	public var keyLocation:int;
	public var time:Number;
	
	public static function createKeyDownVo(kCode:int,kLocation:int,downTime:Number):KeyDownVo
	{
		var vo:KeyDownVo = new KeyDownVo();
		vo.keyCode = kCode;
		vo.keyLocation = kLocation;
		vo.time = downTime;
		return vo;
	}
}

class ExecuteState
{
	public static const NO_EXECUTE:int = 0
	public static const READ_EXECUTE:int = 1;
	public static const EXECUTE:int = 2;
}

