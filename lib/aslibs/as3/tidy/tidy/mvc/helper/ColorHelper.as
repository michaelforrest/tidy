package tidy.mvc.helper {

	/**
	 * @author michaelforrest
	 * [shamelessly pasted (this time) from http://stackoverflow.com/questions/1350315/actionscript-3-0-color-interpolation-question]
	 */
	public class ColorHelper {
		public static function interpolate(fromColor :uint ,  toColor : uint, progress : Number) : uint{
			var q:Number = 1-progress;
		    var fromA:uint = (fromColor >> 24) & 0xFF;
		    var fromR:uint = (fromColor >> 16) & 0xFF;
		    var fromG:uint = (fromColor >>  8) & 0xFF;
		    var fromB:uint =  fromColor        & 0xFF;
		
		    var toA:uint = (toColor >> 24) & 0xFF;
		    var toR:uint = (toColor >> 16) & 0xFF;
		    var toG:uint = (toColor >>  8) & 0xFF;
		    var toB:uint =  toColor        & 0xFF;
		
		    var resultA:uint = fromA*q + toA*progress;
		    var resultR:uint = fromR*q + toR*progress;
		    var resultG:uint = fromG*q + toG*progress;
		    var resultB:uint = fromB*q + toB*progress;
		    var resultColor:uint = resultA << 24 | resultR << 16 | resultG << 8 | resultB;
		    return resultColor;  
		}
	}
}
