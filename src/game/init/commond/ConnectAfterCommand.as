package game.init.commond
{
	import game.init.event.InitGameEvent;
	
	import org.robotlegs.mvcs.Command;
	
	
	/**
	 * @author caozhichao
	 * 创建时间：2013-5-29 下午2:29:28
	 * 
	 */
	public class ConnectAfterCommand extends Command
	{
		public function ConnectAfterCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			super.execute();
			dispatch(new InitGameEvent(InitGameEvent.INIT_CONFIG));
		}
	}
}