package test {
    import flash.utils.Dictionary;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.display.BitmapData;

    /**
     * @author fireyang
     */
    public class MapMaskHelper {
        private static const RADIUS : int = 150;
        private static const SMOOTH_LEN : int = 200;
        private static const HALF_SIZE : int = RADIUS + SMOOTH_LEN;
        private static const SIZE : int = HALF_SIZE * 2;
        private static var _maskSource : BitmapData;
        public static var alphaList : Array;
        private static const MASK_WIDTH : int = 80;
        private var _showBD : BitmapData;
        private var _maskBD : BitmapData;
        private var _maskRect : Rectangle;
        private var _oldY : int;
        private var _oldX : int;
        private var _dict : Dictionary;

        public static function initAlphaList() : void {
            alphaList = new Array(256);
            var len : uint = 256;
            for (var i : int = 0; i < len; i++) {
                alphaList[i] = (256 - i) << 24;
            }
        }
        initAlphaList();
        /**
         * Construct a <code>MapMaskHelper</code>.
         */
        public function MapMaskHelper() {
            if (_maskSource == null) {
                _maskSource = creatCircleMask(RADIUS, SMOOTH_LEN);
            }
            _maskRect = new Rectangle(0, 0, SIZE, SIZE);
        }

        public function setDB(dict : Dictionary, maskDb : BitmapData, showDb : BitmapData) : void {
            reset();
            _dict = dict;
            _maskBD = maskDb;
            _showBD = showDb;
            initShowDB();
            _oldX = -1;
            _oldY = -1;
        }

        private function initShowDB() : void {
            var pos : Point = new Point();
            var rect : Rectangle = new Rectangle(0, 0, _maskBD.width, _maskBD.height);
            _showBD.paletteMap(_maskBD, rect, pos, null, null, null, alphaList);
        }

        public function reset() : void {
            _dict = null;
            _maskBD = null;
            _showBD = null;
        }

        public function move(x : int, y : int) : Boolean {
            if (_maskBD && _showBD) {
                var w : int = MASK_WIDTH;
                var gX : int = x / w;
                var gY : int = y / w;
                // var ds : int = FyMath.dist(gX, gY, _oldX, _oldY);
                if (_oldX == gX && _oldY == gY) {
                    return false;
                }
                _oldX = gX;
                _oldY = gY;
                var key : String = gX + "-" + gY;
                if (_dict[key] == null) {
                    _dict[key] = true;
                    mix(gX * w, gY * w);
                }
                return true;
            }
            return false;
        }

        private function mix(x : int, y : int) : void {
            var pos : Point = new Point(x - HALF_SIZE, y - HALF_SIZE);
            _maskRect.x = 0;
            _maskRect.y = 0;
            _maskBD.copyPixels(_maskSource, _maskRect, pos, null, null, true);
            _maskRect.x = pos.x;
            _maskRect.y = pos.y;
            _showBD.paletteMap(_maskBD, _maskRect, pos, null, null, null, alphaList);
        }

        /**
         * 创建遮罩区域
         */
        private function creatCircleMask(radius : int, smooth : int) : BitmapData {
            var len : int = radius + smooth;
            var len2 : int = len * 2;
            var bd : BitmapData = new BitmapData(len2, len2, true, 0);
            bd.lock();
            var radiusD : int = radius * radius;
            var lenD : int = len * len;
            var ditD : int = lenD - radiusD;
            var color : uint;
            var change : Boolean;
            for (var x : int = 0; x < len2; x++) {
                for (var y : int = 0; y < len2; y++) {
                    var ds : int = (x - len) * (x - len) + (y - len) * (y - len);
                    change = false;
                    if (ds <= radiusD) {
                        color = 0xff000000;
                        change = true;
                    } else if (ds < lenD) {
                        var d : uint = 0xff * (ditD - ds + radiusD) / ditD;
                        color = uint(d << 24);
                        // trace(x, y, d, color.toString(16));
                        change = true;
                    }
                    if (change) {
                        bd.setPixel32(x, y, color);
                    }
                }
            }
            bd.unlock();
            return bd;
        }

        public function dispose() : void {
            reset();
        }
    }
}
