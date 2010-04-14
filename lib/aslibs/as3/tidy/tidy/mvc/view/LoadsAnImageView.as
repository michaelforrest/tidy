package tidy.mvc.view {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;

	/**
	 * @author michaelforrest
	 */
	public class LoadsAnImageView extends ExplodableView{
		private var image_url : String;
		private var loader : Loader;
		protected var image : ViewBase;
		public function LoadsAnImageView(options : Object = null) {
			super(options);
		}
		
		public function loadImage(url : String) : ViewBase {
			if(image){
				destroyImage();
			}
			createImage();
			image_url = url;
			loader.load(new URLRequest(url));
			return image;
		}

		private function createImage() : void {
			image = new ViewBase();
			addChild(image);
			loader  = new Loader();
			image.addChild(loader);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded,false,0,true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError,false,0,true);
		}

		protected function onIOError(event : IOErrorEvent) : void {
			trace("Error in " + this + "(" + event.text + ")");
		}
		protected function destroyImage() : void {
			try{
				var li:LoaderInfo = loader.contentLoaderInfo;
				li.removeEventListener(Event.COMPLETE, onImageLoaded);
				li.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
				if(li.childAllowsParent && li.content is Bitmap){
					(li.content as Bitmap).bitmapData.dispose(); // remove bitmap from memory
				}
			}catch(e:Error){
				trace('error disposing of image ' + image);
			}
		}

		protected function onImageLoaded(e:Event) : void {
			dispatchEvent(e);
			//Bitmap(loader.content).smoothing = true;
		}
		
	}
}
