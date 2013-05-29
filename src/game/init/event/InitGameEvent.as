package game.init.event
{
	import czc.framework.event.BaseEvent;
	
	public class InitGameEvent extends BaseEvent
	{
		//初始化加载
		public static const INIT_LOAD:String = "INIT_LOAD";
		//进入游戏
		public static const ENTER_GAME:String = "ENTER_GAME";
		//初始化显示结构
		public static const INIT_VIEW_STRUCT:String = "InitViewStructCommand";
		//初始化 init model commnad
		public static const INIT_MODEL_COMMAND:String = "INIT_MODEL_COMMAND";
		
		
		//连接之前
		public static const CONNECT_BEFOR:String = "connect_befor";
		//连接之后
		public static const CONNECT_AFTER:String = "connect_after";
		//初始化配置
		public static const INIT_CONFIG:String = "init_config";
		//预初始化model
		public static const INIT_MODEL:String = "init_model";
		//预初始化service
		public static const INIT_SERVICE:String = "init_service";
		//初始化模块commnad
		public static const INIT_PANEL_INIT:String = "init_panel_init";
		
		public function InitGameEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}