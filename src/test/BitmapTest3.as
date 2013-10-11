package test
	
	{
	
	        /**
	
	         * @author saiman
	
	         * 2- 上午1:04
	
	         **/
	
	        import flash.display.Bitmap;
	        import flash.display.BitmapData;
	        import flash.display.Sprite;
	        import flash.events.MouseEvent;
	        import flash.geom.ColorTransform;
	        import flash.geom.Point;
	        import flash.geom.Rectangle;
	
	        
	
	        public class BitmapTest3 extends Sprite
		        {
		
		                private var bitmapData:BitmapData
		
		                
		
		                public function BitmapTest3()
		
		                {
			
			                        super();
									var bmd:BitmapData = new BitmapData(80, 30, false, 0xFF0000);
									var cTransform:ColorTransform = new ColorTransform();
									cTransform.alphaMultiplier = 0.5
										
									var rect:Rectangle = new Rectangle(0, 0, 40, 30);
									bmd.colorTransform(rect, cTransform);
									var bm:Bitmap = new Bitmap(bmd);
									addChild(bm);
									
									
									
									
									return;
									
			                        //绘制一张1000*1000的透明位图
			
			                        bitmapData=new BitmapData(1000,1000,true,0)
			
			                        this.addChild(new Bitmap(bitmapData))
			
			                        this.stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveFunc)
			
			                }
		
		                private function mouseMoveFunc(e:MouseEvent):void
		                {
	                        var bmd:BitmapData = new BitmapData(20,20,false,(Math.random() * 100000000>>0))
	                        bitmapData.copyPixels(bmd,bmd.rect,new Point(mouseX,mouseY))
	                        bitmapData.colorTransform(bitmapData.rect,new ColorTransform(1,1,1,0.9))
			            }
		
		        }
	
	}
