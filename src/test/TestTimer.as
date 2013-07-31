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
		private var num:int;
		public function TestTimer()
		{
			super();
			TimerManager.instance.init(60);
//			TimerManager.instance.setTimeout(test,1000,2);
			TimerManager.instance.setInterval(test,10);
		}
		
		private function test():void
		{
			num++;
			trace("TestTimer.test()",num,new Date().toString());
		}
	}
}