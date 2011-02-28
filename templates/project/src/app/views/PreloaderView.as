package app.views{
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.utils.getDefinitionByName;
	public class PreloaderView extends MovieClip{
	    
		public function PreloaderView() {
			stop();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onEnterFrame(event : Event) : void {
			showProgress();
			if(framesLoaded == totalFrames) {
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				nextFrame();
				init();
			}
		}
		
		// customise this method to make your loader nicer.
		private function showProgress() : void{
			var percent : Number = root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal;
			graphics.clear();
			graphics.beginFill(0xCCCCCC);
			graphics.drawRect(0,0,stage.stageWidth * percent, stage.stageHeight);
		}
		private function init() : void {
			var mainClass : Class = Class(getDefinitionByName("app.views.MainView"));
			if(mainClass) {
				graphics.clear();
				var app : Object = new mainClass();
				addChild(app as DisplayObject);
			}
		}
	}
}