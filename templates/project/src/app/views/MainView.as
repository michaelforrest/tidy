package app.views {
	import tidy.mvc.view.ViewBase;
	/**
	 * Main Entry Point Class
	 * <%= credit %>
	 */
	[Frame(factoryClass="app.views.PreloaderView")]
	public class MainView extends ViewBase {

		public function MainView() {
			super({paddingLeft:20, paddingTop:20, columnWidth:600 });
			trace("Hello from this src/app/views/MainView")
			append(text("It worked! Edit this view in src/app/views/MainView"));
		}
	}
}