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
	public class AStar6
	{
		//横或竖向移动一格的路径评分
		private const COST_STRAIGHT : int = 10;
		//斜向移动一格的路径评分
		private const COST_DIAGONAL : int = 14;
		//开放列表
		private var _openList:Array;
		
		//添加到开放列表的节点
		private var _openNodes:Vector.<Node>;
		private var _openNodeIndex:int;
		//关闭列表
		private var _closeList:Array;
		//待查询列表的长度
		private var _openListLen:int;
		//待查询列表  二叉堆优化 
		private var _openListheap:Heap;
		//地图列数
		private var _mapW:int;
		//地图行数
		private var _mapH:int;
		//地图节点 all
		public var nodeList:Vector.<Node>;
		
		public function AStar6()
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
			this.nodeList = new Vector.<Node>();
			var node:Node;
			var index:int;
			for (var i:int = 0; i < this._mapW; i++) 
			{
				for (var j:int = 0; j < this._mapH; j++) 
				{
					node = new Node();
					node.x = i;
					node.y = j;
					node.walkable = mapData[i][j];
					nodeList[index] = node;
					index++;
				}
			}
		}
		
		/**
		 * 获取节点 
		 * @param x
		 * @param y
		 * @return 
		 * 
		 */		
		public function getNode(x:int,y:int):Node
		{
			if(!(x < 0 || x == _mapW || y < 0 || y == _mapH))
			{
				return nodeList[x * _mapH + y];
			}
			return null;
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
			reset();
			_openListheap.reset();
			_openList = [];
			_closeList = [];
			_openNodes = new Vector.<Node>();
			_openNodeIndex = 0;
			_openListLen = 0;
			var node:Node = getNode(startX,startY);
			add2OpenList(node);
			//当前查询的节点
			var curNode:Node;
			var curX:int;
			var curY:int;
			//8个方向的点
			var point8:Array;
			var n:Node;
			var g:int;
			var f:int;
			var tx:int;
			var ty:int;
			var nodeIndex:int;
			//当待查询列数据长度  > 0
//			var t:Number = getTimer();
			while(_openListLen > 0)
			{
				//选取一个f值最小的节点
				_openListLen--;
				curNode = _openListheap.dequeue();
				//打印log 查看 优先选取f值最小的
//				log(_openListheap.heap,curNode);
				curX = curNode.x;
				curY = curNode.y;
				//加入关闭列表
				_closeList[curX * _mapH + curY] = true;
				
				//如果终点被放入关闭列表寻路结束，返回路径
				if (curX == endX && curY == endY)
				{
//					trace(getTimer() - t);
					return getPath(curNode);
				}
				//查找当前节点的8个方向的节点
				point8 = get8Point(curX,curY);
				
				for each (n in point8) 
				{
					tx = endX - n.x;
					ty = endY - n.y;
					nodeIndex = n.x * _mapH + n.y;
					//计算F和G值      g从起始点的总花费      
					g = curNode.g + ((n.x == curX || n.y == curY) ? COST_STRAIGHT : COST_DIAGONAL);
					f = g + ((tx >= 0 ? tx : tx * -1) + (ty >= 0 ? ty : ty * -1)) * COST_STRAIGHT;
					
					if(!_closeList[nodeIndex])
					{
						if(_openList[nodeIndex])
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
			
			upNode && arr.push(upNode);
			downNode && arr.push(downNode);
			leftNode && arr.push(leftNode);
			rightNode && arr.push(rightNode);
			
			if(rightNode || upNode)
			{
				//右上
				var rightUpNode:Node;
				rightUpNode = checkNode(x+1,y-1);
				rightUpNode && arr.push(rightUpNode);
			} 
			if(downNode || rightNode)
			{
				//右下
				var rightDownNode:Node;
				rightDownNode = checkNode(x+1,y+1);
				rightDownNode && arr.push(rightDownNode);
			} 
			if(upNode || leftNode )
			{
				//左上
				var leftUpNode:Node;
				leftUpNode = checkNode(x-1,y-1);
				leftUpNode&& arr.push(leftUpNode);
			}
			if(downNode || leftNode)
			{
				//左下
				var leftDownNode:Node;
				leftDownNode = checkNode(x-1,y+1);
				leftDownNode&& arr.push(leftDownNode);
			}
			return arr;
		}
		
		/**
		 * 检查节点 
		 * @param x
		 * @param y
		 * @return 
		 * 
		 */		
		private function checkNode(x:int,y:int):Node
		{
			var node:Node = getNode(x,y);
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
			_openList[node.x * _mapH + node.y] = true;
			
			_openNodes[_openNodeIndex] = node;
			_openNodeIndex++;
			
			//二叉堆
			_openListheap.enqueue(node);
			_openListLen++;
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
				path[index] = [node.x,node.y];
				node = node.pNode;
				index++;
			}
			return path.reverse();
		}
		
		/**
		 * 重置查询过的数据节点 
		 * 
		 */		
		public function reset():void
		{
			var node:Node;
			var len:int;
			var index:int = 0;
			while(index < _openNodeIndex)
			{
				node = _openNodes[index];
				node.g = 0;
				node.f = 0;
				node.pNode = null;
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
class Node
{
	public var x:int;
	public var y:int;
	public var f:int;
	public var g:int;
	public var walkable:Boolean = true;
	public var pNode:Node;
}