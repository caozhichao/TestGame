package
{
	import com.bit101.components.FPSMeter;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import czc.framework.GameContext;
	import czc.framework.utils.WindowScroll;
	
	import test.DragTest;
	import test.LoaderTest;
	import test.PanelTest;
	import test.WindowScrollTest;

	/**
	 * 
	 * @author ZhiChaoCao
	 * 
	 */	
	[SWF(width="800",height="600")]
	public class TestGame extends WindowScrollTest
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
			stage.frameRate = 30;
//			startGame();
			FPS();
		}
		
		private function FPS():void
		{
			new FPSMeter(this);
		}
		
		private function startGame():void
		{
			_context = new GameContext(this);
		}
		
	}
}
