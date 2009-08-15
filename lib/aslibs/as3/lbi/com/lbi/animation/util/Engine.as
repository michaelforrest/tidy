package com.lbi.animation.util {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * @author michaelforrest
	 */
	public class Engine extends EventDispatcher {
		private static var instance : Engine;
		private var timer : Timer;

		public function Engine() {
			timer = new Timer(1000/30);
			timer.addEventListener(TimerEvent.TIMER, advanceFrame,false,0,true);
			timer.start();
		}

		public static function getInstance() : Engine {
			if(!instance) instance = new Engine();
			return instance;
		}
		public static function advanceFrames(number_of_frames : Number) : void {
			if(!instance) getInstance();
			for (var i : Number = 0; i < number_of_frames; i++) {
				instance.advanceFrame();
				
			}
		}

		private function advanceFrame(e:TimerEvent = null) : void {
			dispatchEvent(new Event(Event.ENTER_FRAME));
		}
	}
}
