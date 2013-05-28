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
		private var _timeQueue:Vector.<TimeVO>;
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
		}
		public function init(frameRate:int):void
		{
			_frameRate = frameRate;
			_frameTime = Math.ceil(1000 / _frameRate);
			_lastTime = getTimer();
			_t1 = 0;
			_timeQueue = new Vector.<TimeVO>();
			timer = new Timer(15);
			timer.addEventListener(TimerEvent.TIMER,onTimer);
			timer.start();
		}
		private function onTimer(evt:TimerEvent):void
		{
			var curTime:Number = getTimer();
			_t1 += curTime - _lastTime;
			_lastTime = curTime;
			while (_t1 >= _frameTime) {
				_t1 -= _frameTime;
				tick();
			}
		}
		
		private function tick():void
		{
			var curTime:Number = getTimer();
			var len:int = _timeQueue.length;
			var timeVo:TimeVO;
			for (var i:int = 0; i < len; i++) 
			{
				timeVo = _timeQueue[i];
				if(curTime - timeVo.startTime >= timeVo.delay * timeVo.index)
				{
					timeVo.closure();
					timeVo.index++;
				}
			}
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
			var timeVO:TimeVO = new TimeVO(closure,delay,count,getTimer(),arguments);
			_timeQueue.push(timeVO);
		}
	}
}
class TimeVO
{
	public var closure:Function;
	public var delay:Number;
	public var args:Array;
	public var count:int;
	public var startTime:Number;
	public var index:int = 1;
	public function TimeVO(closure:Function, delay:Number, count:int,startTime:Number,... arguments)
	{
		this.closure = closure;
		this.delay = delay;
		this.count = count;
		this.startTime = startTime;
		this.args = arguments;
	}
}