package game.startup
{
	import flash.system.ApplicationDomain;
	
	import czc.framework.manager.LoaderManager;
	
	import game.startup.event.StartupEvent;
	
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
			dispatch(new StartupEvent(StartupEvent.INIT_VIEW_STRUCT));
		}
	}
}