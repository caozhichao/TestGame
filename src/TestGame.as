package
{
	import com.bit101.components.FPSMeter;
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.profiler.showRedrawRegions;
	
	import czc.framework.GameContext;
	
	import test.BMDTest;
	import test.ErlangTest;
	import test.PInPolygonTest;
	import test.away3d.Basic_Stereo;
	import test.away3d.Basic_View;
	import test.away3d.Test3D;
	import test.flare3d.Flare3dTest;
	import test.starlingtest.Demo_Web;
	import test.starlingtest.StarlingTest;

	/**
	 * 
	 * @author ZhiChaoCao
	 * 
	 */	
	[SWF(width="800",height="600",frameRate="60",backgroundColor="0x0")]
	public class TestGame extends Basic_Stereo
	{
		private var _context:GameContext;
		
		public function TestGame()
		{
//			showRedrawRegions(true);
//			addEventListener(Event.ADDED_TO_STAGE,addedToStage,false,0,true);
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
			
//			MonsterDebugger.initialize(this);
//			MonsterDebugger.trace(this, "Hello World!");
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
