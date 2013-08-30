package czc.framework.ds
{
	
	/**
 	 * 最大堆   它的每个节点都比它的子节点大。
	 * 最小堆   它的每个节点都比它的子节点小。
	 * Heap是一种特殊的二叉树，它的每个节点都比它的子节点大(或小)。内部实现是用数组存储的。
	 * 比如原树状结构为： 
	 *    2
	 *   / \
	 *  1   0
	 * 则存储成数组为：
	 * [2,1,0]	 
	 * @author caozhichao
	 * 创建时间：2013-8-21 下午2:47:22
	 * 
	 */
	public class Heap
	{
		private var _heap:Array;
		//添加的位置
		private var _postionIndex:int;
		//比较函数  return -1 0 1
		private var _compare:Function;
		public function Heap(compare:Function)
		{
			_compare = compare;
			reset();
 		}
		
		public function reset():void
		{
			_heap = [];
			_postionIndex = 0;
		}
		
		/**
		 * 入队
		 * @param value
		 * 
		 */		
		//pIndex = (childindex -1)/2
		public function enqueue(value:*):void
		{
			_heap[_postionIndex] = value;
			sort(_postionIndex);
			_postionIndex++;
		}
		
		/**
		 * 排序 
		 * @param childIndex
		 * 
		 */		
		private function sort(childIndex:int):void
		{
			//父节点index
			var pIndex:int;
			//子节点index
			var cIndex:int = childIndex;
			var temp:* = _heap[cIndex];
			//cIndex>0才有pIndex
			while(cIndex > 0)
			{
				pIndex = (cIndex - 1) >> 1;
				//如果新插入的数据大于parent的数据，则应不断上移与parent交换位置
				if(_compare(temp,_heap[pIndex]) > 0)
				{
					_heap[cIndex] = _heap[pIndex]; 
					//更改子节点的位置
					cIndex = pIndex;
				} else 
				{
					break;
				}
			}
			_heap[cIndex] = temp;
		}
		
		/**
		 * 修改数据 
		 * @param obj
		 * @param newObj
		 * @return 
		 * 
		 */		
		public function modify(obj:*,newObj:*):Boolean
		{
			var cindex :int = this._heap.indexOf(obj);
			if(cindex < 0)return false
			_heap[cindex]= newObj;
			sort(cindex);
			return true
		}
		/**
		 * 出队 
		 * @return 
		 * 
		 */		
		public function dequeue():*
		{
			var element:* = _heap[0];
			var lastElement:* = _heap.pop(); 
			_postionIndex--;
			if(_postionIndex > 0)
			{
				_heap[0] = lastElement;
				var pIndex:int = 0;
				var cIndex:int = 1;
				var temp:* = _heap[pIndex];
				while(cIndex <= _postionIndex-1)
				{
					//比较2个子节点
					if(_heap[cIndex+1] && this._compare(_heap[cIndex],_heap[cIndex+1]) < 0)
					{
						cIndex++;
					}
					if(this._compare(temp,this._heap[cIndex])<0)
					{
						_heap[pIndex] = _heap[cIndex];
						pIndex = cIndex;
						//计算子节点的位置
						cIndex = (cIndex << 1) + 1;
					}else
					{
						break
					}
				}
				_heap[pIndex] = temp;
			}
			return element;
		}
		
		public function toString():String
		{
			return _heap.toString();
		}
		
		public function get heap():Array
		{
			return _heap;
		}
		
		public function toTree():void
		{
			var pIndex:int = 0;
			var cIndex:int = 1;
			if(_postionIndex > 0)
			{
				trace("     " + _heap[pIndex]);
			}
			while(cIndex < _postionIndex - 1)
			{
				trace("//");
				
				trace(" \\");
			}	
		}
	}
}