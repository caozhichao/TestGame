package game.init
{
	import flash.system.ApplicationDomain;
	
	import czc.framework.manager.LoaderManager;
	
	import game.init.event.InitGameEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class InitLoadCommand extends Command
	{
		[Inject]
		public var loaderManager:LoaderManager;
		public function InitLoadCommand()
		{
			super();
		}
		override public function execute():void
		{
			loaderManager.load(["assets/ui/mainUI.swf","assets/ui/component.swf"],onAllComplete,ApplicationDomain.currentDomain);
		}
		
		private function onAllComplete():void
		{
			dispatch(new InitGameEvent(InitGameEvent.INIT_VIEW_STRUCT));
		}
	}
}