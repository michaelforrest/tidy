package tidy.mvc.view {
	import themes.Theme;

	import tidy.mvc.collection.Collection;
	import tidy.mvc.helper.TypographyBase;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;

	/**
	 * @author michaelforrest
	 */
	public class PackableView extends Sprite {
		public static const HORIZONTAL : String = "horizontal";
		public static const VERTICAL : String = "vertical";

		private var nextX : Number = 0;
		public var nextY : Number = 0;
		public var spacing : Number = 0;
		public var leftMargin : Number = 0;
		public var columnWidth : Number = 200;
		private var elements : Collection;
		public var topMargin : Number = 0;
		private var maxHeight : Number;
		private var maxWidth : Number;

		private var maxRowHeight : Number = 0;

		public function PackableView(options : Object = null) {
			elements = new Collection();
			if(options) for (var key : String in options) this[key] = options[key];

			nextX = leftMargin;
			nextY = topMargin;
			
		}
		public function addTextField(style : TypographyBase, rectangle : Rectangle,  copy: String ="") : TextField {
			var txt : TextField = TypographyBase.createTextField(style, rectangle);
			txt.text = copy;
			addChild(txt);
			return txt;
		}
		/**
		 * TODO: think about a less nesty way to convert embedded classes into ViewBases.
		 */
		public function add(viewClass : Class, model:Object=null) : ViewBase {
//			if(!viewClass) {
//				viewClass = ViewBase;
//				trace("Error trying to add a view class to "+this+"(can't tell what was attempted - the model was " + model + ")");
//			}
			var result : DisplayObject = model ? new viewClass(model) : new viewClass();
			if(!(result is ViewBase)) {
				return addChildFromLibrary(viewClass);	
			}
			addChild(result);
			return result as ViewBase;
		}
		public function append(element : DisplayObject) : DisplayObject {
			if(!element.parent) addChild(element);
			placeElement(element);
			elements.add(element);
			return element;
		}

		private var orientation : String = VERTICAL;
		public function setFlow(orientation : String) : void {
			this.orientation = orientation;
		}

		protected function get packedElements() : Collection{
			return elements;
		}

		protected function placeElement(element : DisplayObject) : void {
			if(orientation == VERTICAL){
				if(maxHeight && nextY + element.height  > maxHeight) {
					nextY = topMargin;
					nextX += columnWidth + spacing;
				}
				moveElement(element,nextX,nextY);
				nextY += element.height + spacing;
//				trace("object", this,unique_id, "y=", element.y,"element.height=",element.height,"nextY",nextY);
			}else{
				maxRowHeight = Math.max(maxRowHeight, element.height);
				if(maxWidth && nextX + element.width > maxWidth) {
					nextY += maxRowHeight + spacing;
					nextX = leftMargin;
					maxRowHeight = 0;
				}
				moveElement(element,nextX,nextY);
				nextX = element.x + element.width + spacing;
			}
		}
		
		public function moveElement(element : DisplayObject, nextX : Number, nextY : Number) : void {
			element.x = nextX;
			element.y = nextY;
		}
		
		public function text(text : String, style : String) : DisplayObject {
			if(text == null) trace("Error trying to set text of " + this + " to null" );
			var txt : TextField = addTextField(Theme.current().stylesheet['style'](style), new Rectangle(leftMargin, 0, columnWidth, 1000));
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
				elements.add(view);
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
			elements = new Collection();
			nextY = topMargin;
			nextX = leftMargin;
		}
		public function addChildFromLibrary(assetClass : Class, options : Object = null) : ViewBase {
			if(!assetClass) return null;
			var result : ViewBase = new ViewBase();
			addChild(result);
			var asset : DisplayObject = new assetClass() as DisplayObject;
			result.addChild(asset);
			if(asset.width != result.width) trace("WEIRD. The nested",assetClass,"isn't reporting the right width");
			if(options && options.center){ // yes I am grudgingly using the american spelling.
				asset.x = -asset.width/2;
				asset.y = -asset.height/2;
			}
			if(options && options.offset){
				asset.x = options.offset.x;
				asset.y = options.offset.y;
			}
			return result;
		}
		
	}
}
