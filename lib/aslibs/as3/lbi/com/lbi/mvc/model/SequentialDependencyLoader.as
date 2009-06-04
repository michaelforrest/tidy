package com.lbi.mvc.model {
	import com.lbi.animation.group.Queue;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;	/**
	 * @author michaelforrest
	 */
	public class SequentialDependencyLoader extends EventDispatcher {
		public static var READY : String = "ready";
		public var loaded : Number = 0;
		private var queue : Queue;
		private var bytesLoaded : uint;

		public function dispatchReady():void {dispatchEvent(new Event(READY));
		}

		public function SequentialDependencyLoader(dependencies : Array) {
			queue = new Queue();
			for (var i : Number = 0;i < dependencies.length; i++) {
				var klass : Class = dependencies[i];
				var loaderDispatcher : XMLListLoaderDispatcher = new XMLListLoaderDispatcher(klass);
				queue.addMethod(loaderDispatcher, loaderDispatcher.start, XMLListLoaderDispatcher.READY);
				loaderDispatcher.addEventListener(ProgressEvent.PROGRESS, onLoadProgress)
				//queue.addMessage("loaded xml for " + getQualifiedClassName(klass));
			}
			queue.addEventListener(Event.COMPLETE, onReady);
			queue.go();
		}
		// called by anything that's loading
		private function onLoadProgress(event : ProgressEvent) : void {
			bytesLoaded = event.bytesLoaded;

		}

		private function onReady(event : Event) : void {
			dispatchReady();
		}

		public function getBytesLoaded() : Number {
			return bytesLoaded;
		}

//		public function getBytesTotal() : Number {
//			trace("warning - SequentialDependencyLoader.getBytesTotal() is not defined")
//			return null;
//		}
	}
}
