package test.starlingtest
{
	import flash.system.Capabilities;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-12-6 上午10:10:36
	 * 
	 */
	public class StarlingRenderTest extends Sprite
	{
		private var _asset:AssetManager;
		
		public function StarlingRenderTest()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,onStage);
		}
		
		private function onStage(evt:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onStage);
			_asset = new AssetManager();
			_asset.verbose = Capabilities.isDebugger;
			_asset.enqueue(EmbeddedAssets);
			function onProgress(value:Number):void
			{
				if(value == 1)
				{
					startGame();
				}
			}
			_asset.loadQueue(onProgress);
		}
		
		private function startGame():void
		{
			trace("资源加载完成...");
			var frames:Vector.<Texture> = _asset.getTextures("1000");
			for (var i:int = 0; i < 800; i++) 
			{
				var mc:MovieClip = new MovieClip(frames, 20);
				mc.x = Math.random() * 600;
				mc.y = Math.random() * 400;
				addChild(mc);
				Starling.juggler.add(mc);
			}
		}
	}
}