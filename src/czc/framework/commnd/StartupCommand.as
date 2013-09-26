package czc.framework.commnd
{
	import czc.framework.display.ViewStruct;
	import czc.framework.manager.LoaderManager;
	import czc.framework.manager.PopUpManager;
	
	import game.init.EnterGameCommand;
	import game.init.InitLoadCommand;
	import game.init.InitModelCommnad;
	import game.init.InitViewStructCommand;
	import game.init.commond.ConnectAfterCommand;
	import game.init.commond.ConnectBeforCommnad;
	import game.init.commond.InitConfigCommand;
	import game.init.commond.InitModelCommand;
	import game.init.commond.InitServiceCommand;
	import game.init.event.InitGameEvent;
	
	public class StartupCommand extends InjectorActorCommand
	{
		public function StartupCommand()
		{
			super();
		}
		override public function execute():void
		{
			initManager();
			
			commandMap.mapEvent(InitGameEvent.CONNECT_BEFOR,ConnectBeforCommnad,InitGameEvent,true);
			commandMap.mapEvent(InitGameEvent.CONNECT_AFTER,ConnectAfterCommand,InitGameEvent,true);
			commandMap.mapEvent(InitGameEvent.INIT_CONFIG,InitConfigCommand,InitGameEvent,true);
			commandMap.mapEvent(InitGameEvent.INIT_MODEL,InitModelCommand,InitGameEvent,true);
			commandMap.mapEvent(InitGameEvent.INIT_SERVICE,InitServiceCommand,InitGameEvent,true);
			dispatch(new InitGameEvent(InitGameEvent.CONNECT_BEFOR));
		}
		private function initManager():void
		{
			instanceInjector(ViewStruct);
			instanceInjector(LoaderManager);
//			instanceInjector(PopUpManager);
		}
	}
}