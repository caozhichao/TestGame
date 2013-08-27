package test
{
	import flash.display.Sprite;
	
	import czc.framework.ds.Heap;
	
	
	/**
	 * @author caozhichao
	 * 创建时间：2013-8-21 下午3:12:29
	 * 
	 */
	public class HeapTest extends Sprite
	{
		public function HeapTest()
		{
			super();
			function compare(a:int,b:int):int
			{
				return a - b;
			}
			var heap:Heap = new Heap(compare);
			
			heap.enqueue(2);
			heap.enqueue(6); 
			heap.enqueue(5);  
			heap.enqueue(8);  
			heap.enqueue(7);  
			heap.enqueue(4); 
			heap.enqueue(1);  
			heap.enqueue(3);  
			heap.enqueue(9);
			trace(heap.toString());
////			heap.dequeue();
//			heap.modify(2,9);
//			trace(heap.toString());
////			heap.enqueue(9);
//			trace(heap.toString());
			
			heap.dequeue(); 
			heap.dequeue();  
			heap.dequeue();  
			heap.dequeue();  
			heap.dequeue(); 
			heap.dequeue();  
			heap.dequeue();  
			heap.dequeue();
			heap.dequeue();
			
		}
	}
}