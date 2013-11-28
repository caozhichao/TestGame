package
{
	import com.bit101.components.FPSMeter;
	
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.profiler.showRedrawRegions;
	
	import czc.framework.GameContext;
	
	import test.BMDTest;
	import test.ErlangTest;
	import test.PInPolygonTest;
	import test.away3d.Basic_Load3DS;
	import test.away3d.Basic_SkyBox;
	import test.away3d.Basic_SpriteSheetAnimation;
	import test.away3d.Basic_Stereo;
	import test.away3d.Basic_UVAnimation;
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
	public class TestGame extends Test3D
	{
		private var _context:GameContext;
		
		public function TestGame()
		{
//			showRedrawRegions(true);
			addEventListener(Event.ADDED_TO_STAGE,addedToStage,false,0,true);
			setId = 10;
			
		}
		private var id:uint;
		
		public  function set setId(n:uint):void{
			
			id=n;
			
		}
		
		public function get getId():uint{
			
			return id;
			
		}
		

		
		
		protected function addedToStage(event:Event):void
		{
			if(stage)
			{
				if(stage.displayState==StageDisplayState.NORMAL)
				{
					if(StageDisplayState.FULL_SCREEN_INTERACTIVE){
						stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE
					}else{
						stage.displayState = StageDisplayState.FULL_SCREEN;
					}
				}
				else
				{
					stage.displayState = StageDisplayState.NORMAL;
				}
			}
			
			return;
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
