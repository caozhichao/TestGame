package game.init
{
	import game.map.command.MapInitCommand;
	import game.init.event.InitGameEvent;
	
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
				commandMap.mapEvent(InitGameEvent.INIT_MODEL_COMMAND,cla,InitGameEvent,true);
			}
			dispatch(new InitGameEvent(InitGameEvent.INIT_MODEL_COMMAND));
		}
	}
}