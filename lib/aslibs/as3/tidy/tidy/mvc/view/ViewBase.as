package tidy.mvc.view {
	import app.helpers.Debug;

	import tidy.mvc.helper.TypographyBase;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author michaelforrest
	 */
	public class ViewBase extends LoadsAnImageView {
		public function ViewBase(options : Object = null) {
			super(options);
		}
		
		protected function beginInvisibleFill(g : Graphics) : void {
			if(Debug.showInvisibleFills()){
				g.beginFill(0.5 * 0xFFFFFF * Math.random(),0.2);
			}else{
				g.beginFill(0,0);
			}
		}

		public function getPosition() : Point {
			return new Point(x,y);
		}

		public function setPosition(...args) : void {
			if(args[0] is Point) {
				var position : Point = args[0] as Point;
				x = position.x;
				y = position.y;
			}else{
				x = args[0];
				y = args[1];
			}
		}

	
		protected function enableAsButton() : void {
			mouseChildren = false;
			buttonMode = true;
			useHandCursor = true;
		}

		public function getBlurBehind(rect : Rectangle) : BitmapData{
			var result : BitmapData  = new BitmapData(rect.width,rect.height,true,0x00000000);
			visible = false;
			var topLeft : Point = localToGlobal(rect.topLeft);
			var matrix : Matrix = new Matrix();
			matrix.translate(-topLeft.x, -topLeft.y);
			result.draw(stage,matrix,null,null,null);
			result.applyFilter(result, result.rect, new Point(0,0), new BlurFilter(30,30,2) );
			visible = true;
			return result;
		}

		public function adjustStyle(field : TidyTextField, options : Object) : void {
			var style : TypographyBase = field.style;
			for (var i : String in options) {
				style[i] = options[i];
			}
			field.setTextFormat(style.getTextFormat());
			field.defaultTextFormat = style.getTextFormat();
		}
		public function bringToFront(view : DisplayObject) : void {
			if(view.parent!=this) {
				throw(view+ " IS NOT A CHILD OF "+this + "(it is a child of " + view.parent +")");
			}
			swapChildren(view, getChildAt(numChildren-1));
		}
		public function fit(v : Number, low : Number, high : Number) : Number {
			var result : Number = (v - low) / (high - low);
			result = Math.max(0, result);
			result = Math.min(1, result);
			return result;
		}
		
	}
}
