package czc.framework.utils {
    /**
     * 分页对象 
     * @author caozhichao
     * 
     */
    public class Pagination {
        // 数据
        private var _items : Array;
        // 当前页(1开始)
        private var _curPage : int;
        // 每页个数
        private var _pageSize : int;
        // 总页数
        private var _countPage : int;
        // 当前选项（0开始）
        private var _curIndex : int;

        public function Pagination(pageSize : int) {
            this._pageSize = pageSize;
            this._curPage = 1;
			_items = [];
        }

        /**
         * 设置分页数据 
         * @param value
         * 
         */
        public function set items(value : Array) : void {
            this._items = value;
            _countPage = pageCount(_items.length);
        }
		
		/**
		 * 获取总页数 
		 * @param len 数据的个数
		 * @return 
		 * 
		 */		
        private function pageCount(len : int) : int {
            var count : int;
            len = (len - 1) / _pageSize;
            if (len < 1) {
                count = 1;
            } else {
                count = len + 1;
            }
            return count;
        }
		
		/**
		 * 根据页码获取数据 
		 * @param pageNum   页码
		 * @return 
		 * 
		 */
		private function getItemsByPage(pageNum : int) : Array {
			var startIndex : int = (pageNum - 1) * _pageSize;
			var maxIndex : int = _items.length;
			return _items.slice(startIndex, Math.min((startIndex + _pageSize), maxIndex));
		}
		
		/**
		 * 当前页 
		 * @return 
		 * 
		 */
		public function get curPageItems() : Array {
			return getItemsByPage(curPage);
		}

		/**
		 * 前一页 
		 * 
		 */		
        public function toPrePage() : void {
            if (_curPage > 1) {
                _curPage--;
            }
        }

		/**
		 * 下一页 
		 * 
		 */		
        public function toNextPage() : void {
            _curPage = Math.min(_curPage + 1, this.countPage);
        }


        public function get allLen() : int {
            return _items == null ? 0 : _items.length;
        }

        /**
         * 总页数 
         * @return 
         * 
         */
        public function get countPage() : int {
            return _countPage;
        }

        /**
         * 当前页码 
         * @return 
         * 
         */
        public function get curPage() : int {
            return _curPage;
        }

        /**
         * 设置当前页 
         * @param value
         * 
         */
        public function set curPage(value : int) : void {
            this._curPage = Math.max(1, value);
        }

        /**
         * 获取页号 
         * @param id
         * @return -1 该数据不存在
         * 
         */
        public function getPageByItem(item:*) : int {
			var index:int = _items.indexOf(item);
			if(index != -1)
			{
				return getPageByIndex(index);
			}
            return -1;
        }
		
		/**
		 * 获取页号 
		 * @param elementindex
		 * 
		 */
		public function getPageByIndex(index : int) : int {
			if(index >= 0)
			{
//            return int(index / _pageSize) + 1;
				return pageCount(index + 1);
			}
			return -1;
		}
        /**
         * 选中当前选项,0开始
         */
        public function setCurItem(index : int) : Boolean {
            if (_items && index < _items.length) {
                _curPage = getPageByIndex(index);
                index = index - (_curPage - 1) * _pageSize;
                _curIndex = index;
                return true;
            }
            return false;
        }
		
        /**
         * 是否第一页 
         * @return 
         * 
         */
        public function get isFirstPage() : Boolean {
            var flag : Boolean;
            if (_curPage == 1) {
                flag = true;
            }
            return flag;
        }

        /**
         * 是否最后一页 
         * @return 
         * 
         */
        public function get isEndPage() : Boolean {
            var flag : Boolean;
            if (_curPage == countPage) {
                flag = true;
            }
            return flag;
        }

		/**
		 * 获取页码字符串  
		 * @return 
		 * 
		 */		
        public function get pageStr() : String {
            return _curPage + "/" + _countPage;
        }
		
        public function get pageSize() : int {
            return _pageSize;
        }
		
		public function dispose() : void {
			_items = null;
		}
    }
}