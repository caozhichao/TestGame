package czc.framework.manager
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	import czc.framework.display.IPanel;

	/**
	 * 弹窗管理 
	 * @author caozhichao
	 * 弹窗界面分为  
	 * 居中弹窗(居中显示) 自由弹窗(自由显示)     2大类 
	 * 弹窗必须实现IPanel接口
	 * 弹窗说明:
	 * 
	 * 居中弹窗    存在界面共存   不共存 后面打开的界面替换 前面打开的界面
	 * 自由弹窗    位置自由显示   PopUpManager 会调用IPanel.resize() 更新弹窗的位置
	 *        (自由弹窗和其他弹窗都是共存的)
	 */	
	public class PopUpManager
	{
		public static var instance:PopUpManager = new PopUpManager();
		private var _stage:Stage;
		private var _container:DisplayObjectContainer;
		//当前显示的界面数据
		private var _panels:Array;
		//舞台的尺寸
		private var STAGE_WIDTH:uint;
		private var STAGE_HEIGHT:uint;
		//显示对象位置是否发生改变
		private var _changed:Boolean = false;
		//界面之间的水平间距
		private static const PANEL_WIDTH_DISTANCE:int = 10;
		private var modalMask:Sprite;
		public function PopUpManager()
		{
			if(instance)
			{
				throw new Error("PopUpManager a single");
			}
			_panels = [];
		}
		public function init(spr:Sprite):void
		{
			_container = spr;
			if(_container.stage)
			{
				initEvent();
			} else 
			{
				_container.addEventListener(Event.ADDED_TO_STAGE,addToStage,false,0,true);
			}
		}
		private function addToStage(evt:Event):void
		{
			_container.removeEventListener(Event.ADDED_TO_STAGE,addToStage);
			
			initEvent();
		}
		
		private function initEvent():void
		{
			_stage = _container.stage;
			_stage.addEventListener(Event.RESIZE,onResize);
			_stage.addEventListener(Event.RENDER,onRender);
			onResize(null);
		}
		
		private function onResize(evt:Event):void
		{
			STAGE_WIDTH = _stage.stageWidth;
			STAGE_HEIGHT = _stage.stageHeight;
			if(evt != null)
			{
				setChanged();
			}
		}
		private function setChanged():void
		{
			_changed = true;
			_stage.invalidate();
		}
		
		private function onRender(evt:Event):void
		{
			if(_changed)
			{
				_changed = false;
				setPosition();
			}
		}
		
		/**
		 * 显示弹窗界面 
		 * @param panel
		 * @param isCenter
		 * 
		 */		
		public function showPanel(panel:IPanel,isCenter:Boolean=true,modal:Boolean=false):void
		{
			if(panelExists(panel) == -1)
			{
				var index:int = _panels.length;
				_panels[index] = getPanelVo(panel,index,isCenter,modal);
				addPanel(panel,modal);
//				setChanged(); //有明显延迟现象
				setPosition();
			} else 
			{   //重复添加则删除
				removePanel(panel);
			}
		}
		private function addPanel(panel:IPanel,modal:Boolean):void
		{
			_container.addChild(panel.content);
			setModal(modal);
		}
		private function setModal(modal:Boolean):void
		{
			if(modal)
			{
				if(modalMask == null)
				{
					modalMask = new Sprite();
					modalMask.graphics.beginFill(0x0);
					modalMask.graphics.drawRect(0,0,STAGE_WIDTH,STAGE_HEIGHT);
					modalMask.graphics.endFill();
				}
				if(modalMask.width != STAGE_WIDTH)
				{
					modalMask.width = STAGE_WIDTH;
				}
				if(modalMask.height != STAGE_HEIGHT)
				{
					modalMask.height = STAGE_HEIGHT;
				}
				if(!_container.contains(modalMask))
				{
					_container.addChildAt(modalMask,0);
				}
			}
		}
		
		/**
		 * 界面是否存在 
		 * @param panel
		 * @return 
		 * 
		 */		
		private function panelExists(panel:IPanel):int
		{
			var index:int = 0;
			var len:int = _panels.length;
			var panelVo:PanelVo;
			while(index < len)
			{
				panelVo = _panels[index];
				if(panelVo.panel == panel)
				{
					return index;
				}
				index++;
			}
			return -1;
		}
		
		private function getPanelVo(panel:IPanel,index:int,isCenter:Boolean,modal:Boolean):PanelVo
		{
			var panelVo:PanelVo = new PanelVo();
			panelVo.panel = panel;
			panelVo.index = index;
			panelVo.isCenter = isCenter;
			panelVo.modal = modal;
			return panelVo;
		}
		
		
		/**
		 * 设置界面位置 
		 * 
		 */		
		private function setPosition():void
		{
			var len:int = _panels.length;
			if(len > 0)
			{
				var index:int;
				var panelVo:PanelVo;
				var centerPanels:Array = [];
				while(index < len)
				{
					panelVo = _panels[index];
					if(panelVo.isCenter)
					{ //获取所有需要居中的界面 共存的
						centerPanels[centerPanels.length] = panelVo;
					} else 
					{// 自由弹窗
						panelVo.panel.resize(STAGE_WIDTH,STAGE_HEIGHT);
					}
					index++;
				}
				//处理居中的界面
				setCenter(centerPanels);
				if(modalMask && _container.contains(modalMask))
				{
					setModal(true);
				}
			}
		}
		
		/**
		 * 设置界面居中 
		 * @param centerPanels
		 * 
		 */		
		private function setCenter(centerPanels:Array):void
		{
			var len:int = centerPanels.length;
			var index:int;
			var totalWidth:int;
			var maxHeight:int;
			
			var panelVo:PanelVo;
			var panel:IPanel;
			//计算居中界面的总宽度，最大高度
			while(index < len)
			{
				panelVo = centerPanels[index];
				panel = panelVo.panel;
				totalWidth += panel.content.width
				maxHeight = panel.content.height > maxHeight?panel.content.height:maxHeight;
				index++;
			}
			
			//界面布局起始点
			var startX:int = (STAGE_WIDTH - totalWidth) >> 1;
			var startY:int = (STAGE_HEIGHT - maxHeight) >> 1;
			
			//设置好界面的位置
			index = 0;
			var tw:int;
			while(index < len)
			{
				panelVo = centerPanels[index];
				panel = panelVo.panel;
				panel.content.x = startX + tw;
				panel.content.y = startY;
				tw += panel.content.width + PANEL_WIDTH_DISTANCE;
				index++;
			}
		}
		
		/**
		 * 删除界面 
		 * @param panel
		 * 
		 */		
		public function removePanel(panel:IPanel):void
		{
			var index:int = panelExists(panel); 
			if( index > -1)
			{
				var panelVo:PanelVo = _panels[index];
				_container.removeChild(panel.content);
				_panels.splice(index,1);
				if(panelVo.modal)
				{
					if(modalMask && modalMask.parent)
					{
						modalMask.parent.removeChild(modalMask);
					}
				}
				setChanged();
			}
		}
		/**
		 * 删除多个界面 
		 * 
		 */		
		public function removePanels(panels:Array):void
		{
			var index:int = 0;
			var len:int = panels.length;
			var panelVo:PanelVo;
			while(index < len)
			{
				panelVo = panels[index];
				removePanel(panelVo.panel);
				len = panels.length;
			}
		}
		
		/**
		 * 界面是否显示 
		 * @param panel
		 * @return 
		 * 
		 */		
		public function hasShowPanel(panel:IPanel):Boolean
		{
			return panelExists(panel) > -1;
		}
		
		public function get panels():Array
		{
			return _panels;
		}
	}
}
import czc.framework.display.IPanel;

class PanelVo
{
	public var panel:IPanel;
	public var isCenter:Boolean;
	//添加该子项的索引位置
	public var index:int;
	public var modal:Boolean;
}