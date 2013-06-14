package astars
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;

	
	/**
	 * 可优化点
	 * 1.点击不可行的点，不执行寻路计算
	 * 2.多次点击同一个点，只执行一次寻路计算
	 * 3. 
	 * @author caozhichao
	 * 
	 */	
	public class Game extends Sprite
	{
		private var _cellSize:int = 50;
		private var _grid:Grid;
		private var _player:Sprite;
		private var _index:int;
		private var _path:Array;
		
		private var preTime:Number=0;
		
		private var preNode:Node = null;
		
		public function Game()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			makePlayer();
			makeGrid();
			stage.addEventListener(MouseEvent.CLICK, onGridClick);
		}
		
		/**
		 * Creates the player sprite. Just a circle here.
		 */
		private function makePlayer():void
		{
			_player = new Sprite();
			_player.graphics.beginFill(0xff0000);
			_player.graphics.drawRect(0, 0, _cellSize,_cellSize);
			_player.graphics.endFill();
			_player.x = 0;
			_player.y = 0;
			addChild(_player);
		}
		
		/**
		 * Creates a grid with a bunch of random unwalkable nodes.
		 */
		private function makeGrid():void
		{
			_grid = new Grid(8, 6);
			drawGrid();
		}
		
		/**
		 * Draws the given grid, coloring each cell according to its state.
		 */
		private function drawGrid():void
		{
			
			graphics.clear();
			for(var i:int = 0; i < _grid.numCols; i++)
			{
				for(var j:int = 0; j < _grid.numRows; j++)
				{
					var node:Node = _grid.getNode(i, j);
					graphics.lineStyle(0);
					graphics.beginFill(getColor(node));
					graphics.drawRect(i * _cellSize, j * _cellSize, _cellSize, _cellSize);
				}
			}
		}
		
		/**
		 * Determines the color of a given node based on its state.
		 */
		private function getColor(node:Node):uint
		{
			if(!node.walkable) return 0;
			if(node == _grid.startNode) return 0xcccccc;
			if(node == _grid.endNode) return 0xcccccc;
			return 0xffffff;
		}

		/**
		 * Handles the click event on the GridView. Finds the clicked on cell and toggles its walkable state.
		 */
		private function onGridClick(event:MouseEvent):void
		{
			var xpos:int = Math.floor(mouseX / _cellSize);
			var ypos:int = Math.floor(mouseY / _cellSize);
			_grid.setEndNode(xpos, ypos);
			//检测点击区域是否可行
			if(!_grid.endNode.walkable){
				trace("终止点不可行走");
				return;
			}
			if(preTime == 0){
				preTime = getTimer();
			} else {
				trace("getTimer() - preTime:"  + (getTimer() - preTime));
				if((getTimer() - preTime) < 50){
					trace("点击过快");
					return;
				} else {
					preTime = getTimer();
				}
			}
			
			if(preNode == null){
				preNode = _grid.endNode;
			} else {
				
				if(_grid.endNode.x == preNode.x && _grid.endNode.y == preNode.y){
					trace("和上一个终止点相同")
					return;
				} else {
					preNode = _grid.endNode;
				}
			}
			
			
			
			xpos = Math.floor(_player.x / _cellSize);
			ypos = Math.floor(_player.y / _cellSize);
			_grid.setStartNode(xpos, ypos);
			
			drawGrid();
			findPath();
		}
		
		/**
		 * Creates an instance of AStar and uses it to find a path.
		 */
		private function findPath():void
		{
			var astar:AStar = new AStar();
			var startTime:Number = getTimer();
			if(astar.findPath(_grid))
			{	
				trace("time:" + (getTimer() - startTime));
				_path = astar.path;
				_index = 0;
				if(!this.hasEventListener(Event.ENTER_FRAME)){
					addEventListener(Event.ENTER_FRAME, onEnterFrame);
				}  else {
					trace("ENTER_FRAME 已存在");
				}
			}
		}
		
		/**
		 * Finds the next node on the path and eases to it.
		 */
		private function onEnterFrame(event:Event):void
		{
			if(_path == null || _path.length == 0)
			{
				return;
			}
			var node : Node = this._path.shift();
			this._player.x = node.x * _cellSize;
			this._player.y = node.y * _cellSize;
		}
	}
}