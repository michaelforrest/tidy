package com.lbi.debug {
	import com.lbi.debug.LogItemType;
	/**
	 * @author chrgio
	 */
	public class Log
	{
		// these are set in the logger as well
		private static const DEFAULT_BACKGROUND : Number = 0xFFFFFF;
		private static const DEFAULT_FOREGROUND : Number = 0x000000;

		private static var DEFAULT_LEVEL : Number = 5;
		private static var log_level : Number;

		public static function setLogLevel( level : Number ) : void
		{
			log_level = level;
		}

		public static function getLogLevel() : Number
		{
//			if(isNaN(log_level)){
//				// In this first iteration I wasn't able to get the parameter from the html :S
//				var app : Object = Application.application;
//				var level : Number;
//				if(app != null) level = app["parameters"]["log_level"] as Number;
//				log_level = (!isNaN(level) ? level : DEFAULT_LEVEL);
//			}
			return log_level;
		}

		private static var items : Array;
		private static var last_message : String;
		private static var last_message_type : LogType;

		public static function debug(message : String) : void
		{
			output(LogType.DEBUG, message);
		}

		public static function info(message : String) : void
		{
			output(LogType.INFO, message);
		}

		public static function warn(message : String) : void
		{
			output(LogType.WARNING, message);
		}

		public static function error(message : String) : void
		{
			output(LogType.ERROR, message);
		}

		public static function fatal(message : String) : void
		{
			output(LogType.FATAL, message);
		}

		private static function output(type : LogType, message : String) : void
		{
			if(getLogLevel() < type.level) return;
			last_message_type = type;
			last_message = message;
			trace("[" + type + "] " + message);
		}

		public static function getLastMessage() : String
		{
			return last_message;
		}

		public static function getLastMessageType() : LogType
		{
			return last_message_type;
		}

		public static function clear() : void
		{
			last_message = null;
			last_message_type = null;
		}

		public static function custom( message : String, foreground_colour : Number = DEFAULT_FOREGROUND, background_colour : Number = DEFAULT_BACKGROUND, bold : Boolean = false, level : Number = 0 ) : void
		{
			if(getLogLevel() < level) return;
			var command : String = "[custom";
			if(foreground_colour != DEFAULT_FOREGROUND) 	command += " foreground=#" + foreground_colour.toString(16);
			if(background_colour != DEFAULT_BACKGROUND) 	command += " background=#" + background_colour.toString(16);
			if(bold == true)  								command += " bold=true";
			command += "] " + message;

			last_message_type = LogType.CUSTOM;
			last_message = command;

			trace(command);
		}

		public static function createGroup(id : String, foreground_colour : Number = DEFAULT_FOREGROUND, background_colour : Number = DEFAULT_BACKGROUND, bold : Boolean = false, level : Number = 0) : void
		{
			createItemCommand(LogItemType.GROUP, id, foreground_colour, background_colour, bold, level);
		}

		public static function group( id : String, message : String ) : void
		{
			item(LogItemType.GROUP, id, message);
		}

		public static function createElement(id : String, foreground_colour : Number = DEFAULT_FOREGROUND, background_colour : Number = DEFAULT_BACKGROUND, bold : Boolean = false, level : Number = 0) : void
		{
			createItemCommand(LogItemType.ELEMENT, id, foreground_colour, background_colour, bold, level);
		}

		public static function element( id : String, message : String ) : void
		{
			item(LogItemType.ELEMENT, id, message);
		}

		private static function createItemCommand(type : LogItemType, id : String, foreground_colour : Number, background_colour : Number, bold : Boolean, level : Number = 0 ) : void
		{
			if(id.split(" ").length > 1) {
				error("Log::createItemCommand, id shouldn't contain empty spaces");
				return;
			}
			var command : String = "[setup-" + type + " " + id;
			if(foreground_colour != DEFAULT_FOREGROUND) 	command += " foreground=#" + getHex(foreground_colour);
			if(background_colour != DEFAULT_BACKGROUND) 	command += " background=#" + getHex(background_colour);
			if(bold == true)  								command += " bold=true";
			command += "]";

			registerItem(type, id, level);

			last_message_type = LogType.CUSTOM;
			last_message = command;

			trace(command);
		}

		private static function registerItem(type : LogItemType, id : String, level : Number) : void
		{
			if(items == null) items = [];
			items[getItemId(type, id)] = level;
		}

		private static function getHex( colour : Number ) : String
		{
			var hex : String = colour.toString(16);
			for (var i : Number = hex.length;i < 6; i++)  hex = "0" + hex;
			return hex;
		}

		private static function item(type : LogItemType, id : String, message : String) : void
		{
			var item_level : Number = items[getItemId(type, id)] || 0;
			if(getLogLevel() < item_level) return;

			last_message_type = LogType.CUSTOM;
			last_message = "[" + type + " " + id + "] " + message;
			trace(last_message);
		}

		private static function getItemId( type : LogItemType, id : String ) : String
		{
			return type + "-" + id;
		}
	}
}
