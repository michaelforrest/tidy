package tidy.mvc.view {
	import tidy.mvc.view.AnimatableView;

	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author michaelforrest
	 */
	public class DraggableView extends AnimatableView {
		private var clickedPoint : Point;
		
		private var __anchor: Point = new Point(0, 0);

		public function get anchor():Point{
			return __anchor;
		}
		public function set anchor(v : Point):void{
			__anchor = v;
		}
		public function DraggableView(options : Object = null) {
			super(options);
		}
		override public function startDrag(lockCenter : Boolean = false, bounds : Rectangle = null) : void {
			clickedPoint = new Point(mouseX,mouseY).subtract(anchor);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, doDrag);
		}
		
		private function doDrag(event : MouseEvent) : void {
			x = parent.mouseX - clickedPoint.x - anchor.x;
			y = parent.mouseY - clickedPoint.y - anchor.y;
			event.updateAfterEvent();
		}

		override public function stopDrag() : void {
			if(!stage) return;
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, doDrag);
			
		}
	}
}
