package child.zp
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 *		
	 * @author caozhichao
	 * 创建时间：2013-9-27 下午6:12:48
	 * 
	 */
	public class RewardItem
	{
		private var _skin:MovieClip;
		private var _data:RewardItemVo;
		
		public function RewardItem(skin:MovieClip)
		{
			_skin = skin;
			play(1);
		}
		
		/**
		 * 设置奖品对应的数据 
		 * @param rewardItemVo
		 * 
		 */		
		public function setRewardData(rewardItemVo:RewardItemVo):void
		{
			_data = rewardItemVo;
		}
		
		public function play(frameIndex:int):void
		{
			_skin.gotoAndStop(frameIndex);
		}
		
		public function getRewardName():String
		{
			return _data.name;
		}
	}
}