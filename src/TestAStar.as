package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import net.eidiot.map.AStar;
	
	import test.map.MapTileModel;
	import test.map.Tile;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	[SWF(width = 520, height = 450, frameRate = 12)]
	
	/**
	 * A* 寻路测试类
	 * 
	 * @author	eidiot (http://eidiot.net)
	 * @version	1.0
	 * @date	070416
	 */	
	public class TestAStar extends Sprite
	{
		//====================================
		//	Member Variables
		//====================================
		private var m_player : Tile;
		private var m_map : Array;
		
		private var m_AStar : AStar;
		private var m_mapTileModel : MapTileModel;
		
		private var m_mapW : int = 50;
		private var m_mapH : int = 40;
		
		private var m_mapX : int = 10;
		private var m_mapY : int = 40;
		
		private var m_m_clogRate : Number = 0.3;
		
		private var m_path : Array;
		private var m_outTxt : TextField;
		//====================================
		//	Constructor
		//====================================
		public function TestAStar()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.doubleClickEnabled = true;
			stage.addEventListener(MouseEvent.DOUBLE_CLICK, resetHandle);
			
			this.m_outTxt = new TextField();
			addChild(this.m_outTxt);
			with (this.m_outTxt)
			{
				x = y = 10;
				selectable = false;
				autoSize = TextFieldAutoSize.LEFT;
			}
			
			this.m_mapTileModel = new MapTileModel();
			this.m_AStar = new AStar(this.m_mapTileModel);
			this.reset();
		}
		//====================================
		//	Private Methods
		//====================================
		private function reset() : void
		{
			var tile : Tile;
			var isClog : Boolean;
			this.m_map = new Array();
			
			for (var i : int = 0; i < m_mapW; i++)
			{
				m_map[i] = new Array();
				for (var j : int = 0; j < m_mapH; j++)
				{
					isClog = Math.random() < 0.3;
					tile = new Tile(isClog ? 0x000000 : 0xCCCCCC);
					tile.addEventListener(MouseEvent.CLICK, clickHandle);
					addChild(tile);
					tile.x = m_mapX + i * 10;
					tile.y = m_mapY + j * 10;
					m_map[i][j] = isClog ? 0 : 1;
				}
			}
			
			m_player = new Tile(0xFF0000);
			addChild(m_player);
			m_player.x = m_mapX;
			m_player.y = m_mapY;
			
			this.m_mapTileModel.map = this.m_map;
			
			output("单击白色方块测试寻路，双击空白区域重排地图");
		}
		
		private function getPoint(p_x : Number, p_y : Number) : Point
		{
			p_x = Math.floor((p_x - this.m_mapX) / 10);
			p_y = Math.floor((p_y - this.m_mapY) / 10);
			return new Point(p_x, p_y);
		}
		
		private function output(p_info : String) : void
		{
			this.m_outTxt.htmlText = "<b><font color='#0000FF' size='16'>A*寻路示例</font></b>\t\t\t" + p_info;
		}
		//====================================
		//	Event Handles
		//====================================
		private function resetHandle(event : MouseEvent) : void
		{
			while (this.numChildren > 1)
			{
				var tile : Tile = this.getChildAt(1) as Tile;
				if (tile.hasEventListener(MouseEvent.CLICK))
				{
					tile.removeEventListener(MouseEvent.CLICK, clickHandle);
				}
				this.removeChild(tile);
			}
			this.reset();
		}
		
		private function clickHandle(event : MouseEvent) : void
		{
			var findPiont : Point = getPoint(this.mouseX, this.mouseY);
			var playerPoint : Point = getPoint(this.m_player.x, this.m_player.y);
			this.m_path = this.m_AStar.find(playerPoint.x, playerPoint.y, findPiont.x, findPiont.y);
			if (this.m_path != null && this.m_path.length > 0)
			{
				output("路径已找到，正在移动");
				this.addEventListener(Event.ENTER_FRAME, enterframeHandle);
			} else
			{
				output("无法到达");
			}
		}
		private function enterframeHandle(event : Event) : void
		{
			if (this.m_path == null || this.m_path.length == 0)
			{
				output("单击白色方块测试寻路，双击空白区域重排地图");
				this.removeEventListener(Event.ENTER_FRAME, enterframeHandle);
				return;
			}
			
			var note : Array = this.m_path.shift() as Array;
			this.m_player.x = this.m_mapX + note[0] * 10;
			this.m_player.y = this.m_mapY + note[1] * 10;
		}
	}
}