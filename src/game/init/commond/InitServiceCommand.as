package game.init.commond
{
	import game.init.event.InitGameEvent;
	
	import org.robotlegs.mvcs.Command;
	
	
	/**
	 * @author caozhichao
	 * 创建时间：2013-5-29 下午2:39:50
	 * 
	 */
	public class InitServiceCommand extends Command
	{
		public function InitServiceCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			dispatch(new InitGameEvent(InitGameEvent.INIT_PANEL_INIT));
		}
	}
}