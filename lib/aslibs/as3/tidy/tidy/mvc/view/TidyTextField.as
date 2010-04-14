package tidy.mvc.view {
	import flash.text.TextFieldAutoSize;
	import tidy.mvc.helper.ColorHelper;
	import tidy.mvc.helper.TypographyBase;

	import flash.text.TextField;

	/**
	 * @author michaelforrest
	 */
	public class TidyTextField extends TextField {
		public var style : TypographyBase;
		
		public function TidyTextField(style : TypographyBase) {
			this.style = style;
		}

		override public function set y(value : Number) : void {
			super.y = value + style.vertical_offset;
		}

		override public function get y() : Number {
			return super.y - style.vertical_offset;
		}
		
		public function invert(v : Number) : void {
			
			var inverse :Number = 0xFFFFFF - style.colour;
			textColor = ColorHelper.interpolate(style.colour, inverse, v);
		}

		
	}
}
