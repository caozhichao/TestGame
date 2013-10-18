package test
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
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
		private var _frames:int;
		
		public function TestTimer()
		{
			super();
			TimerManager.instance.init(60);
//			TimerManager.instance.setTimeout(test,1000,2);
//			TimerManager.instance.setInterval(test,50);
			function aa():void
			{
				TimerManager.instance.changeDelay(test,2000);
			}
//			setTimeout(aa,5000);
			
			/*
			var timer:Timer = new Timer(15);
			timer.addEventListener(TimerEvent.TIMER,onTimer);
			t = getTimer();
			timer.start();
			*/
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			_frames++;
			var cur:Number = getTimer();
//			trace(cur - t);
			var elapsed:int = cur - t;
			if(elapsed >= 1000)
			{
				var _fps:Number = Math.round(_frames * 1000 / elapsed);
				trace("FPS:" + _fps + " _frames:" + _frames + " elapsed:" + elapsed);
				_frames = 0;
				t = cur;
			}
		}
		
		private function test():void
		{
			num++;
			var cur:Number = getTimer();
			trace("TestTimer.test()",num,new Date().toString()," 时间间隔:" + (cur - t));
			t = cur;
		}
	}
}