package czc.framework.manager
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	/**
	 * @author caozhichao
	 * 创建时间：2013-5-28 上午10:51:53
	 * 
	 */
	public class TimerManager
	{
		private var list:Array;
		public static var instance:TimerManager = new TimerManager();
		private var timer:Timer;
		private var _frameRate:int;
		private var _frameTime:int;
		private var _lastTime:Number;
		private var _t1:Number;
		public function TimerManager()
		{
			if(instance)
			{
				throw new Error("a single");
			}
			_t1 = 0;
			list = [];
			timer = new Timer(15);
			timer.addEventListener(TimerEvent.TIMER,onTimer);
		}
		
		public function init(frameRate:int):void
		{
			_frameRate = frameRate;
			_frameTime = Math.ceil(1000 / _frameRate);
			_lastTime = getTimer();
			timer.start();
		}
		private function onTimer(evt:TimerEvent):void
		{
			var curTime:Number = getTimer();
			trace("____",curTime - _lastTime,"________");
			_t1 += curTime - _lastTime;
			_lastTime = curTime;
			while (_t1 >= _frameTime) {
				_t1 -= _frameTime;
				tick();
			}
		}
		
		private function tick():void
		{
			trace("TimerManager.tick()");
		}
		
		public function setTimeout(closure:Function, delay:Number, ... arguments):void
		{
			addTime(closure,delay,1,arguments);
		}
		
		public function setInterval(closure:Function, delay:Number, ... arguments):void
		{
			addTime(closure,delay,Infinity,arguments);
		}
		
		private function addTime(closure:Function, delay:Number, count:int,... arguments):void
		{
			var timeVo:TimeVo = new TimeVo(closure,delay,count,arguments);
			list.push(timeVo);
		}
	}
}
class TimeVo
{
	public var _closure:Function;
	public var _delay:Number;
	public var _args:Array;
	public var _count:int;
	public function TimeVo(closure:Function, delay:Number, count:int,... arguments)
	{
		_closure = closure;
		_delay = delay;
		_count = count;
		_args = arguments;
	}
}