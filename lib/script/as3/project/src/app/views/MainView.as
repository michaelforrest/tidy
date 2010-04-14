package app.views {
	import tidy.mvc.view.ViewBase;
	/**
	 * Main Entry Point Class
	 * <%= credit %>
	 */
	[Frame(factoryClass="app.views.PreloaderView")]
	public class MainView extends ViewBase {

		public function MainView() {
			super({});
			trace("Hello from Tidy Flash!")
			append(text("Hello world!"));
		}
	}
}