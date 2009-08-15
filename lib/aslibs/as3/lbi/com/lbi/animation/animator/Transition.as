package com.lbi.animation.animator {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;

	import com.lbi.animation.single.Animation;
	import com.lbi.animation.util.Easing;
	import com.lbi.debug.Log;
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
		private function dispatchComplete(e:Event):void {
			animation = null;
			dispatchEvent(new Event(COMPLETE));
		}

		public static var DEFAULT_FRAMES : Number = 10;
		public static var DEFAULT_EASING : Function = Easing.easeOutCubic;

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
		private var threshold : Number = -1;
		private static const THRESHOLD_CROSSED : String = "threshold_crossed";
		private var end : Number;

		public function Transition($object: Object, $property : String) {
			id = getTimer().toString();
			easing = DEFAULT_EASING;
			object = $object;
			property = $property;
			cache = object[property];
			if(isNaN(cache)) Log.warn("Please set a default value for " + getQualifiedClassName($object) + "." + $property);
		}

		override public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {
			removeEventListener(type, listener); // make sure it can only be done once. I think..
			super.addEventListener(type, listener, useCapture, priority, true);
		}

		public function trigger($target : Number) : void {
			interrupt();
			start = getCurrentValue();
			end = $target;
//			Log.debug("setting " + this + " end point to " + end );
			animation = new Animation(animate, 0, 1, frames);
			cache = object[property];
			animation.addEventListener("complete", dispatchComplete,false,0,true);
			animation.go();
		}
		public function interrupt() : void {
			if(animation) {
				animation.destroy();
				animation = null;
			}
		}

		private function animate(next:Number, prev:Number) : void {
			if(getCurrentValue()!=cache){
				interrupt();
			}else{
				try {
					var v : Number = interpolate(easing(next));
					object[property] = v;
					if(threshold > -1 && v >= threshold){
						threshold = -1;
						dispatchEvent(new Event(THRESHOLD_CROSSED));
					}
				}catch(e:Error){
					Log.error("Error in animate" +  e.toString());
				}
			}
			cache = getCurrentValue();
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

		public function listenForThreshold(threshold : Number, callback : Function) : void {
			this.threshold = threshold;
			addEventListener(THRESHOLD_CROSSED, callback, false, 0, true);
		}

		public function isInProgress() : Boolean {
			return !(animation == null);
		}
	}
}