package com.lbi.animation.animator {
	import flash.events.Event;
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
	public class Transition extends EventDispatcher {
		public static var COMPLETE : String = "complete";
		private function dispatchComplete(e:Event):void {dispatchEvent(new Event(COMPLETE));}

		public static var DEFAULT_FRAMES : Number = 10;

		// These are the properties that you can change:
		public var frames : Number = DEFAULT_FRAMES;
		public var easing : Function;
		// end of properties you can change.

		public var property : String;
		private var object : Object;
		private var animation : Animation;
		private var cache : Number;

		private var start : Number;
		private var id : String;
		private var end : Number;

		public function Transition($object: Object, $property : String) {
			id = getTimer().toString();
			easing = Easing.easeOutCubic;
			object = $object;
			property = $property;
			cache = object[property];
			if(isNaN(cache)) Log.warn("Please set a default value for " + getQualifiedClassName($object) + "." + $property);
		}

			removeEventListener(type, listener); // make sure it can only be done once. I think..
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);

			interrupt();
			start = getCurrentValue();
			end = $target;
//			Log.debug("setting " + this + " end point to " + end );
			animation = new Animation(animate, 0, 1, frames);
			cache = object[property];
			animation.addEventListener("complete", dispatchComplete);
			animation.go();
		}
		public function interrupt() : void {
			if(animation) {
				animation.destroy();
				animation = null;
			}
		}

		private function animate(next:Number, prev:Number) : void {
			if(getCurrentValue()!=cache){// && !(cache is null)) {
				interrupt();
			}else{
				//Log.debug("setting " + object + "." + property + " to " + interpolate(easing(next)));
				try{
					object[property] = interpolate(easing(next));
				}catch(e:Error){
					Log.error("Error in animate" +  e.toString());
				}
			}
			cache = getCurrentValue();
//			Log.debug("animated " + this + " to " + cache);
		}

		public function getProperty() : String {
			return property;
		}

		private function getCurrentValue() : Number {
			return object[property];
		}

		private function interpolate(pos : Number) : Number {
			return pos * (end-start) + start;
		}
		/**
		 * returns this Transition so that settings can be chained.
		 */
		public function setFrames($frames:Number) : Transition{
			frames = $frames;
			return this;
		}
		/**
		 * returns this Transition so that settings can be chained
		 */
		public function setEasing($function:Function) :Transition{
			easing = $function;
			return this;
		}
		override public function toString() : String{
			return "[Transition "+ id + "]";
		}
}