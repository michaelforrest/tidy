package com.lbi.mvc.model {
	/**
	 * @author michaelforrest
	 */
	public class StringFormatting {
		public static function formatTimeInCentiseconds(t : Number) : String {
			var seconds:Number = Math.floor(t % 60);
			var minutes:Number = Math.floor((t - seconds)/ 60 );
			var centiseconds:Number = Math.floor(( t-Math.floor(t) ) * 100);
			return pad(minutes) + ":" + pad(seconds) + ":" + pad(centiseconds);
		}
		public static function formatTimeInSeconds(t : Number) : String {
			var seconds:Number = Math.floor(t % 60);
			var minutes:Number = Math.floor((t - seconds)/ 60 );
			return pad(minutes) + ":" + pad(seconds) ;
		}

		private static function pad(n : Number) : String {
			var s:String = n.toString();
			if(s.length==1) s = "0" + s;
			return s;
		}
		/**
		 * converts string from underscore_lower_case to camelCase
		 * Utterly untested.
		 */
		public static function camelize($s:String):String{
			var s_arr:Array = $s.split('_');
		    if (s_arr.length == 1) return s_arr[0];

		    var camelizedString:String = $s.indexOf('_') == 0
		      ? s_arr[0].charAt(0).toUpperCase() + s_arr[0].substring(1)
		      : s_arr[0];

		    for (var i:Number = 1, len:Number = s_arr.length; i < len; i++) {
		      var s:String = s_arr[i];
		      camelizedString += s.charAt(0).toUpperCase() + s.substring(1);
		    }

		    return camelizedString;
		}
		/**
		 * converts any string into a valid variable name
		 * See tests [aslibs_framafabTest ->StringFormattingTest] for behaviour expectations
		 */
		public static function variablify(string:String):String{
			string = string.split(".").join("_");
			string = string.split(" ").join("_");
			string = string.split("-").join("_");
			return string;
		}
		/**
		 * ThisIsPascalCase
		 */
		public static function pascalize(underscore_separated : String) : String {
			var s:String = camelize(underscore_separated.toLowerCase());
			var pascalized:String = s.charAt(0).toUpperCase() + s.substr(1,s.length-1);
			return pascalized;
		}

		public static function underscore(string : String) : String {
			var alphabet : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			for (var i : Number = 0; i < alphabet.length; i++) {
				var letter:String = alphabet.charAt(i);
				string = string.split(letter).join("_" + letter.toLowerCase());
				if(string.charAt(0)=="_") string = string.substr(1,string.length);
			}
			return string;
		}
		/**
		 * Trim functions from as2lib
		 */

		 public static function trim(string:String):String {
			return leftTrim(rightTrim(string));
		}

		public static function leftTrim(string:String):String {
			return leftTrimForChars(string, "\n\t\n ");
		}

		public static function rightTrim(string:String):String {
			return rightTrimForChars(string, "\n\t\n ");
		}

		public static function leftTrimForChars(string:String, chars:String):String {
			var from:Number = 0;
			var to:Number = string.length;
			while (from < to && chars.indexOf(string.charAt(from)) >= 0){
				from++;
			}
			return (from > 0 ? string.substr(from, to) : string);
		}

		public static function rightTrimForChars(string:String, chars:String):String {
			var from:Number = 0;
			var to:Number = string.length - 1;
			while (from < to && chars.indexOf(string.charAt(to)) >= 0) {
				to--;
			}
			return (to >= 0 ? string.substr(from, to+1) : string);
		}

		public static function leftTrimForChar(string:String, char:String):String {
			return leftTrimForChars(string, char.charAt(0));
		}

		public static function rightTrimForChar(string:String, char:String):String {
			return rightTrimForChars(string, char.charAt(0));
		}

		private static var LINES_DELIMETERS : Array = ["\r\n", "\n\r", "\r", "\n"];

		public static function stripInLines ( s : String ) : Array
		{
			var res : Array = [];
			var delimeter_index : Number = 0;
			var delimeter : String;
			while(res.length<2 && delimeter_index<LINES_DELIMETERS.length){
				delimeter = LINES_DELIMETERS[delimeter_index];
				res = s.split(delimeter);
				delimeter_index++;
			}
			return res;
		}


		public static function collectionize(class_name : String) : String {
			return underscore(class_name).toLowerCase() + "s";			;
		}

		public static function sentenceCase(underscored : String) : String {
			var words : Array = underscored.split("_");
			var first_word : String = words[0];
			words[0] = words[0].charAt(0).toUpperCase() + words[0].substr(1,words[0].length-1);
			for (var i : Number = 0; i < words.length; i++) {
				if(words[i] == "and") words[i] = "&";
			}
			return words.join(' ');
		}
	}
}
