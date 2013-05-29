package game.init
{
	import czc.framework.display.ViewStruct;
	import czc.framework.manager.PopUpManager;
	
	import org.robotlegs.mvcs.Command;
	
	public class InitViewStructCommand extends Command
	{
		[Inject]
		public var struct:ViewStruct;
		[Inject]
		public var popUpManager:PopUpManager;
		
		public function InitViewStructCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			struct.init(contextView);
			popUpManager.init(struct.getLayerById(ViewStruct.POPUP));
			
			//进入游戏
//			dispatch(new StartupEvent(StartupEvent.ENTER_GAME));
			
		}
		
	}
}