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
		//tick执行的时间间隔
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
			//计算timer经过的时间
			_t1 += curTime - _lastTime;
			_lastTime = curTime;
			//实际处理tick 会有跳帧处理
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
			var index:int = 0;
			while(index < len)
			{
				timeVo = _timeQueue[index];
				if(curTime - timeVo.startTime >= timeVo.delay * timeVo.index)
				{
					timeVo.closure();
					timeVo.index++;
					if(timeVo.index > timeVo.count)
					{// timer执行的次数完成
						_timeQueue.splice(index,1);
						index--;
						//重新计算len
						len = _timeQueue.length;
					}
				}
				index++;
			}
		}
		
		/**
		 *  
		 * @param closure   执行函数
		 * @param delay     时间间隔
		 * @param count     执行的次数  默认是1次
		 * @param arguments 
		 * 
		 */		
		public function setTimeout(closure:Function, delay:Number, count:int=1,... arguments):void
		{
			addTime(closure,delay,count,arguments);
		}
		
		/**
		 *  
		 * @param closure
		 * @param delay
		 * @param arguments
		 * 
		 */		
		public function setInterval(closure:Function, delay:Number, ... arguments):void
		{
			addTime(closure,delay,Infinity,arguments);
		}
		
		/**
		 * 清楚timer 
		 * @param closure
		 * 
		 */		
		public function clearTimer(closure:Function):void
		{
			var timeVO:TimeVO = getTimeVO(closure);
			var index:int = _timeQueue.indexOf(timeVO);
			_timeQueue.splice(index,1);
		}
		private function getTimeVO(fun:Function):TimeVO
		{
			var index:int = 0;
			var len:int = _timeQueue.length;
			var timeVo:TimeVO;
			while(index < len)
			{
				timeVo = _timeQueue[index];
				if(timeVo.closure == fun)
				{
					return timeVo;
				}
				index++;
			}
			return null;
		}
		
		/**
		 * 更改时钟执行时间间隔 
		 * @param fun
		 * @param delay
		 * 
		 */		
		public function changeDelay(fun:Function,delay:int):void
		{
			var timeVO:TimeVO = getTimeVO(fun);
			clearTimer(fun);
			addTime(fun,delay,Infinity);
		}
		
		/**
		 * 加入 _timeQueue 队列
		 * @param closure
		 * @param delay
		 * @param count
		 * @param arguments
		 * 
		 */		
		private function addTime(closure:Function, delay:Number, count:Number,... arguments):void
		{
			if(getTimeVO(closure) == null)
			{
				var timeVO:TimeVO = new TimeVO(closure,delay,count,getTimer(),arguments);
				_timeQueue.push(timeVO);
			} else 
			{
				throw Error(closure + "已经存在!");
			}
		}
	}
}
class TimeVO
{
	public var closure:Function;
	public var delay:Number;
	public var args:Array;
	public var count:Number;
	public var startTime:Number;
	public var index:int = 1;
	public function TimeVO(closure:Function, delay:Number, count:Number,startTime:Number,... arguments)
	{
		this.closure = closure;
		this.delay = delay;
		this.count = count;
		this.startTime = startTime;
		this.args = arguments;
	}
}