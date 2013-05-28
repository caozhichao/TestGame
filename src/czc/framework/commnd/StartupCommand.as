package czc.framework.commnd
{
	import czc.framework.display.ViewStruct;
	import czc.framework.manager.LoaderManager;
	import czc.framework.manager.PopUpManager;
	
	import game.startup.EnterGameCommand;
	import game.startup.InitLoadCommand;
	import game.startup.InitModelCommnad;
	import game.startup.InitViewStructCommand;
	import game.startup.event.StartupEvent;
	
	public class StartupCommand extends InjectorActorCommand
	{
		public function StartupCommand()
		{
			super();
		}
		override public function execute():void
		{
			initManager();
			commandMap.mapEvent(StartupEvent.INIT_VIEW_STRUCT,InitViewStructCommand,StartupEvent,true);
			commandMap.mapEvent(StartupEvent.INIT_MODEL_COMMAND,InitModelCommnad,StartupEvent,true);
			commandMap.mapEvent(StartupEvent.INIT_LOAD,InitLoadCommand,StartupEvent,true);
			commandMap.mapEvent(StartupEvent.ENTER_GAME,EnterGameCommand,StartupEvent,true);
//			dispatch(new StartupEvent(StartupEvent.INIT_LOAD));
		}
		private function initManager():void
		{
			instanceInjector(ViewStruct);
			instanceInjector(LoaderManager);
			instanceInjector(PopUpManager);
		}
	}
}