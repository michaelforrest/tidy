package tidy.debug {

	/**
	 * @author chrgio
	 */
	public class LogItemType
	{
		public static var GROUP : LogItemType = new LogItemType("group");
		public static var ELEMENT : LogItemType = new LogItemType("element");
		
		private var value : String;
		
		function LogItemType(value : String) 
		{
			this.value = value;
		}
		
		public function toString () : String
		{
			return this.value;
		}
	}
}
