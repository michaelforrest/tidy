package com.lbi.debug {
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	/**
	 * @author michaelforrest
	 */
	public class KeySequenceTrigger extends EventDispatcher {
		private var trigger : String;

		private var next_character_index : Number = 0;
		private static var stage : Stage;
		public static const TRIGGERED : String = "triggered";

		function KeySequenceTrigger($trigger : String) {
			super();
			if(!stage) throw new Error("Sorry - you need to initialise KeySequenceTrigger in your app so that it can listen to the stage. Do this in AppView after it has been instantiated");
			trigger = $trigger;
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp,false,0,true);

		}

		private function onKeyUp(e : KeyboardEvent) : void {
			if(e.charCode==getNextCharacterCode()){
				if(isLastCharacter()){
					dispatchEvent(new Event(TRIGGERED));
					reset();
				}
			}
			else{
				reset();
			}
		}
		private function getNextCharacterCode() : Number {
			var c:Number = trigger.charCodeAt(next_character_index);
			next_character_index++;
			return c;
		}

		private function isLastCharacter() : Boolean {
			return next_character_index >= trigger.length;
		}

		private function reset() : void {
			next_character_index = 0;
		}

		public static function init($stage : Stage) : void {
			stage = $stage;
		}

		public static function makeTriggers(triggers : Array) : void {
			for (var i : Number = 0; i < triggers.length; i++) {
				var trigger:Object = triggers[i];
				new KeySequenceTrigger(trigger.trigger).addEventListener(TRIGGERED, trigger.action,false,0,true);
			}
		}
	}
}
