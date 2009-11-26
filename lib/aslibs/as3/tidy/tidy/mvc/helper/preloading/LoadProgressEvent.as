package tidy.mvc.helper.preloading {
	import tidy.mvc.model.SequentialDependencyLoader;

	import flash.events.Event;

	/**
	 * @author michaelforrest
	 */
	public class LoadProgressEvent extends Event {

		public static const PROGRESS : String = "progress";
		public var loader : SequentialDependencyLoader;

		public function LoadProgressEvent(dependencyLoader : SequentialDependencyLoader) {
			super(PROGRESS);
			loader = dependencyLoader;
		}
	}
}
