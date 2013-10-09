package czc.framework
{
	import flash.display.DisplayObjectContainer;
	
	import czc.framework.commnd.StartupCommand;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	import test.command.TestCommand;
	import test.model.TestModel;
	import test.view.TestMediator;
	import test.view.TestView;
	
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
//			commandMap.mapEvent( ContextEvent.STARTUP, StartupCommand, ContextEvent, true );
			
			//test
			commandMap.mapEvent(ContextEvent.STARTUP,TestCommand,ContextEvent,true);
			var testModel1:TestModel = new TestModel();
//			var testModel2:TestModel = new TestModel();
			injector.mapValue(TestModel,testModel1,"testModel1");
//			injector.injectInto(testModel1);
//			injector.mapValue(TestModel,testModel2,"testModel2");
			mediatorMap.mapView(TestView,TestMediator);
			//
			
			//启动应用程序 (触发 StartupCommand)
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));
		}
	}
}