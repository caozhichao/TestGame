package game.startup
{
	import game.map.command.MapInitCommand;
	import game.startup.event.StartupEvent;
	
	import org.robotlegs.mvcs.Command;
	
	
	/**
	 * @author caozhichao
	 * 创建时间：2013-5-27 下午3:46:35
	 * 
	 */
	public class InitModelCommnad extends Command
	{
		public function InitModelCommnad()
		{
			super();
		}
		override public function execute():void
		{
			var list:Array = [MapInitCommand];
			var cla:Class;
			var len:int = list.length;
			for (var i:int = 0; i < len; i++) 
			{
				cla = list[i];
				commandMap.mapEvent(StartupEvent.INIT_MODEL_COMMAND,cla,StartupEvent,true);
			}
			dispatch(new StartupEvent(StartupEvent.INIT_MODEL_COMMAND));
		}
	}
}