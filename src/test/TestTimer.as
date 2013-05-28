package test
{
	import flash.display.Sprite;
	
	import czc.framework.manager.TimerManager;
	
	
	/**
	 * @author caozhichao
	 * 创建时间：2013-5-28 上午11:19:52
	 * 
	 */
	public class TestTimer extends Sprite
	{
		public function TestTimer()
		{
			super();
			TimerManager.instance.init(20);
		}
	}
}