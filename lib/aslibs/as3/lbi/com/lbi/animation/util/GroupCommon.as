package com.lbi.animation.util {
	import com.lbi.animation.single.OrphanEvent;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	import com.lbi.animation.single.MethodWithCompleteEvent;
	import com.lbi.animation.util.IAnimation;
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
	public class GroupCommon extends EventDispatcher {
		protected var items:/*IAnimation*/ Array;
		private var label:String = "";
		public function GroupCommon(...$items) {
			items = new Array();
			//TODO: make the initialization work (I don't  really get these ... arguments yet.. sorry - MF)
			/*
			for(var i:Number=0; i<$items.length; i++){
				var item : Animation = $items[i];
				if(item != null) addAnimation(item);
			}*/
		}
		/**
		 * The only requirement is that the object:IEvent dispatches an event
		 * named in complete_event when it's finished its thang
		 * If you set complete_event to null or undefined, then the method is called synchronously.
		 * @param - the object executing the method
		 * @param - a delegate for the method to execute
		 */
		public function addMethod(object : IEventDispatcher, method:Function, complete_event:String , ...args) : void {
			var new_method : MethodWithCompleteEvent = new MethodWithCompleteEvent(object,method,complete_event,args);
			addItem(new_method);
		}
		protected function addItem(animation : IAnimation) : void {
			items.push(animation);
		}
		public function addAnimation(animation:IAnimation) : void {
			addItem(animation);
		}
		public function addLabel(l:String) : void {
			this.label = l;
		}
		public function waitForEvent(object : IEventDispatcher, event : String) : void {
			addItem(new OrphanEvent(object, event));
		}
	}
	}