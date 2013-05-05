package
{
	import com.framework.GameContext;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	/**
	 * 
	 * @author ZhiChaoCao
	 * 
	 */	
	public class TestGame extends Sprite
	{
		private var _context:GameContext;
		
		public function TestGame()
		{
			addEventListener(Event.ADDED_TO_STAGE,addedToStage,false,0,true);
		}
		
		protected function addedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			stage.stageFocusRect = false;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			startGame();
		}
		
		private function startGame():void
		{
			_context = new GameContext(this);
		}
	}
}