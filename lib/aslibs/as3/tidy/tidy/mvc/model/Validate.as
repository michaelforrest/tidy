package tidy.mvc.model {

	/**
	 * @author michaelforrest
	 */
	public class Validate {
		public static function andAssignTo(object : Object, source : Object, properties : Array) : void {
			for (var i : int = 0; i < properties.length; i++) {
				var property : String = properties[i];
				if(!object.hasOwnProperty(property)) throw("Cannot assign " + property + " to " + object);
				if(source[property] == null) throw("Must assign " + property + " to " + object + " constructor");
				object[property] = source[property];
			}
		}
	}
}
