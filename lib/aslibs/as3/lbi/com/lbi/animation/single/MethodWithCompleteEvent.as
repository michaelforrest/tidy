package com.lbi.animation.single {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	import com.lbi.animation.util.IAnimation;

	[Event("complete")]
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
	public class MethodWithCompleteEvent extends EventDispatcher implements IAnimation {
		private var object : IEventDispatcher;
		private var method:Function;
		protected var complete:Boolean = false;

		private var complete_event : String;

		private var __arguments : Array;

		public function MethodWithCompleteEvent($object : IEventDispatcher = null, $method : Function = null, $complete_event : String = null, $args: Array = null){
			complete_event = $complete_event;
			object = $object;
			method = $method;
			__arguments = $args;
		}
		public function go() : void {
			if(complete_event) object.addEventListener(complete_event, onComplete,false,0,true);
			complete = false;
			if(method != null) method.apply(object,__arguments);
			if(!complete_event) onComplete(null);
		}
		protected function onComplete(e:Event) : void {
			complete = true;
			dispatchEvent(new Event("complete"));
		}
		public function destroy() : void {
			delete this;
		}

		public function stop(dispatchComplete : Boolean = false) : void {
			//my_object.stop();
			if(dispatchComplete) onComplete(null);
		}

		public function isComplete():Boolean{
			return complete;
		}
		public function setFrames(frames : Number) : void {
		}
		override public function toString():String{
			return "QueueMethod: ";
		}
		public function getStructure() : String {
			return toString();
		}

	}

}