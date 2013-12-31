package test.stage3d
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-12-30 上午11:14:52
	 * 
	 */
	public class Stage3dTest extends Sprite
	{

		private var stage3d:Stage3D;

		private var context3d:Context3D;
		public function Stage3dTest()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE,onStage);
		}
		
		protected function onStage(event:Event):void
		{
			if(stage.stage3Ds.length > 0)
			{
				stage3d = stage.stage3Ds[0];
				stage3d.addEventListener(Event.CONTEXT3D_CREATE,onCreateContext3d);
				stage3d.addEventListener(ErrorEvent.ERROR,onCreateError);
				stage3d.requestContext3D();
			}
		}
		
		protected function onCreateError(event:ErrorEvent):void
		{
			trace("GPU启动失败或设备丢失!");
		}
		
		protected function onStageClick(event:MouseEvent):void
		{
			context3d.dispose();
		}
		
		protected function onCreateContext3d(event:Event):void
		{
			trace("设备信息:" + stage3d.context3D.driverInfo);
			context3d = stage3d.context3D;
			context3d.configureBackBuffer(300,300,0,true);
//			stage.addEventListener(MouseEvent.CLICK,onStageClick);
//			stage3d.x = 100;
//			stage3d.y = 100;
//			stage3d.visible = false;
			
			//三角形顶点数据 
			var triangleData:Vector.<Number> = Vector.<Number>([
				//  x, y, r, g, b 
				0, 1, 0, 0, 1, 
				1, 0, 0, 1, 0, 
				0, 0, 1, 0, 0
			]); 
			trace(triangleData.length);
			var vertexBuffer3D:VertexBuffer3D = context3d.createVertexBuffer(3,5);
			vertexBuffer3D.uploadFromVector(triangleData,0,3);
			
			//三角形索引数据 
			var indexData:Vector.<uint> = Vector.<uint>([
				0, 1, 2
			]); 
			var indexBuffer3D:IndexBuffer3D = context3d.createIndexBuffer(indexData.length);
			indexBuffer3D.uploadFromVector(indexData,0,indexData.length);
			
			//AGAL 
			var vagalcode:String = "mov op, va0\n" + "mov v0, va1"; 
			var vagal:AGALMiniAssembler = new AGALMiniAssembler(); 
			vagal.assemble( Context3DProgramType.VERTEX, vagalcode ); 
			
			var fagalcode:String = "mov oc, v0"; 
			var fagal:AGALMiniAssembler = new AGALMiniAssembler(); 
			fagal.assemble( Context3DProgramType.FRAGMENT, fagalcode ); 
			
			var program3D:Program3D = context3d.createProgram(); 
			program3D.upload( vagal.agalcode, fagal.agalcode ); 
			
			this.context3d.clear( 0, 0, 0); 
			this.context3d.setVertexBufferAt( 0, vertexBuffer3D, 0, Context3DVertexBufferFormat.FLOAT_2 ); 
			this.context3d.setVertexBufferAt( 1, vertexBuffer3D, 2, Context3DVertexBufferFormat.FLOAT_3 ); 
			this.context3d.setProgram(program3D ); 
			this.context3d.drawTriangles(indexBuffer3D); 
			this.context3d.present(); 
		}
		
	}
}