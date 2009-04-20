package com.lbi.mvc.model {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	/**
	 * @author michaelforrest
	 * Yep sorry, actually two of these classes are used in the course of the autopopulation process now...
	 * Since it works, I am not looking at it any more....
	 */
	public class XMLListLoaderDispatcher extends EventDispatcher {
		private var klass : *;
		private var events : EventDispatcher;
		public static const READY : String= "ready";

		public function XMLListLoaderDispatcher($class : Class) {
			super();
			klass = $class;
		}

		public function getClass() : String {
			return getQualifiedClassName(klass);
		}

		public function start() : void {
			events = klass.prepare();
			events.addEventListener(Event.COMPLETE, onOtherDispatcherReady);
		}

		private function onOtherDispatcherReady(event : Event) : void {
			if(!klass.prepare) throw new Error("Please create a prepare() : EventDispatcher {} event on class " +  getQualifiedClassName(klass));
			dispatchEvent(new Event(READY));
		}
	}
}
