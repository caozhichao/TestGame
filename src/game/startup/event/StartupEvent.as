package game.startup.event
{
	import czc.framework.event.BaseEvent;
	
	public class StartupEvent extends BaseEvent
	{
		//初始化加载
		public static const INIT_LOAD:String = "INIT_LOAD";
		//进入游戏
		public static const ENTER_GAME:String = "ENTER_GAME";
		//初始化显示结构
		public static const INIT_VIEW_STRUCT:String = "InitViewStructCommand";
		//初始化 init model commnad
		public static const INIT_MODEL_COMMAND:String = "INIT_MODEL_COMMAND";
		public function StartupEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}