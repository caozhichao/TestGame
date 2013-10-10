package
{
	import com.bit101.components.FPSMeter;
	import com.demonsters.debugger.MonsterDebugger;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.profiler.showRedrawRegions;
	
	import child.zp.zp;
	
	import czc.framework.GameContext;
	
	import test.EmbedTest;
	import test.FontTest;
	import test.KeyboardEventTest;
	import test.NewAStarTest;
	import test.RobotlegsTest;
	import test.ScrollTest;
	import test.Test;
	import test.Test2;
	import test.TestTimer;
	import test.TweenLiteTest;
	import test.WindowScrollTest;

	/**
	 * 
	 * @author ZhiChaoCao
	 * 
	 */	
	[SWF(width="800",height="600")]
	public class TestGame extends zp
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
			startGame();
			FPS();
			MonsterDebugger.initialize(this);
			MonsterDebugger.trace(this, "Hello World!");
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
