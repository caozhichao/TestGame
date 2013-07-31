package test {
	
	import com.bit101.components.Label;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	
	public class aa extends MovieClip {
		private var loader:Loader;
		private var arr_name:Array = ["buttom_fanhui","buttom_zhishu","buttom_lvyou","buttom_quanguo","buttom_gengduo"];
		private var arr_url:Array = ["1.swf",
			"1.swf",
			"1.swf",
			"1.swf",
			"1.swf"];
		private var move_:Sprite;
		public function aa() {
			//创建按钮监听
//			this.buttom_fanhui.addEventListener(MouseEvent.CLICK,buttom_click);
//			this.buttom_zhishu.addEventListener(MouseEvent.CLICK,buttom_click);
//			this.buttom_lvyou.addEventListener(MouseEvent.CLICK,buttom_click);
//			this.buttom_quanguo.addEventListener(MouseEvent.CLICK,buttom_click);
//			this.buttom_gengduo.addEventListener(MouseEvent.CLICK,buttom_click);
			
			move_ = new Sprite();
			this.addChild(move_);
			stage.addEventListener(MouseEvent.CLICK,buttom_click);
		}                
		
		private function buttom_click(e:MouseEvent):void{
			var nameStr:String = arr_name[int(Math.random() * arr_name.length)];
			for(var i:int=0;i<arr_name.length;i++){
				if(arr_name[i].toString() == nameStr){
					trace(arr_url[i]);
					//loader.removeEventListener(LoadMode.REMOVE, loadRemove);
					loader = null;
					loader = new Loader();
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loaderComplete);
					loader.load(new URLRequest(arr_url[i]));
					break;
				}
			}
		}
		
		
		
		private function loaderComplete(e:Event):void{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loaderComplete);
			this.removeChild(move_);
			this.addChild(move_);
			if(move_.numChildren > 0){
				move_.removeChildAt(0);
			}
			move_.addChild(loader.content);
			move_.y = 490;
			move_.x = 0;
		}
		
	}
	
}

