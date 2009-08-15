package com.lbi.mvc.collection {
	import flash.events.Event;

	import com.lbi.mvc.model.EventMapper;
	public class Selectable extends EventMapper implements ISelectable{

		public static const SELECTED : String = "selected";

		// Gonna see how easy this makes testing!
		public static var lastSelectedThing : Selectable;




		protected function dispatchSelected():void {dispatchEvent(new Event(SELECTED));}
		public static const DESELECTED : String = "deselected";

		protected function dispatchDeselected():void {dispatchEvent( new Event(DESELECTED));}

		protected var __selected__ : Boolean = false;

		public function Selectable() {
		}

		public function select() : void {
			if(__selected__) return;
			__selected__ = true;
			lastSelectedThing = this;
			dispatchSelected();
		}

		public function deselect() : void {
			__selected__ = false;
			dispatchDeselected();
		}

		public function isSelected() : Boolean {
			return __selected__;
		}
		public static function initialize(object:ISelectable) : void{
			var inst : Selectable = new Selectable();
			//object["__selected__"] = inst["__selected__"];
			object["select"] = inst.select;
			object["deselect"] = inst.deselect;
			object["isSelected"] = inst.isSelected;
		}

	}
}
