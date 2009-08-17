package com.lbi.mvc.view {
	import app.helpers.Typography;

	import com.lbi.animation.animator.Animator;
	import com.lbi.mvc.helper.TypographyBase;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.getTimer;

	/**
	 * @author michaelforrest
	 */
	public class ViewBase extends Sprite {
		public static const HORIZONTAL : String = "horizontal";
		public static const VERTICAL : String = "vertical";
		private var nextX : Number = 0;
		public var nextY : Number = 0;
		public var spacing : Number = 0;
		public var leftMargin : Number = 0;
		public var columnWidth : Number = 600;
		private var elements : Array;
		public var topMargin : Number = 0;

		
		public var animator : Animator;
		private var unique_id : String;
		protected var image : ViewBase;
		private var image_url : String;
		private var loader : Loader;

		private var __visibility: Number;
		private var clickedPoint : Point;
		
		private var __anchor: Point = new Point(0, 0);
		private static var nextTextFieldID : Number = 0;

		public function get anchor():Point{
			return __anchor;
		}
		public function set anchor(v : Point):void{
			__anchor = v;
		}
		
		public function get visibility():Number{
			return __visibility;
		}
		public function set visibility(v:Number):void{
			__visibility = v;
		}
		
		public function ViewBase(options : Object = null) {
			unique_id = "viewbase-" + getTimer() + "-" + Math.random();
			animator = new Animator(this);
			visibility = 1;
			elements = [];
			if(options) {
				for (var key : String in options) {
					this[key] = options[key];
				}
			}
			nextX = leftMargin;
			nextY = topMargin;
		}

		public function getPosition() : Point {
			return new Point(x,y);
		}

		public function addTextField(style : TypographyBase, rectangle : Rectangle,  copy: String ="") : TextField {
			var txt : TextField = TypographyBase.createTextField(style, rectangle);
			txt.text = copy;
			addChild(txt);
			return txt;
		}

		public function getUniqueID() : String {
			return unique_id;
		}
		public function setPosition(...args) : void {
			if(args[0] is Point) {
				var position : Point = args[0] as Point;
				x = position.x;
				y = position.y;
			}else{
				x = args[0];
				y = args[1];
			}
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
			trace("Error loading "+ image_url);
		}
		/**
		 * TODO: think about a less nesty way to convert embedded classes into ViewBases.
		 */
		public function add(viewClass : Class, model:Object=null) : ViewBase {
			var result : DisplayObject = model ? new viewClass(model) : new viewClass();
			if(!(result is ViewBase)) {
				return addChildFromLibrary(viewClass);	
			}
			addChild(result);
			return result as ViewBase;
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
		public function addChildFromLibrary(assetClass : Class, options : Object = null) : ViewBase {
			var result : ViewBase = new ViewBase();
			addChild(result);
			var asset : DisplayObject = new assetClass() as DisplayObject;
			result.addChild(asset);
			if(asset.width != result.width) trace("WEIRD. The nested",assetClass,"isn't reporting the right width");
			if(options && options.center){ // yes I am grudgingly using the american spelling.
				asset.x = -asset.width/2;
				asset.y = -asset.height/2;
			}
			return result;
		}

		protected function onImageLoaded(e:Event) : void {
			
			//Bitmap(loader.content).smoothing = true;
		}

		protected function enableAsButton() : void {
			mouseChildren = false;
			buttonMode = true;
			useHandCursor = true;
		}
		public function append(element : DisplayObject) : DisplayObject {
			if(!element.parent) addChild(element);
			placeElement(element);
			elements.push(element);
			return element;
		}

		private var orientation : String = VERTICAL;
		public function setFlow(orientation : String) : void {
			this.orientation = orientation;
		}

		protected function placeElement(element : DisplayObject) : void {
			if(orientation == VERTICAL){
				element.x = nextX;
				element.y = nextY;
				nextY += element.height + spacing;
//				trace("object", this,unique_id, "y=", element.y,"element.height=",element.height,"nextY",nextY);
			}else{
				element.x = nextX;
				element.y = nextY;
				nextX = element.x + element.width + spacing;
			}
		}

		public function text(text : String, style : String = "") : DisplayObject {
			var txt : TextField = addTextField(Typography.style(style), new Rectangle(leftMargin, 0, columnWidth, 1000));
			txt.text = text;
			txt.height = txt.textHeight + 4; // if 2px padding is still the strange magic number
			return txt;
		}


		public function row(views : Array) : void {
			var nextX : Number = leftMargin;
			var maxHeight : Number = 0;
			for (var i : Number = 0; i < views.length; i++) {
				var view:DisplayObject = views[i];
				if(!view.parent) addChild(view);
				view.y = nextY;
				view.x = nextX;
				nextX += view.width + spacing;
				if(view.height > maxHeight) maxHeight = view.height;
				elements.push(view);
			}
			nextY += maxHeight + spacing;
		}
		public function layoutElements() : void {
			nextX = leftMargin;
			nextY = topMargin;
			for (var i : Number = 0; i < elements.length; i++) {
				var element:DisplayObject = elements[i];
				placeElement(element);

			}
		}
		public function clear() : void {
			for (var i : Number = 0;i < elements.length; i++) {
				var element:DisplayObject = elements[i];
				removeChild(element);
				element = null;
			}
			elements = [];
			nextY = topMargin;
			nextX = leftMargin;
		}

//		private var __scale:Number = 1;
//		public function get scale():Number{
//			return __scale;
//		}
//		public function set scale(v:Number):void{
//			__scale = v;
//			scaleX = scaleY = v;
//			if(!stage) return;
//			x = stage.stageWidth / 2 - stage.stageWidth * v / 2;
//			y = stage.stageHeight / 2 - stage.stageHeight * v / 2;
//		}

		public function getBlurBehind(rect : Rectangle) : BitmapData{
			var result : BitmapData  = new BitmapData(rect.width,rect.height,true,0x00000000);
			visible = false;
			var topLeft : Point = localToGlobal(rect.topLeft);
			var matrix : Matrix = new Matrix();
			matrix.translate(-topLeft.x, -topLeft.y);
			result.draw(stage,matrix,null,null,null);
			result.applyFilter(result, result.rect, new Point(0,0), new BlurFilter(10,10,2) );
			visible = true;
			return result;
		}

		override public function startDrag(lockCenter : Boolean = false, bounds : Rectangle = null) : void {
			clickedPoint = new Point(mouseX,mouseY).subtract(anchor);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, doDrag);
		}
		
		private function doDrag(event : MouseEvent) : void {
			x = parent.mouseX - clickedPoint.x - anchor.x;
			y = parent.mouseY - clickedPoint.y - anchor.y;
			event.updateAfterEvent();
		}

		override public function stopDrag() : void {
			if(!stage) return;
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, doDrag);
			
		}
		public function showLayering(e : Event = null): void{
//			stage.displayState = StageDisplayState.FULL_SCREEN;
			for (var i : int = 0; i < numChildren; i++) {
				var child : ViewBase = getChildAt(i) as ViewBase;
				child.z = -40 * i;
				if(child.graphics){
					child.visible = true;
					child.graphics.lineStyle(1,0xFFFFFF);
					child.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
					child.text(child.toString(),"Overlay").y = stage.stageHeight;
				}
			}
			addEventListener(MouseEvent.MOUSE_WHEEL, zoomInOut);
			z = 70 * numChildren;
			y = 200;
			rotationX = -45;
			//rotationZ = 45;
//			graphics.beginFill(0xFFFFFF);

			graphics.lineStyle(1,0xFFFFFF);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			//graphics.drawRect(-5000, -5000, 10000, 10000);		
		}
		
		private function zoomInOut(event : MouseEvent) : void {
			if(event.shiftKey){
				x += event.delta * 10;
			}else{
				var newScale : Number = scaleX + event.delta * 0.01;
				scaleX = scaleY = scaleZ = newScale;
			}
		}
		public function adjustStyle(field : TextField, styleName : String, options : Object) : void {
			var style : Typography = new Typography(styleName);
			for (var i : String in options) {
				style[i] = options[i];
			}
			field.setTextFormat(style.getTextFormat());
			field.defaultTextFormat = style.getTextFormat();
		}
		public function bringToFront(view : DisplayObject) : void {
			swapChildren(view, getChildAt(numChildren-1));
		}
	}
}
