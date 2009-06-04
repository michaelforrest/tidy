package com.lbi.mvc.model {
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	/**
	 * @author michaelforrest
	 */
	public class EventMapper  extends EventDispatcher implements IEventMapper{
		/**
		 * Use registerEvents to automatically wire up controller events to which this view must respond.
		 * So, if you do registerEvents(["complete","ready","pressed"]); you would then need to implement methods
		 * onComplete(e:Event), onReady(e:Event), onPressed(e:Event)
		 * @param events = an array of event names dispatched by the controller
		 */
		public function registerEvents(view : Object,events : Array) : void {
			for (var i : Number = 0; i < events.length; i++) {
				var event:String = events[i];
				var pascalized:String = StringFormatting.pascalize(event);
				var method_name:String = "on"+pascalized;
				var responding_method:Function = view[method_name];
				if( responding_method === null ) {
					var msg:String ="Error - view class "+ getQualifiedClassName(view) + " does not implement " + method_name;
					throw new Error(msg);
				}
				/*var dispatching_method_name : String = dispatch+pascalized;
				var dispatching_method:Function = this[dispatching_method_name];
				var in_possible_events:Boolean = eventIsPossible(event);
				if(!dispatching_method && !in_possible_events){
					var msg:String = "Error - controller class for " + class_name_for_debugging + " - " + Introspector.getClassName(this) + " does not implement " + dispatching_method_name;
					msg+="\nEvents allowed by getPossibleEvents:" + getPossibleEvents().join(",");
					Log.error(msg);
					throw new Error(msg);
				}*/
				addEventListener(event,responding_method);
			}
		}
		public function unregisterEvents(view : Object, events : Array) : void {
			if(!events) return;
			for (var i : Number = 0; i < events.length; i++) {
				var event:String = events[i];
				removeEventListener(event,  view["on" +StringFormatting.pascalize(event)]);
			}
		}
		/**
		 * Override this method to return an array of strings that can be registered as events.
		 * This is useful if you want to dynamically generate event names (e.g. with keyboard controllers)
		 */
		private function getPossibleEvents():Array{
			return null;
		}
		private function eventIsPossible(event_name : String) : Boolean {
			var possible_events:Array = getPossibleEvents();
			for (var i : Number = 0; i < possible_events.length; i++) {
				var e:String = possible_events[i];
				if (e==event_name) return true;
			}
			return false;
		}

		// TODO: make this work!
		public function registerAllEvents(view : Object) : void {
		}

//		public static function initialize(object : IEventMapper) : void {
//			var inst : EventMapper = new EventMapper();
//			object["registerEvents"] = inst.registerEvents;
//			object["getPossibleEvents"] = inst.getPossibleEvents;
//			object["eventIsPossible"] = inst.eventIsPossible;
//		}
	}
}
