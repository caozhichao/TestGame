package
{
	import com.bit101.components.FPSMeter;
	import com.bit101.components.Text;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	import czc.framework.GameContext;
	
	import test.BulkLoaderTest;
	import test.ByteArrayTest;
	import test.FZipTest;
	import test.KeyEventTest;
	import test.LoaderMaxTest;
	import test.PNGTest;
	import test.Test;
	import test.Test2;
	import test.TestTimer;
	import test.aa;

	/**
	 * 
	 * @author ZhiChaoCao
	 * 
	 */	
	[SWF(width="800",height="600")]
	public class TestGame extends TestTimer
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
