package tidy.mvc.view {
	import tidy.animation.animator.Animator;
	import tidy.mvc.view.PackableView;

	/**
	 * @author michaelforrest
	 */
	public class AnimatableView extends PackableView {
		public var animator : Animator;
		private var __visibility: Number;
		public function get visibility():Number{
			return __visibility;
		}
		public function set visibility(v:Number):void{
			__visibility = v;
		}
		public function AnimatableView(options : Object = null) {
			super(options);
			animator = new Animator(this);
			visibility = 1;
		}
		public function hide() : void {
			animator.visibility = 0;
		}

		public function show() : void {
			animator.visibility = 1;
		}


	}
}
