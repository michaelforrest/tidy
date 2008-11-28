package com.lbi.mvc.collection {
	import flash.events.Event;	import com.lbi.mvc.model.EventMapper;
	public class Selectable extends EventMapper implements ISelectable{

		public static const SELECTED : String = "selected";
		protected function dispatchSelected():void {dispatchEvent(new Event(SELECTED));}
		public static const DESELECTED : String = "deselected";
		private var __id__ : String;
		private static var next_id : Number = -1;

		private function dispatchDeselected():void {dispatchEvent( new Event(DESELECTED));}

		protected var __selected__ : Boolean = false;

		public function Selectable() {
			__id__ = "selectable_" + next_id++;
		}

		public function select() : void {
			if(__selected__) return;
			__selected__ = true;
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
		}		public function getID() : String {
			return __id__;
		}
	}
}
