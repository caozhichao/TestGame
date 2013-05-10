package czc.framework.commnd
{
	import br.com.stimuli.loading.BulkLoader;
	
	import czc.framework.display.ViewStruct;
	import czc.framework.event.BaseEvent;
	import czc.framework.manager.LoaderManager;
	
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
			var struct : ViewStruct = instanceInjector(ViewStruct);
			initViewStruct(struct);
			instanceInjector(LoaderManager);
			commandMap.mapEvent(StartupEvent.INIT_LOAD,InitLoadCommand,StartupEvent,true);
			commandMap.mapEvent(StartupEvent.ENTER_GAME,EnterGameCommand,StartupEvent,true);
			dispatch(new StartupEvent(StartupEvent.INIT_LOAD));
		}
		private function initViewStruct(struct:ViewStruct):void
		{
			struct.init(contextView)
		}
	}
}