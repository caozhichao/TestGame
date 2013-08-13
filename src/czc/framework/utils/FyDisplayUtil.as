package czc.framework.utils {
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.Shape;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.filters.ColorMatrixFilter;
    import flash.text.TextField;

	/**
	 * 显示通用类
	 * @author fireyang
	 */
	public class FyDisplayUtil {
		private static const matrix : Array = [0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0.3086, 0.6094, 0.0820, 0, 0, 0, 0, 0, 1, 0];
		// 初始化一个ColorMatrixFilter对象(matrix作为参数)
		public static const GRAY_FILTER : ColorMatrixFilter = new ColorMatrixFilter(matrix);

		public static function bgWithCache(display : Sprite) : void {
			if (display) {
				// display.cacheAsBitmap = true;
				// display.mouseChildren = false;
				// display.mouseEnabled = false;
			}
		}

		public static function removeSelf(display : DisplayObject) : Boolean {
			if (display && display.parent) {
				display.parent.removeChild(display);
				return true;
			}
			return false;
		}

		/**
		 * 获取形状
		 */
		public static function getRectShape(w : int, h : int, color : uint = 0) : Shape {
			var sp : Shape = new Shape();
			sp.graphics.beginFill(color);
			sp.graphics.drawRect(0, 0, w, h);
			sp.graphics.endFill();
			return sp;
		}

		public static function setTextFieldValue(tf : TextField, str : String) : void {
			if (tf && str) {
				// var format =
				tf.text = str;
			}
		}

		public static function isChild(parent : DisplayObjectContainer, child : DisplayObject) : Boolean {
			if (parent == null || child == null) {
				return false;
			}
			var p : DisplayObject = child;
			while (p.parent) {
				if (p.parent == parent) {
					return true;
				} else {
					p = p.parent;
				}
			}
			return false;
		}

		public static function removeAllChild(displayObj : DisplayObjectContainer) : void {
			if (displayObj == null) {
				return;
			}
            if(displayObj.hasOwnProperty("removeChildren")){
                //flashplayer 11支持
                displayObj.removeChildren();
            }else{
			// try {
                while (displayObj.numChildren > 0) {
                    var child : DisplayObject = displayObj.getChildAt(0);
                    if (child is DisplayObjectContainer) {
                        if (child is MovieClip) {
                            (child as MovieClip).stop();
                        }
                        //removeAllChild(child as DisplayObjectContainer);
                    }
                    if (child.parent) {
                        child.parent.removeChild(child);
                    }
                }
            }
			// } catch(error : Error) {
			// trace("error:", error);
			// }
		}
		
		public static function setBtnEnabled(btn:SimpleButton,enabled:Boolean):void
		{
			btn.mouseEnabled = enabled;
			btn.filters = enabled?null:[FyDisplayUtil.GRAY_FILTER];
		}
    }
}
