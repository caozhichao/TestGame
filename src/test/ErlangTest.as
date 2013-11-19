package test
{
	import flash.display.Sprite;
	import flash.utils.getTimer;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-11-14 下午1:59:07
	 * 
	 */
	public class ErlangTest extends Sprite
	{
		private var num:int;
		public function ErlangTest()
		{
			super();
			var list:Array = [];
			for (var i:int = 0; i < 10; i++) 
			{
				list[i] = int(Math.random() * 1000);
			}
			trace(list);
			var t:Number = getTimer();
			trace(qsort(list));
			trace("耗时:",getTimer() - t + "num:" + num);
		}
		
		private function qsort(list:Array):Array
		{
			if(list.length == 0)
			{
				return [];
			} 
			var value:int = list.shift();
			var min:Array = [];
			var max:Array = [];
			var len:int = list.length;
			for (var i:int = 0; i < len; i++) 
			{
				num++;
				if(list[i] < value)
				{
					min.push(list[i]);
				} else 
				{
					max.push(list[i]);
				}
			}
			return concat(concat(qsort(min),[value]),qsort(max));
		}
		private function concat(l1:Array,l2:Array):Array
		{
			for (var i:int = 0; i < l2.length; i++) 
			{
				l1.push(l2[i]);
			}
			return l1;
		}
		
		private function a():Function
		{
			return function b():void
			{
			} 
		}
		
	}
}