package com.lbi.animation.animator {
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;

	import com.lbi.animation.animator.Transition;
	import com.lbi.mvc.collection.Searchable;
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
	 dynamic public class Animator extends Proxy{
		private var object : Object;
		private var transitions : Searchable;
		private var defaultFrames : Number = Transition.DEFAULT_FRAMES;
		private var defaultEasing : Function = Transition.DEFAULT_EASING;

		public function Animator($object : Object) {
			object = $object;
			transitions = new Searchable([]);
		}

		public function setDefaultFrames(n : Number) : void{
			defaultFrames = n;
		}
		public function setDefaultEasing(f : Function) : void{
			defaultEasing = f;
		}
		private function registerTransition($property : String) : Transition {
			var transition : Transition = new Transition(object,$property);
			transition.setFrames(defaultFrames);
			transition.setEasing(defaultEasing);
			transitions.push(transition);
			return transition;
		}

		override flash_proxy function getProperty(name:*):* {
			return object[name];
		}
        // called when setting dynamic variables
        override flash_proxy function setProperty(name:*, value:*):void {
			var transition : Transition = getTransitionByProperty(name);
			if(!transition) transition = registerTransition(name);
			transition.trigger(value as Number);
        }
		public function change($property:String):Transition{
			return getTransitionByProperty($property);
		}

		private function getTransitionByProperty($property : String) : Transition {
			return transitions.findByProperty("property", $property) as Transition || registerTransition($property);
		}
		public function isAnimating(property : String) : Boolean{
			var t : Transition=  getTransitionByProperty(property);
			if(!t) return false;
			return t.isInProgress();
		}
		public function listen(property:String, callback:Function, threshold : Number = 1):void{
			if(threshold == 1){
				change(property).addEventListener(Transition.COMPLETE, callback,false,0,true);
			}else{
				change(property).listenForThreshold(threshold, callback);
			}
		}
		public function unlisten(property:String,callback:Function) : void{
			change(property).removeEventListener(Transition.COMPLETE, callback);
		}
		public function wait(frames:Number):void{
			trace("wait not implemented") 
		}

	}
}