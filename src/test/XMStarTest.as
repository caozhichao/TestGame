package test
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import czc.framework.arithmetic.XMStar;
	
	import test.map.Tile;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-22 上午9:54:14
	 * 
	 */
	public class XMStarTest extends Sprite
	{
		private static const TILE_W:int = 20;
		private static const TILE_H:int = 20;

		private var xmStar:XMStar;
		
		private var row:int = 10;
		private var cols:int = 10;
		public function XMStarTest()
		{
			super();
			var maps:Array = [];
			var tile:Tile;
			for (var i:int = 0; i < row; i++) 
			{
				maps[i] = [];
				for (var j:int = 0; j < cols; j++) 
				{
					var type:int = Math.random() * 2;
					type = 1;
					maps[i][j] = type;
					tile = new Tile(type ? 0x000000 : 0xCCCCCC,TILE_W,TILE_H);
					tile.x = i * TILE_W;
					tile.y = j * TILE_H;
					addChild(tile);
				}
			}
			trace(maps);
			xmStar = new XMStar(maps,row,cols);
			addEventListener(MouseEvent.CLICK,onClick);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			var t:Number = getTimer();
			var p_x:int = Math.floor(this.mouseX / TILE_W);
			var p_y:int = Math.floor(this.mouseY  / TILE_H);
			var list:Array = xmStar.find(p_x,p_y);
			trace(list,"耗时:" + (getTimer() - t));
		}
	}
}