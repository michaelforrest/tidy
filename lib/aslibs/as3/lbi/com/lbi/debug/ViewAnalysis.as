package com.lbi.debug {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	/**
	 * @author michaelforrest
	 */
	public class ViewAnalysis {
		public static function allViewsInside(top : DisplayObjectContainer) : String {
			var result : String = "";
			result += childrenOf(top);
			return result;
		}

		private static function childrenOf(top : DisplayObjectContainer, tabs : String = "") : String {
			var result : String = "";
			result += ("\n" + tabs + top.toString());
			for (var i : Number = 0; i < top.numChildren; i++) {
				var item : DisplayObject = top.getChildAt(i);
				result += ("\n" + tabs + childrenOf(item as DisplayObjectContainer, tabs + "\t"));
			}
			return result;
		}
	}
}
