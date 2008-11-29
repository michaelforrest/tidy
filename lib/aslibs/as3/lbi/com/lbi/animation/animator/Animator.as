package com.lbi.animation.animator {
	import flash.utils.flash_proxy;

	import com.lbi.animation.animator.Transition;
	import com.lbi.mvc.collection.Searchable;
	/**
	LBi Useful ActionScript 3 Library
	 */
	 dynamic public class Animator extends Proxy{
		private var object : Object;
		private var transitions : Searchable;

		public function Animator($object : Object) {
			object = $object;
			transitions = new Searchable([]);
		}

		private function registerTransition($property : String) : Transition {
		}

		override flash_proxy function getProperty(name:*):* {
			return object[name];
		public function change($property:String):Transition{
			return getTransitionByProperty($property);
		}

		}
	}