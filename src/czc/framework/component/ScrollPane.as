package  czc.framework.component
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import czc.framework.utils.ClassUtil;
	import czc.framework.vo.ScrollPolicy;
	
	public class ScrollPane extends Sprite
	{
		private var vSkin:ScrollBar;
		private var hSkin:ScrollBar;
		
		private var _upBtn:SimpleButton;
		
		private var _downBtn:SimpleButton;
		
		private var _scrollBtn:MovieClipButtion;
		
		private var _back:Sprite;
		
		
		private var _leftBtn:SimpleButton;
		
		private var _rightBtn:SimpleButton;
		
		private var _horizontalScrollBtn:MovieClipButtion;
		
		private var _horizontalBack:Sprite;
		
		
		private var w:int;
		private var h:int;
		private var target:Sprite;
		private var targetMask:Sprite;
		
		/**垂直滚动的高度 = h - 上下2个按钮的高度*/
		private var scrollHeight:int;
		/**当前滚动块的最大滚动条值*/
		private var scrollBtnMaxHeight:int;
		/**当前滚动块的最小滚动条值*/
		private var scrollBtnMinHeight:int;
		/**滚动的速度*/
		private var _spreed:int = 8;
		/**目标滚动，和 滚动块滚动的比例*/
		private var bt:Number = 0;
		/**目标垂直滚动的最大值*/
		private var targetMaxScrollHeight:int;
		/**目标垂直滚动的最小值*/
		private var targetMinScrollHeight:int = 0;
		/**点击back滚动,记录按钮的鼠标位置*/
		private var mousePositionY:int;
		
		
		private var isListener:Boolean = false;
		
		/**水平滚动快 最大滚动值*/
		private var scrollWidth:Number;
		private var scrollBtnMinWidth:Number;
		private var scrollBtnMaxWidth:Number;
		private var wbt:Number;
		private var targetMinScrollWidth:Number = 0;
		private var targetMaxScrollWidth:Number;
		private var mousePositionX:int;
		
		private static const HORIZONTAL:String = "horizontal";
		private static const VERTICAL:String = "vertical";
		private var scrollBtnType:String;
		
		private var _verticalScrollPolicy:String = ScrollPolicy.ON;
		
		private var _horizontalScrollPolicy:String = ScrollPolicy.OFF;
		
		
		
		
		private var _scrollType:String;
		private var _skinClass:Class;
		public function ScrollPane()
		{
			super();
		}
		/**
		 * 设置组件皮肤 
		 * @param scrollSkin
		 * 
		 */		
		public function init(scrollSkin:Sprite,scrollType:String=ScrollType.VERTICAL):void
		{
			_skinClass = ClassUtil.getClass(scrollSkin);
			_scrollType = scrollType;
			
			if(_scrollType == ScrollType.VERTICAL)
			{
				vSkin = new ScrollBar(new _skinClass());
				vSkin.backHeight = this.h - vSkin.upBtnHeight - vSkin.downBtnHeight;
				vSkin.scrollMax = vSkin.backHeight;
				vSkin.backY = vSkin.upBtnY + vSkin.upBtnHeight;
				vSkin.scrollBtnY = vSkin.backY;
				vSkin.downBtnY = vSkin.backY + vSkin.backHeight;
				scrollBtnMinHeight = this._scrollBtn.y;
				vSkin.scrollMinValue = vSkin.scrollBtnY;
				this.addChild(vSkin.skin);
			}
			
			/*
			if(scrollSkin)
			{
				this.vSkin = scrollSkin;
				this.vSkin.removeChild(this.vSkin._ScrollBtn);
				this._upBtn = this.vSkin._UpBtn;
				this._downBtn = this.vSkin._DownBtn;
				this._scrollBtn = new MovieClipButtion(this.vSkin._ScrollBtn,false);
				this._back = this.vSkin._Back;
			
				this._back.height = this.h - this._upBtn.height - this._downBtn.height;
				this.scrollHeight = this._back.height; //滚动条的最大滚动范围
			
				this.vSkin.addChild(this._scrollBtn);
				_back.y = _upBtn.y + _upBtn.height;
			
				_scrollBtn.y = _back.y;
//				_scrollBtn.x += 4;
				_downBtn.y = _back.y + _back.height;
				this.addChild(this.vSkin);
				scrollBtnMinHeight = this._scrollBtn.y;
				_back.buttonMode = true;
			}
			*/
			
			/**************水平滚动条皮肤设置***************/
			/*
			if(hScrollSkin)
			{
	//			var cla:Class = getDefinitionByName(getQualifiedClassName(scrollSkin)) as Class;
	//			this.horizontalScrollBarSkin = new cla() as MovieClip;
				this.hSkin = hScrollSkin;
				this.hSkin.removeChild(this.hSkin._ScrollBtn);
				this.hSkin.rotation = -90;
				this.hSkin.x = 0;
				this.addChild(hSkin);
				
				this._leftBtn = this.hSkin._UpBtn;
				this._rightBtn = this.hSkin._DownBtn;
				this._horizontalScrollBtn = new MovieClipButtion(this.hSkin._ScrollBtn,false);
				this.hSkin.addChild(this._horizontalScrollBtn);
				this._horizontalBack = this.hSkin._Back;
				this.scrollWidth = this.w - this._leftBtn.height - this._rightBtn.height;
				this._horizontalBack.height = this.scrollWidth;
				_horizontalBack.y = this._leftBtn.y + this._leftBtn.height;
				_horizontalScrollBtn.y = this._horizontalBack.y;
				_horizontalScrollBtn.x = 4;
				_rightBtn.y = _horizontalBack.y + _horizontalBack.height;
				scrollBtnMinWidth = this._horizontalScrollBtn.y;
				
				this._horizontalBack.buttonMode = true;
			}
			
			//添加事件侦听
			addListener();
			*/
		}
		
		private function addListener():void
		{
			isListener = true;
			if(_verticalScrollPolicy == ScrollPolicy.ON)
			{
				_downBtn.addEventListener(MouseEvent.CLICK,downHandler);
				_upBtn.addEventListener(MouseEvent.CLICK,upHandler);
				_scrollBtn.addEventListener(MouseEvent.MOUSE_DOWN,scrollBarMouseDownHandler);
				_back.addEventListener(MouseEvent.CLICK,backHandler);
				this.addEventListener(MouseEvent.MOUSE_WHEEL,wheelHandler);
			}
			
			if(_horizontalScrollPolicy == ScrollPolicy.ON)
			{
				_leftBtn.addEventListener(MouseEvent.CLICK,leftHandler);
				_rightBtn.addEventListener(MouseEvent.CLICK,rightHandler);
				_horizontalBack.addEventListener(MouseEvent.CLICK,horizontalBackHandler);
				_horizontalScrollBtn.addEventListener(MouseEvent.MOUSE_DOWN,scrollBarMouseDownHandler);
			}
		}
		
		/**
		 * 目标垂直滚动 
		 * @param dis
		 * 
		 */		
		private function targetMoveHeight(dis:Number):void
		{
			this.target.y += dis;
			
			if(this.target.y < -targetMaxScrollHeight)
			{
				this.target.y = -targetMaxScrollHeight;
			} else if(this.target.y > 0)
			{
				this.target.y = 0;
			}
		}
		
		/**
		 * 滑块垂直滚动 
		 * @param dis
		 * 
		 */		
		private function scrollBtnMoveHeight(dis:Number):void
		{
			this._scrollBtn.y += dis;
			if(this._scrollBtn.y > this.scrollBtnMinHeight + this.scrollBtnMaxHeight)
			{
				this._scrollBtn.y = this.scrollBtnMinHeight + this.scrollBtnMaxHeight;
			} else if(this._scrollBtn.y < this.scrollBtnMinHeight)
			{
				this._scrollBtn.y = this.scrollBtnMinHeight;
			}
		}
		/**
		 * 上滚 
		 * @param e
		 * 
		 */		
		private function upHandler(e:MouseEvent):void
		{
			moveHeight(this._spreed);
		}
		
		/**
		 * 下滚 
		 * @param e
		 * 
		 */		
		private function downHandler(e:MouseEvent):void
		{
			moveHeight(-this._spreed);
		}
		
		private function scrollBarMouseDownHandler(e:MouseEvent):void
		{
			if(e.currentTarget == _scrollBtn)
			{
				scrollBtnType = VERTICAL;
			} else if(e.currentTarget == _horizontalScrollBtn)
			{
				scrollBtnType = HORIZONTAL;
			}
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
			mousePositionY = this.mouseY;
			mousePositionX = this.mouseX;
		}
		
		private function moveHandler(e:MouseEvent):void
		{
			if(scrollBtnType == VERTICAL)
			{
				var currentMouseY:int = this.mouseY;
				var dis:int = currentMouseY - mousePositionY;
				moveHeight(-dis / bt);
				mousePositionY = currentMouseY;
			} else if(scrollBtnType == HORIZONTAL)
			{
				var currentMouseX:int = this.mouseX;
				var disX:int = currentMouseX - mousePositionX;
				moveWidth(-disX / wbt);
				mousePositionX = currentMouseX;
			}
			
		}
		
		private function mouseUpHandler(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,moveHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP,mouseUpHandler);
		}
		
		private function backHandler(e:MouseEvent):void
		{
			var currentMouseY:int = this.mouseY;
			if(currentMouseY < this._scrollBtn.y)
			{
				moveHeight(this._spreed * 3);
			} else 
			{
				moveHeight(-this._spreed * 3);
			}
		}
		
		private function wheelHandler(e:MouseEvent):void
		{
			if(_verticalScrollPolicy == ScrollPolicy.ON)
			{
				var delta:int = e.delta;
				if(delta > 0)
				{
					moveHeight(this._spreed);
				} else 
				{
					moveHeight(-this._spreed);
				}
			}
		}
		
		/**
		 * 设置滚动条的大小 
		 * height 遮罩的高度
		 * @param width        
		 * @param height
		 * 
		 */		
		public function setSize(width:int,height:int):void
		{
			this.w = width;
			this.h = height;
			createMask();
		}
		
		/**
		 * 设置滚动目标 
		 * @param scrollTarget
		 * 
		 */		
		public function set source(scrollTarget:Sprite):void
		{
			this.target = scrollTarget;
			this.addChildAt(target,0);
		}
		
		/**
		 * 更新滚动条,当前目标改变时候 
		 * 
		 */		
		public function update():void
		{
			this.visible = true;
			this.target.mask = this.targetMask; // 设置遮罩
			
			if(_verticalScrollPolicy == ScrollPolicy.ON)
			{
				this.vSkin.x = this.w;
				var scrollBtnHeight:int = this.h * this.scrollHeight / this.target.height; // 计算滑块的高度
				if(scrollBtnHeight >= this.scrollHeight) // 如果滚动快的高度  >= 滚动的高度，隐藏滚动快 
				{	
					scrollBtnHeight = this.scrollHeight;
					this._scrollBtn.visible = false;
				} else 
				{
					this._scrollBtn.visible = true;
				}
				this._scrollBtn.height = scrollBtnHeight;//设置滑块高度                 
				//计算最大滚动值
				targetMaxScrollHeight = Math.max(0,this.target.height - this.h);
				//计算滑块的最大滚动值
				scrollBtnMaxHeight = this.scrollHeight - scrollBtnHeight;
				//计算目标，和 滑块的 滚动比率	
				bt = scrollBtnMaxHeight / targetMaxScrollHeight; 
				
				//设置滚动的位置,根据目标的位置确定
				var currentTargetY:Number = this.target.y;
				this.target.y = 0;  //重置目标，和 滚动块的y坐标
				this._scrollBtn.y = _back.y;
				moveHeight(currentTargetY);
			} else 
			{
				if(vSkin)
				{
					this.vSkin.visible = false;
				}
			}
			
			
			if(_horizontalScrollPolicy == ScrollPolicy.ON)
			{
				this.hSkin.y = this.h + this.hSkin.height;
				var scrollBtnWidth:Number = this.w * this.scrollWidth / this.target.width;
				
				if(scrollBtnWidth >= this.scrollWidth)
				{
					scrollBtnWidth = this.scrollWidth;
					this._horizontalScrollBtn.visible = false;
				} else 
				{
					this._horizontalScrollBtn.visible = true;
				}
				this._horizontalScrollBtn.height = scrollBtnWidth;
				
				targetMaxScrollWidth = Math.max(0,this.target.width - this.w);
				scrollBtnMaxWidth = this.scrollWidth - scrollBtnWidth;
				wbt = scrollBtnMaxWidth / targetMaxScrollWidth;
			} else 
			{
				if(hSkin)
				{
					this.hSkin.visible = false;
				}
			}
			
		}
		
		/**
		 * 创建设置 
		 * 
		 */		
		private function createMask():void
		{
			targetMask = new Sprite();
			targetMask.graphics.beginFill(0xff0000,0);
			targetMask.graphics.drawRect(0,0,this.w,this.h);
			targetMask.graphics.endFill();
			targetMask.x = 0;
			targetMask.y = 0;
			this.addChild(targetMask);
			targetMask.mouseEnabled = targetMask.mouseChildren = false;
		}
		
		/**
		 * 设置滚动速度   
		 * @param speed   default 5px
		 * 
		 */		
		public function set speed(speed:int):void
		{
			this.speed = speed;
		}
		
		private function leftHandler(e:MouseEvent):void
		{
			moveWidth(this._spreed);
			
		}
		private function rightHandler(e:MouseEvent):void
		{
			moveWidth(-this._spreed);
		}
		
		private function horizontalBackHandler(e:MouseEvent):void
		{
			
			var currentMouseX:int = this.mouseX;
			if(currentMouseX < this._horizontalScrollBtn.y)
			{
				moveWidth(this._spreed * 3);
			} else 
			{
				moveWidth(-this._spreed * 3);
			}
		
		}
		
		/**
		 * 垂直滚动 
		 * @param moveNum   滚动的值
		 * 
		 */		
		private function moveHeight(moveNum:Number):void
		{
			//目标和滑块滚动的方向是相反的      -
			targetMoveHeight(moveNum);
			scrollBtnMoveHeight(-moveNum * bt);
		}
		
		private function moveWidth(moveNum:Number):void
		{
			targetMoveWidth(moveNum);
			scrollBtnMoveWidht(-moveNum * wbt);
		}
		
		private function targetMoveWidth(dis:Number):void
		{
			this.target.x += dis;
			if(this.target.x < -targetMaxScrollWidth)
			{
				this.target.x = -targetMaxScrollWidth;
			} else if(this.target.x > 0)
			{
				this.target.x = 0;
			}
		}
		
		private function scrollBtnMoveWidht(dis:Number):void
		{
			this._horizontalScrollBtn.y += dis;
			if(this._horizontalScrollBtn.y > this.scrollBtnMinWidth + this.scrollBtnMaxWidth)
			{
				this._horizontalScrollBtn.y = this.scrollBtnMinWidth + this.scrollBtnMaxWidth;
			} else if(this._horizontalScrollBtn.y < this.scrollBtnMinWidth)
			{
				this._horizontalScrollBtn.y = this.scrollBtnMinWidth;
			}
		}
		
		public function set verticalScrollPolicy(value:String):void
		{
			this._verticalScrollPolicy = value;
		}
		
		public function set horizontalScrollPolicy(value:String):void
		{
			this._horizontalScrollPolicy = value;
		}
		
		public function dispose():void
		{
			if(isListener)
			{
				isListener = false;
				_downBtn.removeEventListener(MouseEvent.CLICK,downHandler);
				_upBtn.removeEventListener(MouseEvent.CLICK,upHandler);
				_scrollBtn.removeEventListener(MouseEvent.MOUSE_DOWN,scrollBarMouseDownHandler);
				_back.removeEventListener(MouseEvent.CLICK,backHandler);
				this.removeEventListener(MouseEvent.MOUSE_WHEEL,wheelHandler);
			}
		}
		
		/**
		 * 滚动到最下面 
		 * 
		 */		
		public function scrollVMax():void
		{
			moveHeight(-scrollBtnMaxHeight);
		}
	}
}
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;

import czc.framework.utils.Reflection;

class ScrollBar
{
	private var _skin:Sprite;
	public var _UpBtn:SimpleButton;
	public var _ScrollBtn:MovieClip;
	public var _Back:MovieClip;
	public var _DownBtn:SimpleButton;
	//滚动条的最大滚动范围
	private var _scrollMaxValue:int;
	//最小滚动值
	private var _scrollMinValue:int;
	
	public function ScrollBar(skin:Sprite):void
	{
		_skin = skin;
		Reflection.reflection(this,_skin);
		_Back.buttonMode = true;
	}
	
	private function addListener():void
	{
		_DownBtn.addEventListener(MouseEvent.CLICK,downHandler);
		_UpBtn.addEventListener(MouseEvent.CLICK,upHandler);
		_ScrollBtn.addEventListener(MouseEvent.MOUSE_DOWN,scrollBarMouseDownHandler);
		_Back.addEventListener(MouseEvent.CLICK,backHandler);
		_skin.addEventListener(MouseEvent.MOUSE_WHEEL,wheelHandler);
	}
	
	protected function wheelHandler(event:MouseEvent):void
	{
		// TODO Auto-generated method stub
		
	}
	
	protected function backHandler(event:MouseEvent):void
	{
		// TODO Auto-generated method stub
		
	}
	
	protected function scrollBarMouseDownHandler(event:MouseEvent):void
	{
		// TODO Auto-generated method stub
		
	}
	
	protected function upHandler(event:MouseEvent):void
	{
		// TODO Auto-generated method stub
		
	}
	
	protected function downHandler(event:MouseEvent):void
	{
		// TODO Auto-generated method stub
		
	}	
	
	public function set downBtnY(value:int):void
	{
		_DownBtn.y = value;
	}
	public function set scrollBtnY(value:int):void
	{
		_ScrollBtn.y = value;
	}
	public function get scrollBtnY():int
	{
		return _ScrollBtn.y;
	}
	
	public function set backY(value:int):void
	{
		_Back.y = value;
	}
	public function get backY():int
	{
		return _Back.y;
	}
	
	public function get upBtnY():int
	{
		return _UpBtn.y;
	}
	public function get upBtnHeight():int
	{
		return _UpBtn.height;
	}
	
	public function get downBtnHeight():int
	{
		return _DownBtn.height;
	}
	
	public function set backHeight(value:int):void
	{
		this._Back.height = value;
	}
	public function get backHeight():int
	{
		return _Back.height;
	}
	public function set scrollMax(value:int):void
	{
		_scrollMaxValue = value;
	}
	public function get scrollMax():int
	{
		return _scrollMaxValue;
	}
	
	public function set x(value:int):void
	{
		_skin.x = value;
	}
	public function get x():int
	{
		return _skin.x;
	}
	public function set y(value:int):void
	{
		_skin.y = value;
	}
	public function get y():int
	{
		return _skin.y;
	}
	
	public function set visible(value:Boolean):void
	{
		_skin.visible = value;	
	}
	
	public function get height():int
	{
		return _skin.height;
	}
	public function get skin():Sprite
	{
		return _skin;
	}

	public function get scrollMinValue():int
	{
		return _scrollMinValue;
	}

	public function set scrollMinValue(value:int):void
	{
		_scrollMinValue = value;
	}

}
