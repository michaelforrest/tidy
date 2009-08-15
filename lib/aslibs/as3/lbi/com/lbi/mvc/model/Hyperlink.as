package com.lbi.mvc.model {
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	/**
	 * @author michaelforrest
	 */
	public class Hyperlink {
		public static var BLANK : String = "_blank";
		public static var SELF : String = "_self";
		public static var PARENT : String = "_parent";
		public static var TOP : String = "_top";

		public var text : String;
		public var href : String;
		public var target : String;
		/**
		 * optionally supply an object literal with
		 * {text:'text',href:'http://href',target:'_blank'} (target is optional)
		 */
		public function Hyperlink(xml : XML) {
			text = xml.toString();
			href = xml.@href;
			target = xml.@target;
		}

		public function follow(e :Event = null) : void{
			var request : URLRequest = new URLRequest(href);
			navigateToURL(request, target);
		}
		public function toString() : String{
			return "[Hyperlink text=" + text + ", href=" + href+ ", target=" + target + "]";
		}

	}
}
