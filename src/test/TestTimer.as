package test
{
	import flash.display.Sprite;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import czc.framework.manager.TimerManager;
	
	
	/**
	 * @author caozhichao
	 * 创建时间：2013-5-28 上午11:19:52
	 * 
	 */
	public class TestTimer extends Sprite
	{
		private var num:int;
		private var t:Number;
		
		public function TestTimer()
		{
			super();
			TimerManager.instance.init(60);
//			TimerManager.instance.setTimeout(test,1000,2);
			TimerManager.instance.setInterval(test,1000);
			function aa():void
			{
				TimerManager.instance.changeDelay(test,2000);
			}
//			setTimeout(aa,5000);
			
			t = getTimer();
		}
		
		private function test():void
		{
			num++;
			var cur:Number = getTimer();
			trace("TestTimer.test()",num,new Date().toString()," 时间间隔:" + (cur - t));
			t = cur;
			
			if(num == 5)
			{
				TimerManager.instance.changeDelay(test,2000);
			}
		}
	}
}