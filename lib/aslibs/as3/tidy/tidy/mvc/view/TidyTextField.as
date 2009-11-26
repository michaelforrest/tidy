package tidy.mvc.view {
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
		
	}
}
