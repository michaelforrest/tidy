package com.lbi.mvc.model {
	import flash.events.Event;

	import com.lbi.mvc.collection.Collection;

	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	/**
	 * @author michaelforrest
	 */
	public class EventMapper extends EventDispatcher implements IEventMapper {
		private var listeners : Collection;

		/**
		 * Use registerEvents to automatically wire up controller events to which this view must respond.
		 * So, if you do registerEvents(["complete","ready","pressed"]); you would then need to implement methods
		 * onComplete(e:Event), onReady(e:Event), onPressed(e:Event)
		 * @param events = an array of event names dispatched by the controller
		 */
		public function registerEvents(view : Object,events : Array) : void {
			for (var i : Number = 0; i < events.length; i++) {
				var event:String = events[i];
				var method_name:String = eventToMethodName(event);
				var responding_method:Function = view[method_name];
				if( responding_method === null ) {
					var msg:String ="Error - view class "+ getQualifiedClassName(view) + " does not implement " + method_name;
					throw new Error(msg);
				}
				addEventListener(event, responding_method,false,0,true);
				trackListener(view);
			}
		}


		public function getListeners() : Collection {
			return listeners;
		}

		public function unregisterEvents(view : Object, events : Array) : void {
			if(!events) return;
			for (var i : Number = 0; i < events.length; i++) {
				var event:String = events[i];
				removeEventListener(event,  view[eventToMethodName(event)]);
			}
			untrackListener(view);
		}

		public static function eventToMethodName(event : String) : String {
			return "on" +StringFormatting.pascalize(event);
		}

		private function trackListener(view : Object) : void {
			if(!listeners) listeners = new Collection();
			if(listeners.find(view)) return;
			listeners.add(view);
		}

		private function untrackListener(view : Object) : void {
			listeners.remove(view);
			//TODO: think about this properly. This doesn't make sense does it. Necessarily.
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

		protected function getAllListeners() : void {

		}

	}
}
