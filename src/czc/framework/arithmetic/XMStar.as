package czc.framework.arithmetic
{
	import czc.framework.utils.FyMath;
	
	/**
	 * 消灭星星算法(简单版)
	 * @author caozhichao
	 * 创建时间：2013-8-22 上午9:48:28
	 * 
	 */
	public class XMStar
	{
		private var _mapData:Array;
		private var _closeList:Array;
		private var openList:Array;
		private var _row:int;
		private var _cols:int;
		public function XMStar(mapData:Array,row:int,cols:int)
		{
			_mapData = mapData;
			_closeList = [];
			_row = row;
			_cols = cols;
		}
		public function find(px:int,py:int):Array
		{
			var typeValue:int = _mapData[px][py];
			openList = [];
			_closeList = [];
			//把要查询的点 放到待查找列表中
			openList.push([px,py]);
			while(openList.length > 0)
			{
				//当前查找的点
				var arr:Array = openList.shift();
				var curX:int = arr[0];
				var curY:int = arr[1];
				if(_closeList[curX] == null)
				{
					_closeList[curX] = [];
				}
				//如果不在关闭列表中   继续查找
				if(!isCloseList(curX,curY))
				{
					//查找后的点记录到关闭列表(不再查找的点)
					_closeList[curX][curY] = [curX,curY];
					//查找上下左右4个点  如果符合把他们放入待查询列表中
					//上
					test(curX,FyMath.rangeInt(curY - 1,0),typeValue);
					//下
					test(curX,FyMath.rangeInt(curY + 1,0,_cols - 1),typeValue);
					//左
					test(FyMath.rangeInt(curX-1,0),curY,typeValue);
					//右
					test(FyMath.rangeInt(curX+1,0,_row - 1),curY,typeValue);
				}
			}
			return _closeList;
		}
		
		/**
		 * 测试查找到的点 是否符合 
		 * @param x
		 * @param y
		 * @param typeValue
		 * 
		 */		
		private function test(x:int,y:int,typeValue:int):void
		{
			if(!isCloseList(x,y) && _mapData[x][y] == typeValue)
			{
				openList.push([x,y]);
			}
		}
		/**
		 * 检查是否在关闭列表中 
		 * @param x
		 * @param y
		 * @param typeValue
		 * 
		 */		
		private function isCloseList(x:int,y:int):Boolean
		{
			return _closeList[x] && _closeList[x][y]; 
		}
	}
}