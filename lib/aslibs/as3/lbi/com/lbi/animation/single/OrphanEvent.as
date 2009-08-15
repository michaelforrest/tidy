package com.lbi.animation.single {
	import com.lbi.animation.util.IAnimation;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	/**
	LBi Useful ActionScript 3 Library
	    Copyright (C) 2007 LBi / Michael Forrest

	    This library is free software; you can redistribute it and/or
	    modify it under the terms of the GNU Lesser General Public
	    License as published by the Free Software Foundation; either
	    version 2.1 of the License, or (at your option) any later version.

	    This library is distributed in the hope that it will be useful,
	    but WITHOUT ANY WARRANTY; without even the implied warranty of
	    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
	    Lesser General Public License for more details.

	    You should have received a copy of the GNU Lesser General Public
	    License along with this library; if not, write to the Free Software
	    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
	*/
	public class OrphanEvent extends EventDispatcher implements  IAnimation{
		public var is_complete:Boolean = false;
		private var object:IEventDispatcher;
		private var event:String;
		private var timeCreated:Number;
		public function get EventObject():IEventDispatcher{
			return object;
		}
		public function get EventName():String{
			return event;
		}

		public function OrphanEvent($object:IEventDispatcher, $event:String){
			object = $object;
			event = $event;
			object.addEventListener(event, dispatchCompleteEvent,false,0,true);
		}
		public function stop(dispatchComplete:Boolean = false) : void {
			destroy();
			if(dispatchComplete) dispatchCompleteEvent();
		}
		private function dispatchCompleteEvent(e : Event = null) : void {
			is_complete = true;
			dispatchEvent(new Event("complete"));
		}
		/**
		 *  go() does nothing, hence "Orphan".
		 */
		public function go() : void {
			is_complete = false;
		}

		public function isComplete():Boolean{
			return is_complete;
		}
		public function destroy() : void {
			object.removeEventListener(event, dispatchCompleteEvent);
		}
		override public function toString() : String {
			return object + " OrphanEvent " + timeCreated + ":"  + event ;
		}
		public function isOrphanEvent():Boolean{
			return true;
		}
		public function setFrames(frames : Number) : void {
			// don't do anything though.
		}

		public function getStructure() : String {
			return toString();
		}

	}
}