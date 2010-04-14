package app.models {
	import com.lbi.mvc.collection.Selectable;
	/**
	 * @author michaelforrest
	 */
	public class <%= @model_name %> extends Selectable {
		public function <%= @model_name %>() {
			super();
		}
	}
}