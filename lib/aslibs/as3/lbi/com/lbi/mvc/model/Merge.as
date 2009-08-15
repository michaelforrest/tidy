package com.lbi.mvc.model {

	/**
	 * @author michaelforrest
	 */
	public class Merge {
		public static function objects(extra : Object, original : Object) : Object {
			for (var i : String in extra) {
				original[i] = extra[i];
			}
			return original;
		}
	}
}
