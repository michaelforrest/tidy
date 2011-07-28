package app.views {
	import flash.events.Event;
	import tidy.mvc.view.PackableView;
	import app.helpers.Typography;
	/**
	 * @author michaelforrest
	 */
	public class ViewBase extends PackableView {
	    private static const IMPORTS : Array = [Typography];
		public function ViewBase(options : Object = null) {
			super(options);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		protected function onAddedToStage(event : Event) : void {
			
		}
	}
}