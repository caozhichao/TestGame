package test
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import org.aswing.AsWingManager;
	import org.aswing.FlowLayout;
	import org.aswing.JComboBox;
	import org.aswing.JFrame;
	
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-8-8 上午11:27:02
	 * 
	 */
	public class ASWingTest extends Sprite
	{
		public var tf:TextField;
		
		public function ASWingTest()
		{
			super();
			
			tf = new TextField();
			tf.border = true;
			tf.y = 300;
			addChild(tf);
			
			
			AsWingManager.initAsStandard(this);
			var myFrame:Object = new JFrame(this, "My Frame");
			myFrame.getContentPane().setLayout(new FlowLayout());
			
			
			
			var box:JComboBox = new JComboBox([new Sort(1, "a"),
				new Sort(2, "b"),
				new Sort(3, "a"),
				]);
			box.addActionListener(onSelect);
			myFrame.getContentPane().append(box);
			myFrame.setSizeWH(300, 200);
			myFrame.show();
			function onSelect():void
			{
				var index:int = box.getSelectedIndex();
				var item:* = box.getSelectedItem();
				trace(index,item);
				tf.text = "id:" + index + " name:" + item;
			}
		}
	}
}


class Sort
{
	private var _id:int;
	private var _name:String;
	
	
	public function Sort($id:int, $name:String)
	{
		this._id = $id;
		this._name = $name;
	}
	
	public function set id($id:int):void{
		this._id= $id;
	}
	
	public function get id():int{
		return this._id;
	}
	
	
	public function set name($name:String):void{
		this._name = $name;
	}
	
	public function get name():String{
		return this._name;
	}
	
	//注意这里
	public function toString():String{
		return this._name;
	}
}
