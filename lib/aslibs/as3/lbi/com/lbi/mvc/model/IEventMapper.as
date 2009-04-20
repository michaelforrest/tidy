package com.lbi.mvc.model {
	import flash.events.IEventDispatcher;		
	/**
	 * @author michaelforrest
	 */
	public interface IEventMapper extends IEventDispatcher {
		function registerEvents(view : Object,events : Array):void;
		function getPossibleEvents():Array;
		function eventIsPossible(event_name : String) : Boolean;
	}
}
