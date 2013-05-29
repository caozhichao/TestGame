package game.init.commond
{
	import game.init.event.InitGameEvent;
	
	import org.robotlegs.mvcs.Command;
	
	
	/**
	 * @author caozhichao
	 * 创建时间：2013-5-29 下午2:39:03
	 * 
	 */
	public class InitModelCommand extends Command
	{
		public function InitModelCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			dispatch(new InitGameEvent(InitGameEvent.INIT_SERVICE));
		}
	}
}