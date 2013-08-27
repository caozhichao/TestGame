package czc.framework.astar
{
	import flash.utils.getTimer;
	
	import czc.framework.ds.Heap;

	/**
	 * AStar
	 * 二维数组 ->一维数组 
	 * 待查询列表 -> 二叉堆优化	
	 * @author caozhichao
	 * 创建时间：2013-8-22 下午3:48:18
	 * 
	 */
	public class AStar2
	{
		//横或竖向移动一格的路径评分
		private const COST_STRAIGHT : int = 10;
		//斜向移动一格的路径评分
		private const COST_DIAGONAL : int = 14;
		//当前A*地图
		private var map:Map;
		//开放列表
		private var _openList:Array;
		//关闭列表
		private var _closeList:Array;
		//待查询列表的长度
		private var _openListLen:int;
		//待查询列表  二叉堆优化 
		private var _openListheap:Heap;
		
		private var _mapW:int;
		private var _mapH:int;
		
		public function AStar2()
		{
			function compare(a:Node,b:Node):int
			{
				return b.f - a.f;
			}
			_openListheap = new Heap(compare);
		}
		public function setMaps(mapData:Array,mapW:int,mapH:int):void
		{
			_mapW = mapW;
			_mapH = mapH;
			map = new Map(mapData,mapW,mapH);
		}
		/**
		 * 寻路 
		 * @param startX
		 * @param startY
		 * @param endX
		 * @param endY
		 * @return 
		 * 
		 */		
		public function find(startX:int,startY:int,endX:int,endY:int):Array
		{
//			var t:Number = getTimer();
//			map.reset();
			reset();
//			trace(getTimer() - t);
			_openListheap.reset();
			_openList = [];
			_closeList = [];
			_openListLen = 0;
			var node:Node = map.getNode(startX,startY);
			add2OpenList(node);
			//当前查询的节点
			var curNode:Node;
			var curX:int;
			var curY:int;
			//8个方向的点
			var point8:Array;
			var g:int;
			var f:int;
			//当待查询列数据长度  > 0
			while(_openListLen > 0)
			{
				//选取一个f值最小的节点
				curNode = openListShift();
				//打印log 查看 优先选取f值最小的
//				log(_openListheap.heap,curNode);
				curX = curNode.x;
				curY = curNode.y;
				//加入关闭列表
				add2CloseList(curNode);
				//如果终点被放入关闭列表寻路结束，返回路径
				if (curX == endX && curY == endY)
				{
					return getPath(curNode);
				}
				//查找当前节点的8个方向的节点
				point8 = get8Point(curX,curY);
				var p8Index:int = 0;
				var p8Len:int = point8.length;
				var n:Node;
				while(p8Index < p8Len)
//				for each (var n:Node in point8) 
				{
					n = point8[p8Index];
					//计算F和G值      g从起始点的总花费      
					g = curNode.g + ((n.x == curX || n.y == curY) ? COST_STRAIGHT : COST_DIAGONAL);
					f = g + (Math.abs(endX - n.x) + Math.abs(endY - n.y)) * COST_STRAIGHT;
					if(!isCloseList(n.x,n.y))
					{
						if(isOpenList(n.x,n.y))
						{
							if(g < n.g)
							{
								n.g = g;
								n.f = f;
								n.pNode = curNode;
								//修改f之后，更新二叉堆
								_openListheap.modify(n,n);
							}
						} else 
						{
							n.g = g;
							n.f = f;
							n.pNode = curNode;
							add2OpenList(n);
						}
					}
					p8Index++;
				}
			}
			return null;
		}
		
		private function log(arr:Array,curNode:Node):void
		{
			var list:Array = [];
			for each (var node:Node in arr) 
			{
				list.push(node);
			}
			list.sortOn("f",Array.NUMERIC);
			if(list[0])
			{
				trace(curNode.f,list[0].f,curNode.f <= list[0].f);
			}
		}
		
		public function get8Point(x:int,y:int):Array
		{
			var arr:Array = [];
			//上
			var upNode:Node = checkNode(x,y-1);
			//下
			var downNode:Node = checkNode(x,y+1);
			//左
			var leftNode:Node = checkNode(x-1,y);
			//右
			var rightNode:Node = checkNode(x+1,y);
			
			//右上
//			var rightUpNode:Node/* = checkNode(x+1,y-1)*/;
//			//右下
//			var rightDownNode:Node/* = checkNode(x+1,y+1)*/;
			//左上
//			var leftUpNode:Node/* = checkNode(x-1,y-1)*/;
			//左下
//			var leftDownNode:Node/* = checkNode(x-1,y+1)*/;
			upNode && arr.push(upNode);
			downNode && arr.push(downNode);
			leftNode && arr.push(leftNode);
			rightNode && arr.push(rightNode);
			
			if(rightNode && upNode)
			{
				//右上
				var rightUpNode:Node;
				rightUpNode = checkNode(x+1,y-1);
				rightUpNode && arr.push(rightUpNode);
			} 
			if(downNode && rightNode)
			{
				//右下
				var rightDownNode:Node;
				rightDownNode = checkNode(x+1,y+1);
				rightDownNode && arr.push(rightDownNode);
			} 
			if(upNode && leftNode )
			{
				//左上
				var leftUpNode:Node;
				leftUpNode = checkNode(x-1,y-1);
				leftUpNode&& arr.push(leftUpNode);
			}
			if(downNode && leftNode)
			{
				//左下
				var leftDownNode:Node;
				leftDownNode = checkNode(x-1,y+1);
				leftDownNode&& arr.push(leftDownNode);
			}
			return arr;
		}
		
		private function checkNode(x:int,y:int):Node
		{
			var node:Node = map.getNode(x,y);
			if(node && node.walkable)
			{
				return node;
			}
			return null;
		}
		/**
		 * 添加到开放列表中 
		 * @param node
		 * 
		 */		
		public function add2OpenList(node:Node):void
		{
			//记录加入(过)开放列表中节点
			_openList[getIndex(node.x,node.y)]= node;
			//二叉堆
			_openListheap.enqueue(node);
			_openListLen++;
		}
		public function openListShift():Node
		{
			_openListLen--;
			return _openListheap.dequeue();
		}
		/**
		 * 添加到关闭列表中 
		 * @param node
		 * 
		 */		
		public function add2CloseList(node:Node):void
		{
			_closeList[getIndex(node.x,node.y)]= node
		}
		public function isCloseList(x:int,y:int):Boolean
		{
			return _closeList[getIndex(x,y)];
		}
		
		public function isOpenList(x:int,y:int):Boolean
		{
			return 	_openList[getIndex(x,y)];
		}
		/**
		 * 获取路径 
		 * @param node
		 * @return 
		 * 
		 */		
		public function getPath(node:Node):Array
		{
			var path:Array = [];
			var index:int;
			while(node.pNode != null)
			{
//				arr.unshift([node.x,node.y]);
				path[index] = [node.x,node.y];
				node = node.pNode;
				index++;
			}
			return path.reverse();
		}
		/**
		 * 二维坐标转成一维坐标 
		 * @param x
		 * @param y
		 * @return 
		 * 
		 */		
		private function getIndex(x:int,y:int):int
		{
			return x * _mapH + y;
		}
		
		/**
		 * 重置查询过的数据节点 
		 * 
		 */		
		public function reset():void
		{
			var node:Node;
			var len:int;
			if(_openList)
			{
				len = _openList.length;
			}
			var index:int = 0;
			while(index < len)
			{
				node = _openList[index];
				if(node)
				{
					node.g = 0;
					node.f = 0;
					node.pNode = null;
				}
				index++;
			}
		}
	}
}
/**
 * 地图数据排列
 * -------------------->
 * 00 10 20 
 * 01 11 21 
 * 02 12 22
 * 
 *  
 * @author caozhichao
 * 
 */
class Map
{
	public var mapData:Array;
	public var mapW:int;
	public var mapH:int;
	public var nodeList:Vector.<Node>;
	
	public function Map(mapData:Array,mapW:int,mapH:int)
	{
		this.mapData = mapData;
		this.mapW = mapW;
		this.mapH = mapH;
		this.nodeList = new Vector.<Node>();
		var node:Node;
		var index:int;
		for (var i:int = 0; i < this.mapW; i++) 
		{
			for (var j:int = 0; j < this.mapH; j++) 
			{
				node = new Node();
				node.x = i;
				node.y = j;
				node.walkable = this.mapData[i][j];
				nodeList[index] = node;
				index++;
			}
		}
	}
	
	public function getNode(x:int,y:int):Node
	{
		if(exists(x,y))
		{
			return nodeList[getIndex(x,y)];
		}
		return null;
	}
	
	/**
	 * 节点是否存在 
	 * @param x
	 * @param y
	 * @return 
	 * 
	 */	
	private function exists(x:int,y:int):Boolean
	{
		return x >= 0 && x < mapW && y >= 0 && y < mapH;
	}
	
	private function getIndex(x:int,y:int):int
	{
		return x * mapH + y;
	}
	
	/**
	 * 重置地图数据 
	 * 
	 */	
	public function reset():void
	{
		var node:Node;
		var len:int = nodeList.length;
		for (var i:int = 0; i < len; i++) 
		{
			node = nodeList[i];
			node.g = 0;
			node.f = 0;
			node.pNode = null;
		}
	}
	
}
class Node
{
	public var x:int;
	public var y:int;
	public var f:int;
	public var g:int;
	public var walkable:Boolean = true;
	public var pNode:Node;
}