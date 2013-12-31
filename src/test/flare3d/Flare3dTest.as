package test.flare3d
{
	import flash.display.Sprite;
	
	import flare.basic.Scene3D;
	import flare.primitives.Cube;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-11-8 上午10:56:36
	 * 
	 */
	public class Flare3dTest extends Sprite
	{
		private var scene:Scene3D;
		public function Flare3dTest()
		{
			super();
			scene = new Scene3D( this);
			scene.camera.setPosition( 0, 0, -100);
			scene.camera.lookAt( 0, 0, 0);
			scene.addChild( new Cube() );
		}
	}
}