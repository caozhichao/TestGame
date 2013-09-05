package
{
	import com.bit101.components.FPSMeter;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.profiler.showRedrawRegions;
	
	import czc.framework.GameContext;
	
	import test.ASWingTest;
	import test.DragTest;
	import test.HeapTest;
	import test.LoaderTest;
	import test.MCButtonTest;
	import test.NewAStarTest;
	import test.ReflectionTest;
	import test.RegExpTest;
	import test.ScrollTest;
	import test.Test;
	import test.XMStarTest;

	/**
	 * 
	 * @author ZhiChaoCao
	 * 
	 */	
	[SWF(width="800",height="600")]
	public class TestGame extends NewAStarTest
	{
		private var _context:GameContext;
		
		public function TestGame()
		{
			showRedrawRegions(true);
			addEventListener(Event.ADDED_TO_STAGE,addedToStage,false,0,true);
		}
		
		protected function addedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,addedToStage);
			stage.stageFocusRect = false;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.frameRate = 60;
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
