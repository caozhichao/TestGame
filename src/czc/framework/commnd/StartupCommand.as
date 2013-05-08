package czc.framework.commnd
{
	import br.com.stimuli.loading.BulkLoader;
	
	import czc.framework.display.ViewStruct;
	import czc.framework.event.BaseEvent;
	
	import flash.display.Sprite;
	
	import game.startup.EnterGameCommand;
	import game.startup.InitLoadCommand;
	import game.startup.event.StartupEvent;
	
	import org.robotlegs.mvcs.Command;
	
	import test.TestCommand;
	
	public class StartupCommand extends InjectorActorCommand
	{
		public function StartupCommand()
		{
			super();
		}
		override public function execute():void
		{
			instanceInjector(ViewStruct);
			instanceInjector(BulkLoader);
			commandMap.mapEvent(StartupEvent.INIT_LOAD,InitLoadCommand,StartupEvent,true);
			commandMap.mapEvent(StartupEvent.ENTER_GAME,EnterGameCommand,StartupEvent,true);
			dispatch(new StartupEvent(StartupEvent.INIT_LOAD));
			
			/********************测试*****************/
			/*
			commandMap.mapEvent(BaseEvent.TEST_EVENT,TestCommand,BaseEvent,true);
			dispatch(new BaseEvent(BaseEvent.TEST_EVENT));
			*/
		}
	}
}