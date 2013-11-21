package test.away3d
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	import away3d.cameras.Camera3D;
	import away3d.containers.View3D;
	import away3d.debug.Trident;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.WireframeSphere;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-11-21 下午2:15:02
	 * 
	 */
	public class Test3D extends Sprite
	{
		private var _view3d:View3D;
		private var _ball:WireframeSphere;

		private var cubeMesh:Mesh;

		private var camera:Camera3D;
		
		public function Test3D()
		{
			super();
			
			_view3d = new View3D();
			_view3d.backgroundColor = 0xffffff;
//			_view3d.width = 400;
//			_view3d.height = 300;
			
			addChild(_view3d);
			trace(_view3d.x,_view3d.y,_view3d.z,_view3d.parent);
			/*
//			_ball= new WireframeSphere(300,10,10,0xff0000,1);
//			_view3d.scene.addChild(_ball);
			*/
			var cube:CubeGeometry = new CubeGeometry(50,50,50);
			var cubeMaterial:ColorMaterial = new ColorMaterial(0xFF0000);
			cubeMesh = new Mesh(cube, cubeMaterial);
			_view3d.scene.addChild(cubeMesh);
//			_view3d.camera.z = 10;
//			_view3d.camera.x
			camera = _view3d.camera;
//			trace("cubeMesh:",cubeMesh.x,cubeMesh.y,cubeMesh.z);
//			trace("camera:",camera.x,camera.y,camera.z);
			_view3d.scene.addChild(new Trident());
			
			camera.position = new Vector3D(0,0,-500);
			_view3d.camera.lookAt(new Vector3D(0, 0, 0));
			addEventListener(Event.ENTER_FRAME, onenterframe);
			
			//3d -> 2d 坐标
			var flash2d:Vector3D = _view3d.project(cubeMesh.position);
			trace(flash2d.x,flash2d.y,flash2d.z);
			//2d -> 3d 
			var away3dPosition:Vector3D = _view3d.unproject(400,300,500);
			trace(away3dPosition.x,away3dPosition.y,away3dPosition.z);
			cubeMesh.x = away3dPosition.x;
			cubeMesh.y = away3dPosition.y;
			cubeMesh.z = away3dPosition.z;
			
			/*
			_view3d.camera.position = new Vector3D(100, 100, -100);
			_view3d.camera.lookAt(new Vector3D(0, 0, 0));//看向原点罗..
			_view3d.scene.addChild(new Trident());
			*/
			
		}
		
		protected function onenterframe(event:Event):void
		{
//			_ball.rotationX++;
//			_ball.rotationY++;
//			_ball.rotationZ++;
//			cubeMesh.z -= 1;
			cubeMesh.rotationX++;
//			cubeMesh.rotationY++;
//			camera.z += 10;
//			trace(camera.z);
			
			_view3d.render();
		}
	}
}