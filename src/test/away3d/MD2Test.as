package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	
	import away3d.animators.VertexAnimationSet;
	import away3d.animators.VertexAnimator;
	import away3d.animators.nodes.VertexClipNode;
	import away3d.animators.transitions.CrossfadeTransition;
	import away3d.containers.View3D;
	import away3d.entities.Mesh;
	import away3d.events.AnimationStateEvent;
	import away3d.events.AnimatorEvent;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.library.AssetLibrary;
	import away3d.library.assets.AssetType;
	import away3d.loaders.parsers.MD2Parser;
	import away3d.materials.TextureMaterial;
	import away3d.utils.Cast;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2014-1-10 上午10:01:22
	 * 
	 */
	public class MD2Test extends Sprite
	{
		
		[Embed(source="/../embeds/pknight/pknight.md2", mimeType="application/octet-stream")]
		public static var PKnightModel:Class;
		[Embed(source="/../embeds/floor_diffuse.jpg")]
		public static var FloorDiffuse:Class;
		
		[Embed(source="/../embeds/pknight/pknight1.png")]
		public static var PKnightTexture1:Class;
		
		private var _mesh:Mesh;

		private var _view3d:View3D;
		
		private var _animationSet:VertexAnimationSet;
		
		private var stateTransition:CrossfadeTransition = new CrossfadeTransition(0.5);

		private var vertexAnimator:VertexAnimator;

		private var vertexClipNodes:Array;
		
		public function MD2Test()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,onAddStage);
		}
		
		protected function onAddStage(event:Event):void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			vertexClipNodes = [];
			
			_view3d = new View3D();
			_view3d.camera.position = new Vector3D(100,100,-100);
			_view3d.camera.lookAt(new Vector3D());
			
			addChild(_view3d);
			
			AssetLibrary.loadData(new PKnightModel(), null, null, new MD2Parser());
			AssetLibrary.addEventListener(AssetEvent.ASSET_COMPLETE, onAssetComplete);
			AssetLibrary.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onResourceComplete);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onResourceComplete(evt:LoaderEvent):void
		{
			vertexAnimator = new VertexAnimator(_animationSet);
//			vertexAnimator.addEventListener(AnimatorEvent.START,onCycleComplete);
			//控制动画播放次数
			vertexAnimator.addEventListener(AnimatorEvent.CYCLE_COMPLETE,onTest);
			
			//play specified state
//			vertexAnimator.play(_animationSet.animationNames[int(Math.random()*_animationSet.animationNames.length)], null, Math.random()*1000);
//			vertexAnimator.play(_animationSet.animationNames[int(Math.random()*_animationSet.animationNames.length)], stateTransition, 1);
//			vertexAnimator.playbackSpeed = 1;
//			vertexAnimator.time = 1;
			_mesh.animator = vertexAnimator;
			
			stage.addEventListener(MouseEvent.CLICK,onStageClick);
		}
		
		protected function onStageClick(event:MouseEvent):void
		{
			vertexAnimator.play(_animationSet.animationNames[int(Math.random()*_animationSet.animationNames.length)], null, Math.random()*1000);
			trace("播放动画");
		}
		
		protected function onTest(event:AnimatorEvent):void
		{
			var node:VertexClipNode  = vertexAnimator.activeAnimation as VertexClipNode;
			vertexAnimator.stop();
			trace("播放结束!!!!");
		}
		
		protected function onCycleComplete(event:AnimatorEvent):void
		{
//			vertexAnimator.stop();
			var node:VertexClipNode  = vertexAnimator.activeAnimation as VertexClipNode;
//			node.looping = false;
//			node.addEventListener(AnimationStateEvent.PLAYBACK_COMPLETE,onPlayBack);
		}
		
		protected function onPlayBack(event:AnimationStateEvent):void
		{
			trace("onPlayBack");
			
			if (vertexAnimator.activeState != event.animationState)
				return;
			vertexAnimator.play(null);
			
		}
		
		protected function onEnterFrame(event:Event):void
		{
			_view3d.render();
		}
		
		private function onAssetComplete(event:AssetEvent):void
		{
//			trace(event.asset.assetType);
			if (event.asset.assetType == AssetType.MESH) {
				_mesh = event.asset as Mesh;
				//adjust the ogre mesh
//				_mesh.y = 120;
				_mesh.scale(2);
				_mesh.material = new TextureMaterial(Cast.bitmapTexture(new PKnightTexture1()));
				_view3d.scene.addChild(_mesh);
			} else if (event.asset.assetType == AssetType.ANIMATION_SET) {
				_animationSet = event.asset as VertexAnimationSet;
				trace(_animationSet.animationNames);
			} else if (event.asset.assetType == AssetType.ANIMATION_NODE) {
				var node:VertexClipNode = event.asset as VertexClipNode;
				trace(node.name + "|" + node.frames.length);
//				node.looping = false;
//				node.addEventListener(AnimationStateEvent.PLAYBACK_COMPLETE, onPlaybackComplete);
//				vertexClipNodes.push(node);
				
//				var name:String = event.asset.assetNamespace;
//				node.name = name;
//				node.looping = false;
				
//				if (name == IDLE_NAME || name == WALK_NAME) {
//					node.looping = true;
//				} else {
//					node.looping = false;
//					node.addEventListener(AnimationStateEvent.PLAYBACK_COMPLETE, onPlaybackComplete);
//				}
//				
//				if (name == IDLE_NAME)
//					stop();
			}
		}		
		
		protected function onPlaybackComplete(event:AnimationStateEvent):void
		{
			if (vertexAnimator.activeState != event.animationState)
				return;
			
//			onceAnim = null;
//			
//			animator.play(currentAnim, stateTransition);
//			animator.playbackSpeed = isMoving? movementDirection*(isRunning? RUN_SPEED : WALK_SPEED) : IDLE_SPEED;
		}
	}
}