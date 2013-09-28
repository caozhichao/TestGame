package test
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getTimer;
	
	import czc.framework.astar.AStar;
	import czc.framework.astar.AStar2;
	import czc.framework.astar.AStar3;
	import czc.framework.astar.AStar4;
	import czc.framework.astar.AStar5;
	import czc.framework.utils.CopyUtil;
	import czc.framework.vo.Map;
	
	import test.map.Tile;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-22 下午5:44:38
	 * 
	 */
	public class NewAStarTest extends Sprite
	{
		//====================================
		//	Member Variables
		//====================================
		private var m_player : Tile;
		private var m_map : Array;
		
		private var m_AStar : czc.framework.astar.AStar5;
		
		private var m_mapW : int = 40; // 66 40 
		private var m_mapH : int = 28;//100   28
		
		private var m_mapX : int = 10;
		private var m_mapY : int = 40;
		
		private var m_m_clogRate : Number = 0.3;
		
		private var m_path : Array;
		private var m_outTxt : TextField;
		
		private var mapData:Array = [[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,1,1,1,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]];
		private static const TILE_W:int = 10;
		private static const TILE_H:int = 10;
		private var titleArr:Array;
		
		//路径线层
		private var pathLineLayer:Sprite;
		
		
		//====================================
		//	Constructor
		//====================================
		public function NewAStarTest()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.doubleClickEnabled = true;
			stage.addEventListener(MouseEvent.DOUBLE_CLICK, resetHandle);
			
			this.m_outTxt = new TextField();
			addChild(this.m_outTxt);
			
			this.m_outTxt.x = this.m_outTxt.y = 10;
			this.m_outTxt.selectable = false;
			this.m_outTxt.autoSize = TextFieldAutoSize.LEFT;
			
//			with (this.m_outTxt)
//			{
//				x = y = 10;
//				selectable = false;
//				autoSize = TextFieldAutoSize.LEFT;
//			}
			this.m_AStar = new AStar5();
			this.reset();
			pathLineLayer = new Sprite();
			stage.addChild(pathLineLayer);
		}
		//====================================
		//	Private Methods
		//====================================
		private function reset() : void
		{
			titleArr = [];
			var tile : Tile;
			var isClog : Boolean;
			this.m_map = new Array();
			var titleValue:int;
			
			/*
			var hlen:uint = Map.aBigMap[0].length;
			var vlen:uint = Map.aBigMap.length;
			for( i= 0;i<vlen;i++){
				aNodeMap[i] = new Array();
				for(j = 0;j<hlen;j++){
					type = int(Map.aBigMap[i][j]);
					var tile:Tile = Tile.buildTile(type);
					tile.Type = type;
					tile.wIndex = j;
					tile.hIndex = i;
					tile.x = j * Tile.W;
					tile.y = i * Tile.H;
					scene.addChild(tile);
					if(type == Tile.GROUND)
						scene.setChildIndex(tile,0);						
					aNodeMap[i][j] = tile.bBlock?1:0;
				}
			}
			*/
			
			
			var type:int;
			for (var i : int = 0; i < m_mapW; i++)
			{
				m_map[i] = new Array();
				for (var j : int = 0; j < m_mapH; j++)
				{
//					titleValue = mapData[i][j];
					isClog = Math.random() < 0.3;
//					isClog = (titleValue == 1);
					
					type = Map.aBigMap[j][i];
					if(type == 4 || type == 0)
					{
						isClog = 0;
					} else 
					{
						isClog = 1;
					}
					
					tile = new Tile(isClog ? 0x000000 : 0xCCCCCC,TILE_W,TILE_H);
					tile.addEventListener(MouseEvent.CLICK, clickHandle);
					addChild(tile);
					tile.x = m_mapX + i * TILE_W;
					tile.y = m_mapY + j * TILE_H;
					
					m_map[i][j] = isClog ? 0 : 1;
					
					titleArr.push(tile);
				}
			}
			
			m_player = new Tile(0xFF0000,TILE_W,TILE_H);
			addChild(m_player);
			m_player.x = m_mapX * 2;
			m_player.y = m_mapY * 2;
			this.m_AStar.setMaps(m_map,m_mapW,m_mapH);
			
			output("单击白色方块测试寻路，双击空白区域重排地图");
		}
		
		private function getPoint(p_x : Number, p_y : Number) : Point
		{
			p_x = Math.floor((p_x - this.m_mapX) / TILE_W);
			p_y = Math.floor((p_y - this.m_mapY) / TILE_H);
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
			/*
			while (this.numChildren > 0)
			{
				var tile : Tile = this.getChildAt(0) as Tile;
				if (tile && tile.hasEventListener(MouseEvent.CLICK))
				{
					tile.removeEventListener(MouseEvent.CLICK, clickHandle);
					this.removeChild(tile);
				}
			}
			*/
			var len:int = titleArr.length;
			var index:int = 0;
			while(index < len)
			{
				this.removeChild(titleArr[index]);
				index++;
			}
			this.reset();
		}
		
		private function clickHandle(event : MouseEvent) : void
		{
			var findPiont : Point = getPoint(this.mouseX, this.mouseY);
			var playerPoint : Point = getPoint(this.m_player.x, this.m_player.y);
			var t:Number = getTimer();
			this.m_path = this.m_AStar.find(playerPoint.x, playerPoint.y, findPiont.x, findPiont.y);
			if (this.m_path != null && this.m_path.length > 0)
			{
				output("路径已找到，正在移动|寻路时间" + (getTimer() - t));
				this.addEventListener(Event.ENTER_FRAME, enterframeHandle);
				
				
				
				var path:Array = CopyUtil.copy(this.m_path,Array);
				path.unshift([playerPoint.x,playerPoint.y]);
				drawPathLine(path);
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
			this.m_player.x = this.m_mapX + note[0] * TILE_W;
			this.m_player.y = this.m_mapY + note[1] * TILE_H;
		}
		
		/**
		 * 绘制路径线路 
		 * @param path
		 * 
		 */		
		private function drawPathLine(path:Array):void
		{
			var t:Number = getTimer();
			path = optimizePath(path);
			trace("合并路径点耗时:",getTimer() - t);
			
			pathLineLayer.graphics.clear();
			pathLineLayer.graphics.lineStyle(1,0xff0000);
			pathLineLayer.graphics.beginFill(0xff0000);
			var preNode:Array;
			var curNode:Array;
			var p1:Array;
			var p2:Array;
			while(Boolean(curNode = path.shift()))
			{
				if(preNode != null)
				{
					p1 = getNodePoint(preNode);
					p2 = getNodePoint(curNode);
					pathLineLayer.graphics.drawCircle(p1[0],p1[1],2);
					pathLineLayer.graphics.drawCircle(p2[0],p2[1],2);
					pathLineLayer.graphics.moveTo(p1[0],p1[1]);
					pathLineLayer.graphics.lineTo(p2[0],p2[1]);
				} 
				preNode = curNode;	
			}
			pathLineLayer.graphics.endFill();
		}
		
		private function getNodePoint(node:Array):Array
		{
			var px:int = this.m_mapX + node[0] * TILE_W + TILE_W / 2;
			var py:int = this.m_mapY + node[1] * TILE_H + TILE_H / 2;
			return [px,py];
		}
		
		private function optimizePath(path:Array):Array
		{
			var newPath:Array = [];
			var preNode:Array;
			var curNode:Array;
			var curDir:int = -1;
			while(Boolean(curNode = path.shift()))
			{
				if(preNode != null)
				{
					var dir:int = getDir(preNode,curNode);
					if(curDir != dir)
					{
						newPath.push(preNode);
						curDir = dir;
					}
				} 
				preNode = curNode;
			}
			newPath.push(preNode);
			return newPath;
		}
		
		/**
		 * 优化路径点的个数 
		 * @param p1
		 * @param p2
		 * @return 
		 * 
		 */		
		private function getDir(p1:Array,p2:Array):int
		{
			var dir:int = -1;
			var p1x:int = p1[0];
			var p1y:int = p1[1];
			var p2x:int = p2[0];
			var p2y:int = p2[1];
			
			if(p1x == p2x && p2y > p1y)
			{
				dir = 0;
			} else if(p2x < p1x && p2y > p1y)
			{
				dir = 1;
			} else if(p2x < p1x && p2y == p1y)
			{
				dir = 2;
			} else if(p2x < p1x && p2y < p1y)
			{
				dir = 3;
			} else if(p2x == p1x && p2y < p1y)
			{
				dir = 4;
			} else if(p2x > p1x && p2y < p1y)
			{
				dir = 5
			} else if(p2x > p1x && p2y == p1y)
			{
				dir = 6;
			} else if(p2x > p1x && p2y > p1y)
			{
				dir = 7;
			}
			return dir;
		}
		
	}
}