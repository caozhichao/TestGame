package czc.framework.component
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class MovieClipButtion extends Sprite
	{
		private var mc:MovieClip;
		//锁定状态  true 锁定  false 未锁定
		private var isLock:Boolean;
		//是否需要锁定
		private var isNeedLock:Boolean;
		public static const MouseDown:String = "down";
		public static const UP:String = "up";
		public static const OVER:String = "over";
		public function MovieClipButtion(mc:MovieClip,isNeedLock:Boolean=true)
		{
			super();
			this.isNeedLock = isNeedLock;
			this.mc = mc;
			this.mc.y = 0;
			this.mc.x = 0;
			this.buttonMode = true;
			this.addChild(mc);
			isLock = true;
			unLock();
		}
		
		private function mouseOverHandler(e:MouseEvent):void
		{
			this.mc.gotoAndStop(OVER);
			this.dispatchEvent(new Event(OVER));
		}
		
		private function mouseOutHandler(e:MouseEvent):void
		{
			this.mc.gotoAndStop(UP);
			this.dispatchEvent(new Event(UP));
		}
		
		public function mousedownHandler(e:MouseEvent):void
		{
			if(isNeedLock)
			{
				lock();
			}
			this.mc.gotoAndStop(MouseDown);
			this.dispatchEvent(new Event(MouseDown));
		}
		
		private function lock():void
		{
			isLock = true;
			this.buttonMode = false;
			removeListener();
		}
		private function removeListener():void
		{
			this.removeEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
			this.removeEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
			this.removeEventListener(MouseEvent.MOUSE_DOWN,mousedownHandler);
		}
		
		public function unLock():void
		{
			if(isLock)
			{
				isLock = false;
				this.buttonMode = true;
				/*
				this.mc.gotoAndStop("up");
				this.dispatchEvent(new Event(UP));
				*/
				mouseOutHandler(null);
				this.addEventListener(MouseEvent.MOUSE_OVER,mouseOverHandler);
				this.addEventListener(MouseEvent.MOUSE_OUT,mouseOutHandler);
				this.addEventListener(MouseEvent.MOUSE_DOWN,mousedownHandler);
			}
		}
		
		public function dispose():void
		{
			if(!isLock)
			{
				removeListener();
			}
		}
		
		override public function set height(value:Number):void
		{
			this.mc.height = value;
		}
		
		public function get labelTextField():TextField
		{
			var labelTF:TextField;
			var label:DisplayObject = mc.getChildByName("_label");
			if(label is Sprite)
			{
				var labelSpr:Sprite = label as Sprite;
				labelSpr.mouseEnabled = false;
				labelSpr.mouseChildren = false;
				labelTF = labelSpr.getChildAt(0) as TextField;
			} else if(label is TextField)
			{
				labelTF = label as TextField;
			}
//			var labelTF:TextField = mc.getChildByName("_label") as TextField;
			labelTF.mouseEnabled = false;
			return labelTF;
		}
	}
}