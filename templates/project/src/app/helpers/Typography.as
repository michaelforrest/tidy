
package app.helpers {
	import tidy.mvc.helper.TypographyBase;
	import library.fonts.Fonts;
	// import 
	/**
	 * <%= credit %>
	 */
	public class Typography extends TypographyBase {
		public function Typography(style:String) {
			super(style);
		}
		public static function style( id: String) : TypographyBase{
			return new Typography(id);
		}
		override protected function Defaults() : void {
			super.Defaults();
			embedFonts = false;
    		font = "_sans";
			fontSize = 30;
			/*
    		embedFonts = true;
    		font = Fonts.BITSTREAM_VERA_SANS;
			verticalOffset = 0;
    		color = 0;
    		bold = false;
    		italic = false;
    		underline = false;
    		url = "";
    		target = "";
    		align = "left";
    		leftMargin = 0;
    		rightMargin = 0;
    		indent = 0;
    		leading = 0;
    		autoSize = "left";
    		background = false;
    		html = false;
    		wordWrap = true;
    		multiline = true;
    		condenseWhite = true;
    		border = false;
    		selectable = false;
    		embedFonts = true;
    		type = "dynamic";
            antiAliasType = "normal";
    		gridFitType = "none";
    	    thickness = 0;
    		maxChars;
    		sharpness = 0;
    		letterSpacing = 0;
    		kerning = false;
    		filters = [];
    		
			*/
		}
		/*
        // USAGE:
        // myViewBase.text("Text to show", "Heading1"); 
		public function Heading1() : void{
		
		}
		*/
        // USAGE:
        // myViewBase.text("Text to show", "Paragraph"); 
		public function Paragraph() : void{
		
		}
		
	}
}