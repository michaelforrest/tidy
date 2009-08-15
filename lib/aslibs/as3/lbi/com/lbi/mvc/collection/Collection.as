package com.lbi.mvc.collection {
	use namespace AS3;
	import com.lbi.mvc.model.EventMapper;
	import com.lbi.mvc.model.IEventMapper;

	import flash.events.Event;
	public dynamic class Collection extends Array implements IEventMapper{
		public static var CHANGED : String = "changed";
		private function dispatchChanged():void {event_mapper.dispatchEvent(new Event(CHANGED));}

		public static var INCREASED : String = "increased";
		private function dispatchIncreased():void {event_mapper.dispatchEvent(new Event(INCREASED));}

		public static var DECREASED : String = "decreased";
		private function dispatchDecreased():void {event_mapper.dispatchEvent(new Event(DECREASED));}

		public static var CHANGED_SIZE : String = "changed_size";
		private function dispatchChangedSize():void {event_mapper.dispatchEvent(new Event(CHANGED_SIZE));}

		public var event_mapper : EventMapper;

		private var __index:Number;
		private var __previous_index:Number = 0;

		private function get _index():Number{
			return __index;
		}
		private function set _index(v:Number):void{
			__previous_index = __index;
			__index = v;
			_current = this[__index];
		}

		private var __current:Object;
		private function get _current():Object{
			return __current;
		}
		private function set _current(v:Object):void{
			__current = v;
			try{
				__current.select();
			}catch(e : Error){
				throw new Error("You probably need to make " + __current + " extend Selectable. " + e);
			}
		}

		public var loop : Boolean;

		private var __id__ : Number;
		private static var __next_id__ : Number = 0;
		function Collection(...$init_items){//$array: Array,$loop:Boolean) {
			super();
			//importArray($array);
			//loop = $loop;
			event_mapper = new EventMapper();
			//EventMapper.initialize(this);
			__id__ = __next_id__++;
			if($init_items && $init_items[0]) {
				for (var i : Number = 0; i < $init_items[0].length; i++) {
					var item:Object = $init_items[0][i];
					add(item);
				}
			}
		}
		public function selectFirst() :void{
			select(first());
		}
		/**
		 * Copies a normal array into this collection.
		 */
		public function importArray($array : Array) :void{
			while(length>0) pop();
			for (var i : Number = 0; i < $array.length; i++) {
				push($array[i]);
			}
		}
		/**
		 * Returns currently selected item
		 */
		public function current() : Object {
			//if(!_current) Log.warn("nothing is yet selected in " + this);
			return _current;
		}
		public function previouslySelected() : Object{
			return this[getPreviousIndex()];
		}
		public function hasNext() : Boolean {
			return _index+1 < length && length > 0;
		}
		/**
		 * If there is another item in the collection after the current (or the collection is looped) then
		 * this method selects the next item and dispatches Collection.INCREASED, then Collection.CHANGED
	 	 * The selected item conventionally dispatches SELECTED and DESELECTED events, encouraged via the use of the ISelectable interface.
		 */
		public function next() : void {
			if(!hasNext() && !loop) return;
			ISelectable(current()).deselect();
			if(hasNext()){
				_index++;
				dispatchIncreased();
			}
			else{
				_index = 0;
			}
			dispatchChanged();
		}

		public function hasPrev() : Boolean {
			return _index > 0;
		}
		/**
		 * If there is another item in the collection before the current (or the collection is looped) then
		 * this method selects the previous item and dispatches Collection.DECREASED, then Collection.CHANGED.
		 * The selected item conventionally dispatches SELECTED and DESELECTED events, encouraged via the use of the ISelectable interface.
		 */
		public function previous() : void {
			if(!hasPrev() && !loop) return;
			ISelectable(current()).deselect();
			if(hasPrev()){
				_index --;
				dispatchDecreased();
			}
			else{
				_index = length-1;
			}
			dispatchChanged();
		}
		/**
		 * selects the required item by reference.
		 * This is useful when you have a button in your view that holds a reference to an item model.
		 * The view can simply call collection.select(model) and the collection will be updated.
		 */
		public function select($item:Object):void{
			if(current()) ISelectable(current()).deselect();
			for (var i : Number = 0; i < this.length; i++) {
				var item : Object = this[i];
				if(item === $item) {
					_index = i; // selects the current item
				}
			}
			dispatchChanged();
		}
		/*
		 * Sets selection to null
		 */
		public function deselect():void{
			if(current()) ISelectable(current()).deselect();
			__index = NaN;
			__current = null;
			//dispatchChanged();
		}

		/**
		 * Removes an item from the collection
		 */
		public function remove($item:Object) : Object{
			for (var i : Number = 0; i < this.length; i++) {
				var item:Object = this[i];
				if(item===$item) {
					AS3::splice(i,1);
//					_index = getIndex(current());
					dispatchChangedSize();
					return item;
				}
			}
			return null;
		}
		/**
		 * finds (without selecting) an item in the array based on the object reference.
		 */
		public function find($item:Object) : Object{
			for (var i : Number = 0; i < this.length; i++) {
				var item:Object = this[i];
				if(item===$item) {
					return item;
				}
			}
			return null;
		}
		public function first() : Object{
			return this[0];
		}
		public function last() : Object{
			return this[length-1];
		}

		public function getCurrentIndex() :Number{
			return _index;
		}
		/**
		 * Returns the index of the specified item in this array.
		 */
		public function getIndex($item:Object) : Number{
			for (var i : Number = 0; i < this.length; i++) {
				var item:Object = this[i];
				if(item==$item) return i;
			}
			return Number.NaN;
			//Log.error("Couldn't find item " + $item + " in Collection " + this);
		}
		public function toString() :String{
			var result : String = "[Collection id:" + __id__ ;
			for (var i : Number = 0; i < length; i++) {
				var item:Object = this[i];
				result += item.toString() + ",";
			}
			return result +"]";
		}

		public function registerEvents(view : Object, events : Array) : void {
			event_mapper.registerEvents(view, events);
		}

		public function findByProperty($property : String, value : Object) : Object {
			for (var i : Number = 0; i < this.length; i++) {
				var item:Object = this[i];
				if(item[$property]==value) return item;
			}
			return null;
		}

		public function findByExactProperty($property : String, value : Object) : Object {
			for (var i : Number = 0; i < this.length; i++) {
				var item:Object = this[i];
				if(item[$property]===value) return item;
			}
			return null;
		}
		public function append(collection:Collection) : void{
			for (var i : Number = 0; i < collection.length; i++) {
				var item:Object = collection[i];
				push(item);
			}
		}

		public function push(value:Object):Number{
			var result : Number = super.push(value);
			dispatchChangedSize();
			return result;
		}
		public function add(value:Object) : Number{
			var result : Number = super.push(value);
			dispatchChangedSize();
			return result;
		}

		public function getPreviousIndex() : Number {
			return __previous_index;
		}
		public function clone() : Collection{
			return new Collection(this);
		}
		public function reverse() : Collection{
			return new Collection(super. reverse());
		}

		public function dispatchEvent(event : Event) : Boolean {
			return event_mapper.dispatchEvent(event);
		}

		public function hasEventListener(type : String) : Boolean {
			return event_mapper.hasEventListener(type);
		}

		public function willTrigger(type : String) : Boolean {
			return event_mapper.willTrigger(type);
		}

		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void {
			event_mapper.removeEventListener(type, listener);
		}

		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {
			event_mapper.addEventListener(type, listener,false,0,true);
		}

		public function unregisterEvents(view : Object, events : Array) : void {
			event_mapper.unregisterEvents(view, events);
		}
//		override public function toString() : String {
//			return "[Collection" + join(",") + "]";
//		}
		public function findAll(query : String) : Collection {
			var results : Collection = new Collection();
			try{
				for (var i : int = 0; i < this.length; i++) {
					var item : Matchable = this[i];
					if(item.matches(query)) results.add(item);
				}
			} catch(e :Error){
				throw new Error("You probably need to make " + this[0] + " implement Matchable. "+ e);
			}
			return results; 
		}
	}
}
