package app.views {
	import flash.events.Event;

	import com.lbi.mvc.view.ViewBase;

	import app.models.App;
	import app.models.FlashVars;
	/**
	 * <%= credit %>
	 */

	public class AppView extends ViewBase {
		private var app : App;

		public function AppView() {
			addEventListener(Event.ADDED, initFlashVars);
		}
		private function initFlashVars(event : Event) : void {
			FlashVars.init(stage);
			app = App.getInstance();
			app.registerEvents(this, [App.READY]);

		}
		public function onReady(e : Event) : void {
		}
	}
}