package test.starlingtest
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-11-28 下午1:38:14
	 * 
	 */
	public class StarlingGame2 extends Sprite
	{
		[Embed(source="../../assets/3.png")]
		private var Person:Class;
		public function StarlingGame2()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,onStage);
		}
		
		private function onStage(evt:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onStage);
			var texture:Texture = Texture.fromEmbeddedAsset(Person);
			var image:Image = new Image(texture);
			addChild(image);
		}
	}
}