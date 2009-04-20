package com.lbi.mvc.view {
	import app.models.FlashVars;

	import com.lbi.animation.animator.Animator;
	import com.lbi.animation.util.Easing;
	import com.lbi.mvc.helper.TypographyBase;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	/**
	 * @author michaelforrest
	 */
	public class ViewBase extends Sprite {
		public var animator : Animator;
		private var unique_id : String;

		public var image : ViewBase;
		protected var loader : Loader;
		protected var image_url : String;
		protected static var IMAGE_LOADED : String = "image_loaded";
		public var loaded : Boolean = false;

		public function ViewBase() {
			unique_id = "viewbase-" + getTimer() + "-" + Math.random();
			animator = new Animator(this);

			addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		protected function onAdded(event : Event) : void {
		}
		protected function debugInfo(element:*, index:int, arr:Array) : String{
			return element.toString();
		}

		public function addTextField(style : TypographyBase, rectangle : Rectangle,  copy: String ="") : TextField {
			var txt : TextField = TypographyBase.createTextField(style, rectangle);
			txt.text = copy;
			addChild(txt);
			return txt;
		}
		override public function toString() : String {
			return getQualifiedClassName(this) + " " + image_url;
		}
		public function getUniqueID() : String {
			return unique_id;
		}
		public function setPosition(...args) : void {
			var position : Point = (args[0] is Point) ? args[0] : new Point(args[0], args[1]);
			x = position.x;
			y = position.y;
		}

		public function loadImage(url : String) : void {
			if(image){
				destroyImage();
			}else{
				createImage();
			}
			image_url = completeImagePath(url);
			loader.load(new URLRequest(image_url));
		}

		protected function completeImagePath(url : String) : String {
			return FlashVars.getImagePath(url);
		}

		private function createImage() : void {
			image = new ViewBase();
			addChild(image);
			loader  = new Loader();
			image.addChild(loader);

			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onImageLoaded);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			image.cacheAsBitmap = true;
		}

		protected function onIOError(event : IOErrorEvent) : void {
			throw new Error("Error loading "+ image.loaderInfo.url);
		}
		public function add(viewClass : Class, model:Object=null) : ViewBase {
			var result : ViewBase = model ? new viewClass(model) : new viewClass();
			addChild(result);
			return result;
		}

		private function destroyImage() : void {
			try{
				var li:LoaderInfo = loader.contentLoaderInfo;
				if(li.childAllowsParent && li.content is Bitmap){
					(li.content as Bitmap).bitmapData.dispose(); // remove bitmap from memory
				}
			}catch(e:Error){
				trace('error disposing of image ' + image);
			}
		}
		public function addChildFromLibrary(assetClass : Class) : ViewBase {
			var result : ViewBase = new ViewBase();
			addChild(result);
			result.addChild(new assetClass() as DisplayObject);
			return result;
		}

		protected function onImageLoaded(e:Event) : void {
			//if(height==0) trace("a loaded image's height really should not be 0... image=" + image_url + " image.height=" + image.height);
			loaded = true;
			dispatchImageLoaded();
		}

		protected function dispatchImageLoaded(e:Event = null) : void {
			dispatchEvent(new Event(IMAGE_LOADED));
		}

		public function middle() : Point{
			return new Point(width/2, height/2);
		}
		public function enableAsButton() : void {
			mouseChildren = false;
			buttonMode = true;
		}
//		protected function waitToLoad(clips : Array, callBack : Function ) : void {
//			var s : Stack = new Stack();
//			for (var i : Number = 0; i < clips.length; i++) {
//				var clip:ViewBase = clips[i];
//				s.addLabel("loaded an image")
//				s.addMethod(clip, null, ViewBase.IMAGE_LOADED);
//			}
//			s.addEventListener(Event.COMPLETE, callBack);
//			s.go();
//		}
		protected function bringToFront(child : ViewBase) : void {
			var temp : ViewBase = add(ViewBase);
			swapChildren(child, temp);
			removeChild(temp);
			temp = null;
		}
		protected function fit(v : Number, low : Number, high : Number) : Number {
			var result : Number = (v - low) / (high - low);
			result = Math.max(0, result);
			result = Math.min(1, result);
			return Easing.linearTween(result);
		}

	}
}
