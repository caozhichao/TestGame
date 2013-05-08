package czc.framework
{
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	import czc.framework.commnd.StartupCommand;
	
	/**
	 * 
	 * @author ZhiChaoCao
	 * 
	 */		
	public class GameContext extends Context
	{
		public function GameContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		override public function startup():void
		{
			//这个 Context 只映射一个 command 到 ContextEvent.STARTUP 事件. 
			//这个 StartupCommand 将映射其它将在应用程序里使用的的 command, 
			//mediator, service, 和 model.
			commandMap.mapEvent( ContextEvent.STARTUP, StartupCommand, ContextEvent, true );
			
			//启动应用程序 (触发 StartupCommand)
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));
		}
	}
}