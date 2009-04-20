package com.lbi.mvc.model {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import com.lbi.animation.group.Queue;
import flash.utils.getQualifiedClassName;	/**
	 * @author michaelforrest
	 */
	public class SequentialDependencyLoader extends EventDispatcher {
		public static var READY : String = "ready";
		public var loaded : Number = 0;
		public var lastLoaded : String;

		public function dispatchReady():void {dispatchEvent(new Event(READY));
		}

		public function SequentialDependencyLoader(dependencies : Array) {
			var queue : Queue = new Queue();
			for (var i : Number = 0;i < dependencies.length; i++) {
				var klass : Class = dependencies[i];
				var loaderDispatcher : XMLListLoaderDispatcher = new XMLListLoaderDispatcher(klass);
				queue.addMethod(loaderDispatcher, loaderDispatcher.start, XMLListLoaderDispatcher.READY);
				//queue.addMessage("loaded xml for " + getQualifiedClassName(klass));
			}
			queue.addEventListener(Event.COMPLETE, onReady);
			queue.go();
		}

		private function onReady(event : Event) : void {
			dispatchReady();
		}
	}
}
