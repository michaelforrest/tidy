package app.views {
	import tidy.mvc.view.PackableView;
	import app.helpers.Typography;
	/**
	 * @author michaelforrest
	 */
	public class ViewBase extends PackableView {
	    private static const IMPORTS : Array = [Typography];
		public function ViewBase(options : Object = null) {
			super(options);
		}
	}
}