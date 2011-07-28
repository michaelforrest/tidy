package app.helpers {
	import flash.display.Stage;

	/**
	 * @author michaelforrest
	 */
	public class Debug {
		private static var show_invisible_fills : Boolean = false;
		
		public static function init(stage : Stage) : void {
			new Debug();
		}
		public static function showInvisibleFills() : Boolean {
			return show_invisible_fills;
		}
	}
}
