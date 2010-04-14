package tidy.mvc.view {
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.ui.Keyboard;

	/**
	 * @author michaelforrest
	 */
	public class ExplodableView extends DraggableView {
		
		private var annotation : DisplayObject;
		private static var explodedViews : Array;
		private var debugOriginalY : Number = 0;
		private var debugOutline : Shape;

		public function ExplodableView(options : Object = null) {
			super(options);
			addEventListener(MouseEvent.RIGHT_CLICK, onMouseDownDebug);
			addEventListener(KeyboardEvent.KEY_UP, onKeyDownDoDebug);
		}

		private function onMouseDownDebug(event : MouseEvent) : void {
			if(event.shiftKey) {
				if(parent is ExplodableView) return;
				if(!explodedViews) explodedViews = [];
				showExploded();
				explodedViews.push(this);
				event.stopImmediatePropagation();
			}
		}

		private function onKeyDownDoDebug(event : KeyboardEvent) : void {
			if(event.keyCode == Keyboard.ESCAPE)	{
				if(explodedViews ==null) return;
				if(parent is ExplodableView) return;
				for (var i : int = 0; i < explodedViews.length; i++) {
					var view : ExplodableView = explodedViews[i];
					view.revertToUnexploded();
				}
				event.stopImmediatePropagation();
				explodedViews = null; 
			}
		}
		public function showExploded(e : Event = null): void{
//			stage.displayState = StageDisplayState.FULL_SCREEN;
			for (var i : int = 0; i < numChildren; i++) {
				var child : ViewBase = getChildAt(i) as ViewBase;
				if(child is ViewBase) {
					child.animator.z = -40 * i;
					child.annotate();
				}
			}
			addEventListener(MouseEvent.MOUSE_WHEEL, zoomInOut);
			animator.z = 70 * numChildren;
			animator.y = 200;
			animator.rotationX = -45;
			annotate();
		}
		
		public function annotate() : void {
			visible = true;
			debugOriginalY = y;
			debugOutline = addChild(new Shape()) as Shape;
			var g : Graphics = debugOutline.graphics;
			g.lineStyle(1,0xFFFFFF);
			g.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			annotation = text(toString(),"Overlay");
			annotation.y = stage.stageHeight;
		}

		public function revertToUnexploded() : void {
			for (var i : int = 0; i < numChildren; i++) {
				var child : ViewBase = getChildAt(i) as ViewBase;
				if(child is ViewBase) child.deannotate();
			}
			animator.y = debugOriginalY || 0;
			animator.rotationX = 0;
			removeEventListener(MouseEvent.MOUSE_WHEEL, zoomInOut);
			animator.scaleX = 1;
			animator.scaleY = 1;
			deannotate();
			//graphics.clear();
		}
		
		public function deannotate() : void {
			animator.z = 0;
			animator.listen("z",clearTransform);
			if(debugOutline) {
				removeChild(debugOutline);
				debugOutline = null;
			}
			if(annotation) {
				removeChild(annotation);
				annotation = null;
			}
		}
		
		private function clearTransform(e:Event) : void {
			animator.unlisten("z", clearTransform);
			transform.matrix = new Matrix();
			y = debugOriginalY;
		}

		private function zoomInOut(event : MouseEvent) : void {
			if(event.shiftKey && event.altKey){
				rotationX += event.delta;
				
			}else if(event.shiftKey){
				x += event.delta * 10;
			}else{
				var newScale : Number = scaleX + event.delta * 0.01;
				scaleX = scaleY = scaleZ = newScale;
			}
		}


	}
}
