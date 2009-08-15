package com.lbi.mvc.model {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import com.lbi.animation.group.Stack;
	/**
	 * @author michaelforrest
	 */
	public class ConcurrentDependencyLoader extends EventDispatcher {
		public static var READY : String = "ready";
		public function dispatchReady():void {dispatchEvent(new Event(READY));
		}
		public function ConcurrentDependencyLoader(dependencies : Array) {
			var stack : Stack = new Stack();
			for (var i : Number = 0;i < dependencies.length; i++) {
				var d : EventDispatcher = dependencies[i];
				stack.addMethod(d, null, Event.COMPLETE);
			}
			stack.addEventListener(Event.COMPLETE, onReady,false,0,true);
			stack.go();
		}

		private function onReady(event : Event) : void {
			dispatchReady();
		}
	}
}
