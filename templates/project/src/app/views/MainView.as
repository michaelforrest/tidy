package app.views {
	import app.views.ViewBase;
	
	/**
	 * Main Entry Point Class
	 * <%= credit %>
	 */
	[Frame(factoryClass="app.views.PreloaderView")]
	public class MainView extends ViewBase {

		public function MainView() {
			super();
			trace("Hello from this src/app/views/MainView");
			
			append(text("It worked! Edit this view in src/app/views/MainView"));
		}
	}
}