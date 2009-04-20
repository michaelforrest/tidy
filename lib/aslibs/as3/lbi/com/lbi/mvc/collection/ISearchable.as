package com.lbi.mvc.collection {
	/**
	 * @author michaelforrest
	 */
	public interface ISearchable {
		function findByProperty($property : String, $value : Object) : Object;
		function findByValue($value : Object) : Object;
		//function push(object : Object) : Number;
	}
}
