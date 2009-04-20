package com.lbi.debug 
{
	/**
	 * @author chrgio
	 */
	public class LogType
	{
		public static var FATAL : LogType = new LogType("fatal", 0);
		public static var ERROR : LogType = new LogType("error", 1);
		public static var WARNING : LogType = new LogType("warning", 2);
		public static var INFO : LogType = new LogType("info", 3);
		public static var DEBUG : LogType = new LogType("debug", 4);
		
		public static var CUSTOM : LogType = new LogType("custom", 0);
		
		public var level : Number;		
		private var value : String;
		
		
		function LogType(value : String, level : Number) 
		{
			this.value = value.toUpperCase();
			this.level = level;
		}
		
		public function toString () : String
		{
			return value;
		}
	}
}
