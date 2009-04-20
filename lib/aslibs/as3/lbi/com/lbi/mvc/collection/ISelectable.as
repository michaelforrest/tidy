package com.lbi.mvc.collection {
	/**
	 * @author michaelforrest
	 */
	public interface ISelectable {
		function select():void;
		function deselect():void;
		function isSelected():Boolean;
	}
}
