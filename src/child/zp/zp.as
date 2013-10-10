package child.zp
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import czc.framework.manager.TimerManager;
	
	
	/**
	 *
	 * 奖品id定义，1-8   每个奖品 界面区间 45 度
	 * 
	 * @author caozhichao
	 * 创建时间：2013-9-27 下午4:19:08
	 * 
	 */
	public class zp extends Sprite
	{
		[Embed(source="zp_skin.swf",symbol="Skin")]
		public var cla : Class;
		private var _skin:Sprite;
		private var _sendBtn:SimpleButton;
		public static const COUNT:int = 16;
		//16个奖品
		private var rewards:Array;
		//当前停止在那里
		private var curStopIndex:int;
		
		private var timerManager:TimerManager;
		private var _index:int;
		private static const PRE_PLAY_NUM:int = 3;
		private var _curPlayNum:int;
		private var isPlay:Boolean;
		private var isTweenPlay:Boolean;
		private var tweenPlayCount:int;
		private var curTweenPlayNum:int;

		private var serverIndex:int;
		
		
		private var t:int = 30;
		
		public function zp()
		{
			if(stage)
			{
				init();
			} else 
			{
				addEventListener(Event.ADDED_TO_STAGE,onStage,false,0,true);
			}
		}
		
		protected function onStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onStage);
			init();
		}
		
		public function init():void
		{
			stage.frameRate = 30;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			timerManager = TimerManager.instance;
			timerManager.init(stage.frameRate);
			
			_skin = new cla();
			addChild(_skin);
			_sendBtn = _skin.getChildByName("_sendBtn") as SimpleButton;
			_sendBtn.addEventListener(MouseEvent.CLICK,onSend,false,0,true);
			
			//初始随机一个值
			curStopIndex = Math.random() * COUNT;
			curStopIndex = 0;
			_index = curStopIndex;
			
			//初始化奖品
			rewards = [];
			var rewardItem:RewardItem;
			var skin:MovieClip;
			//奖品数据
			var rewardItemVo:RewardItemVo;
			
			for (var i:int = 0; i < COUNT; i++) 
			{
				skin = _skin.getChildByName("_m" + i) as MovieClip;
				rewardItem = new RewardItem(skin);
				//test 构建假的奖品数据，改成你的真实数据
				rewardItemVo = new RewardItemVo();
				rewardItemVo.index = i;
				rewardItemVo.name = "奖品" + i;
				//
				rewardItem.setRewardData(rewardItemVo);
				rewards[i] = rewardItem;
			}
			play(_index,2);
			timerManager.setInterval(tick,t);
		}
		
		private function tick():void
		{
			if(isPlay)
			{
				play(_index,1);
				_index++;
				_index = _index % COUNT;
				play(_index,2);
				if(!isTweenPlay)
				{
					if(_index == curStopIndex)
					{
						_curPlayNum++;
					}
					if(_curPlayNum == PRE_PLAY_NUM)
					{
						isTweenPlay = true;
//						isPlay = false;
					}
				} else 
				{
//					isPlay = false;
					curTweenPlayNum++;
					t += 8;
					timerManager.changeDelay(tick,t);
					
//					timerManager.clearTimer(tick);
//					timerManager.setInterval(tick,timeVO.delay);
					
					if(curTweenPlayNum == tweenPlayCount)
					{
						isPlay = false;
						var mc:RewardItem = rewards[serverIndex];
						curStopIndex = serverIndex;
						trace("恭喜您获得:" + mc.getRewardName());
					}
				}
			}
		}
		
		private function play(index:int,frameIndex:int):void
		{
			var mc:RewardItem = rewards[index];
			mc.play(frameIndex);
		}
		/**
		 * 点击抽奖 
		 * @param event
		 * 
		 */		
		protected function onSend(event:MouseEvent):void
		{
			//请求服务器   告诉客户端中奖的id 
			if(!isPlay)
			{
				t = 30;
				timerManager.changeDelay(tick,t);
				_index = curStopIndex;
				isPlay = true;
				isTweenPlay = false;
				_curPlayNum = 0;
				tweenPlayCount = 0;
				curTweenPlayNum = 0;
				serverIndex = 1;
				
				tweenPlayCount = serverIndex - curStopIndex;
				if(tweenPlayCount < 10)
				{ //加一圈
					tweenPlayCount += COUNT;
				}
			}
		}
	}
}