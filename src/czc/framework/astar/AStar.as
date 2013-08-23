package czc.framework.astar
{
	import flash.utils.getTimer;
	
	import czc.framework.ds.Heap;

	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-22 下午3:48:18
	 * 
	 */
	public class AStar
	{
		//横或竖向移动一格的路径评分
		private const COST_STRAIGHT : int = 10;
		//斜向移动一格的路径评分
		private const COST_DIAGONAL : int = 14;
		//当前A*地图
		private var map:Map;
		//待查询列表
		private var _openList:Array;
		//关闭列表
		private var _closeList:Array;
		//开放列表的下标
		private var _openIndex:int;
		
		private var _openListheap:Heap;
		
		public function AStar()
		{
			
		}
		public function setMaps(mapData:Array,mapW:int,mapH:int):void
		{
			map = new Map(mapData,mapW,mapH);
		}
		public function find(startX:int,startY:int,endX:int,endY:int):Array
		{
			var t:Number = getTimer();
			map.reset();
			function compare(a:Node,b:Node):int
			{
				return b.f - a.f;
			}
			_openListheap = new Heap(compare);
//			trace(getTimer() - t);
			_openList = [];
			_closeList = [];
			_openIndex = 0;
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
			t = getTimer();
			while(_openIndex > 0)
			{
//				_openList.sortOn("f",Array.NUMERIC);
				curNode = openListShift();
				curX = curNode.x;
				curY = curNode.y;
				//加入关闭列表
				add2CloseList(curNode);
				//如果终点被放入关闭列表寻路结束，返回路径
				if (curX == endX && curY == endY)
				{
					trace("消耗:" + (getTimer() - t));
					return getPath(curNode);
				}
				//查找当前节点的8个方向的节点
				point8 = get8Point(curX,curY);
				
				for each (var n:Node in point8) 
				{
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
							}
						} else 
						{
							n.g = g;
							n.f = f;
							n.pNode = curNode;
							add2OpenList(n);
						}
					}
				}
			}
			return null;
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
			var rightUpNode:Node = checkNode(x+1,y-1);
			//右下
			var rightDownNode:Node = checkNode(x+1,y+1);
			//左上
			var leftUpNode:Node = checkNode(x-1,y-1);
			//左下
			var leftDownNode:Node = checkNode(x-1,y+1);
			upNode && arr.push(upNode);
			downNode && arr.push(downNode);
			leftNode && arr.push(leftNode);
			rightNode && arr.push(rightNode);
			rightUpNode && upNode && rightNode && arr.push(rightUpNode);
			rightDownNode && downNode && rightNode && arr.push(rightDownNode);
			leftUpNode && upNode && leftNode && arr.push(leftUpNode);
			leftDownNode && downNode && leftNode && arr.push(leftDownNode);
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
		
		public function add2OpenList(node:Node):void
		{
//			_openList[_openIndex] = node;
			var x:int = node.x;
			var y:int = node.y;
			if(_openList[x] == null)
			{
				_openList[x] = [];
			}
			_openList[x][y] = node;
			
			_openListheap.enqueue(node);
			_openIndex++;
		}
		public function openListShift():Node
		{
			_openIndex--;
//			return _openList.shift();
			return _openListheap.dequeue();
		}
		public function add2CloseList(node:Node):void
		{
			var x:int = node.x;
			var y:int = node.y;
			if(_closeList[x] == null)
			{
				_closeList[x] = [];
			}
			_closeList[x][y] = node;
		}
		
		public function isCloseList(x:int,y:int):Boolean
		{
			return _closeList[x] && _closeList[x][y];
		}
		
		public function isOpenList(x:int,y:int/* node:Node*/):Boolean
		{
//			return _openList.indexOf(node) > -1;
			return _openList[x] && _openList[x][y];
		}
		
		public function getPath(node:Node):Array
		{
			var arr:Array = [];
			var index:int;
			while(node.pNode != null)
			{
				arr.unshift([node.x,node.y]);
				node = node.pNode;
			}
			return arr;
		}
	}
}
class Map
{
	public var mapData:Array;
	public var mapW:int;
	public var mapH:int;
	public var nodeList:Array;
	
	public function Map(mapData:Array,mapW:int,mapH:int)
	{
		this.mapData = mapData;
		this.mapW = mapW;
		this.mapH = mapH;
		this.nodeList = [];
		var node:Node;
		for (var i:int = 0; i < this.mapW; i++) 
		{
			nodeList[i] = [];
			for (var j:int = 0; j < this.mapH; j++) 
			{
				node = new Node();
				node.x = i;
				node.y = j;
				node.walkable = this.mapData[i][j];
				nodeList[i][j] = node;
			}
		}
	}
	
	public function getNode(x:int,y:int):Node
	{
		if(exists(x,y))
		{
			return nodeList[x][y];
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
	
	/**
	 * 重置地图数据 
	 * 
	 */	
	public function reset():void
	{
		var node:Node;
		for (var i:int = 0; i < this.mapW; i++) 
		{
			for (var j:int = 0; j < this.mapH; j++) 
			{
				node = nodeList[i][j];
				node.g = 0;
				node.f = 0;
				node.pNode = null;
			}
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