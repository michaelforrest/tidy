package tidy.mvc.model {

	/**
	 * @author michaelforrest
	 */
	public class Merge {

		public static function eachObject(objects : Array, extra : Object) : Array {
			var result : Array = [];
			for (var i : int = 0; i < objects.length; i++) {
				var item : Object = objects[i];
				item  = Merge.objects(extra, item);
			}
			return result;
		}
		
		public static function arrays(...args) : Array {
			var result : Array = new Array();
			for (var i : int = 0; i < args.length; i++) {
				var array : Array = args[i];
				result = result.concat(array);
			} 
			return result;
		}
		
		public static function objects(extra : Object, original : Object) : Object {
			if(!extra) extra = {};
			if(!original) original = {};
			var result : Object = {};
			for (var i : String in original) {
				result[i] = original[i];
			}
			for (var j : String in extra) {
				result[j] = extra[j];
			}
			return result;
		}
	}
}
