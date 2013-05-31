package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import czc.framework.GameContext;
	
	import test.LocalToGlobalTest;

	/**
	 * 
	 * @author ZhiChaoCao
	 * 
	 */	
	public class TestGame extends LocalToGlobalTest
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
			stage.frameRate = 60;
			startGame();
		}
		
		private function startGame():void
		{
			_context = new GameContext(this);
		}
		
	}
}