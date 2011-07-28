package app.views {
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import app.helpers.Style;

	import flash.desktop.NativeApplication;
	import flash.events.InvokeEvent;
	import flash.html.HTMLLoader;
	import flash.net.URLRequest;
	/**
	 * Main Entry Point Class
	 * Generated with Tidy Flash
	 */
	[Frame(factoryClass="app.views.PreloaderView")]
	public class MainView extends ViewBase {
		private var htmlLoader : HTMLLoader;

		public function MainView() {
			super(Style.DEFAULT);
			addHTML();
			getCommandLineArguments();
		}

		private function onResize(event : Event) : void {
			fitToStage();
		}

		private function fitToStage() : void {
			htmlLoader.width = stage.stageWidth;
			htmlLoader.height = stage.stageHeight;
		}

		override protected function onAddedToStage(event : Event) : void {
			super.onAddedToStage(event);
			stage.addEventListener(Event.RESIZE, onResize);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			fitToStage();			
		}
		private function getCommandLineArguments() : void {
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke);
		}

		private function onInvoke(event : InvokeEvent) : void {
			var url : String = event.arguments[0] || "http://google.com"; 
			htmlLoader.load(new URLRequest(url));
		}

		private function addHTML() : void {
			htmlLoader = new HTMLLoader();
			addChild(htmlLoader);
		}
	}
}