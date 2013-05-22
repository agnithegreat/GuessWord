package starling.extensions
{
    import flash.geom.Point;
    
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.textures.Texture;
    
    /* Usage:
        var gauge:Gauge = new Gauge(texture);
        gauge.ratioV = 0;
        addChild(gauge);

        Starling.juggler.tween(gauge, 1, {ratioV: 1});
    */
	
    public class Gauge extends Sprite
    {
        private var mImage:Image;
        private var mRatioH:Number;
		private var mRatioV:Number;
		private var mHelperPoint:Point = new Point();
        
        public function Gauge(texture:Texture)
        {
			mRatioH = mRatioV = 1.0;
            mImage = new Image(texture);
            addChild(mImage);
        }
        
        private function updateH():void
        {
            mImage.scaleX = mRatioH;
            mHelperPoint.setTo(mRatioH, 0.0);
            mImage.setTexCoords(1, mHelperPoint);
            mHelperPoint.setTo(mRatioH, 1.0);
            mImage.setTexCoords(3, mHelperPoint);
        }
			
        private function updateV():void
        {
            mImage.y = mImage.height / mImage.scaleY * (1 - mRatioV);
            mImage.scaleY = mRatioV;
            mHelperPoint.setTo(0.0, 1 - mRatioV);
            mImage.setTexCoords(0, mHelperPoint);
            mHelperPoint.setTo(1.0, 1 - mRatioV);
            mImage.setTexCoords(1, mHelperPoint);
        }
        
        public function get ratioH():Number
        {
            return mRatioH;
        }
		
        public function set ratioH(value:Number):void 
        {
            mRatioH = Math.max(0.0, Math.min(1.0, value));
            updateH();
        }
		
        public function get ratioV():Number
        {
            return mRatioV;
        }
		
        public function set ratioV(value:Number):void 
        {
            mRatioV = Math.max(0.0, Math.min(1.0, value));
            updateV();
        }
    }
}