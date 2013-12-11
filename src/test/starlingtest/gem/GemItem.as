package test.starlingtest.gem
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-12-10 上午10:42:33
	 * 
	 */
	public class GemItem extends Sprite
	{
		private var _image:Image;
		private var _container:Sprite
		
		public function GemItem(value:Texture)
		{
			_container = new Sprite();
			_image = new Image(value);
			_image.pivotX = _image.width >> 1;
			_image.pivotY = _image.height >> 1;
			_container.addChild(_image);
			_container.scaleX = _container.scaleY = 0.25;
			_container.x = _container.width >> 1;
			_container.y = _container.height >> 1;
			this.addChild(_container);
		}
		
		public function set skinTexture(value:Texture):void
		{
			_image.texture = value;
		}
	}
}