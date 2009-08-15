package com.lbi.mvc.model {
	import com.lbi.mvc.model.EventMapper;
	import com.lbi.mvc.model.SequentialDependencyLoader;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	/**
	 * @author michaelforrest
	 */
	public class Application extends EventMapper {
		public static var READY : String = "ready";
		public function dispatchReady() : void {dispatchEvent(new Event(READY));
		}

		private var dependencyLoader : SequentialDependencyLoader;

		protected var dependencies : Array;

		public function Application() {
			setup();
			dependencyLoader  = new SequentialDependencyLoader( dependencies);//.map(prepare));
			dependencyLoader.addEventListener(SequentialDependencyLoader.READY, onXMLReady,false,0,true);
		}



		private function prepare(element : *, index : int, arr : Array) : EventDispatcher {
			if(!element.prepare) throw new Error("Please create a prepare() : EventDispatcher {} event on class " +  getQualifiedClassName(element));
			return element.prepare();
		}

		protected function setup() : void {
			dependencies = [];
		}
		private function onXMLReady(event : Event) : void {
			afterLoaded();
			dispatchReady();
		}

		protected function afterLoaded() : void {
		}

	}
}
