package tidy.mvc.model {

	/**
	 * @author michaelforrest
	 */
	public class Check {
		public static function notNull(source : Object, required_fields : Array) : void {
			if(source == null) throw new Error("Check.notNull error: source not supplied");
			for (var i : int = 0; i < required_fields.length; i++) {
				var field : String = required_fields[i];
				if(source[field] == null) throw new Error("Check.notNull error: field " + field + " is null on source " + source);
			}
		}
	}
}
