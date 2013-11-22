package czc.framework.utils
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * 射线法
	 * 判断点是否与多边行相交
	 * 使用正数坐标点
	 * @author caozhichao
	 * 创建时间：2013-11-22 上午10:09:29
	 * http://wenku.baidu.com/link?url=runtt_15O8_I2p2juLuhxjDrvHgVKfehg5fYMbc_bY80tPRME_nwxE-pdN5BReO-xEwUbzmlWawDLaMlosaBf8_smSfHKJ5UsrKIybgjSd7
	 */
	public class PInPolygon
	{
		public function PInPolygon()
		{
		}
		
		public static function pInPolygon(points:Array,p:Point):Boolean
		{
			//1.判断是否在矩形中
			if(pInRect(points,p))
			{
				//射线法进一步验证
				var firstP:Point = points[0];
				var len:int = points.length;
				var index:int = 0;
				var startP:Point;
				var endP:Point;
				//交点个数
				var num:int;
				while(index < len)
				{
					if(startP == null)
					{
						startP = points[index];
					} else 
					{
						endP = points[index];
						var value:int = isIntersectant(startP,endP,p);
						if(value == 1)
						{
							num++;
						} else if(value == -1)
						{
							return true;
						}
						startP = endP;
					}
					index++;
				}
				//最后一次连线(闭合线检查)
				if(isIntersectant(startP,firstP,p))
				{
					num++;
				}
				//判断奇偶个数
				return num % 2 == 0?false:true;
			}
			return false;
		}
		
		/**
		 * 获取多边形外接矩形 
		 * @param points
		 * @return 
		 * 
		 */		
		private static function getRect(points:Array):Rectangle
		{
			var rect:Rectangle = new Rectangle();
			var len:int = points.length;
			var p:Point;
			p = points[0];
			rect.left = rect.right = p.x;
			rect.top = rect.bottom = p.y;
			for (var i:int = 1; i < len; i++) 
			{
				p = points[i];
				if(p.x < rect.left) rect.left = p.x;
				if(p.x > rect.right) rect.right = p.x;
				if(p.y < rect.top) rect.top = p.y;
				if(p.y > rect.bottom) rect.bottom = p.y;
			}
			return rect;
		}
		
		/**
		 * 点是否在矩形中 
		 * @param points
		 * @param p
		 * @return 
		 * 
		 */		
		private static function pInRect(points:Array,p:Point):Boolean
		{
			//外接矩形
			var rect:Rectangle = getRect(points);
//			trace(rect.topLeft,rect.bottomRight);
			if(p.x >= rect.left && p.x <= rect.right && p.y >= rect.top && p.y <= rect.bottom)
			{
				return true;
			}
			return false;
		}
		
		/**
		 * 由p点向左引射线，判断是否与(startP,endP) 线段相交
		 * @param startP
		 * @param endP
		 * @param p
		 * @return 0(没有相交的点),1(有相交的点),-1(在线上)
		 * 
		 */		
		private static function isIntersectant(startP:Point,endP:Point,p:Point):int
		{
//			trace(startP,endP);
			//上端点
			var upP:Point = getUpPoint(startP,endP);
			//下端点
			var downP:Point = getDownPoint(startP,endP);
			//过滤y轴范围
			if(p.y >= upP.y && p.y <= downP.y)
			{
				//1.忽略水平相交的情况
				if(upP.y == downP.y && upP.y == p.y)
				{
					return 0;
				}
				//计算2条线段的交点  直线方程式(两点式:(x-x1)/(x2-x1)=(y-y1)/(y2-y1))
				var y:int = p.y;
				var x:int = (y- upP.y)/(downP.y-upP.y) * (downP.x-upP.x) + upP.x;
				//在线上
				if(p.x == x && p.y == y)
				{
					return -1;
				} else if(p.x >= x && !(downP.x == x && downP.y == y))
				{ //有交点
					return 1;
				} 
			}
			return 0;
		}
		
		private static function getUpPoint(startP:Point,endP:Point):Point
		{
			return startP.y < endP.y?startP:endP;
		}
		
		private static function getDownPoint(startP:Point,endP:Point):Point
		{
			return startP.y > endP.y?startP:endP;
		}
	}
}