package test.starlingtest
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	
	import starling.core.Starling;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-11-20 下午1:52:20
	 * 
	 */
	public class StarlingTest extends Sprite
	{
		private var _starling:Starling;
		
		public function StarlingTest()
		{
			super();
			if(stage)
			{
				init();
			} else 
			{
				addEventListener(Event.ADDED_TO_STAGE,onStage,false,0,true);
			}
		}
		
		protected function onStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onStage);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			init();
		}
		
		private function init():void
		{
//			Starling.handleLostContext = true;
			_starling = new Starling(StarlingGame2,stage,null,null,Context3DRenderMode.SOFTWARE);
//			_starling.showStats = true;
			_starling.start();			
		}
	}
}