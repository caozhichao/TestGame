package test
{
	import com.bit101.components.PushButton;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import test.view.TestView;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-10-8 下午2:26:42
	 * 
	 */
	public class RobotlegsTest extends Sprite
	{

		private var testView:TestView;
		public function RobotlegsTest()
		{
			super();
			var button1:PushButton = new PushButton(this,50,100,"添加界面",onAddView);
			var button2:PushButton = new PushButton(this,100,100,"删除界面",onViewRemoved);
		}
		
		private function onViewRemoved(evt:MouseEvent):void
		{
			this.removeChild(testView);
		}
		
		private function onAddView(evt:MouseEvent):void
		{
//			this.addEventListener(Event.ADDED_TO_STAGE,onViewAdded,true,0,true);
			testView = new TestView();
//			testView.addEventListener(Event.ADDED_TO_STAGE,onViewAdded);
			this.addChild(testView);
		}
		private function onViewAdded(evt:Event):void
		{
			trace("" + evt.target + "|" + evt.eventPhase);
		}
	}
}