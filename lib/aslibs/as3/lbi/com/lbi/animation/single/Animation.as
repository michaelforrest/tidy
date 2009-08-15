package com.lbi.animation.single {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import com.lbi.animation.util.Engine;
	import com.lbi.animation.util.IAnimation;
	//import com.framfab.debug.Console;
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
	public class Animation extends EventDispatcher implements IAnimation {
		private var anim_function:Function;

		protected var num_frames:Number;
		private var current_frame:Number;
		private var start:Number;
		private var end:Number;
		private var increment:Number;
		private var isPlaying:Boolean = false;

		private var label:String = "";

		protected var is_complete:Boolean = true;

		private var __complete_event : Event;
		private var engine : Engine;

		public function get complete_event():Event{
			return __complete_event;
		}
		public function set complete_event(v:Event):void{
			__complete_event = v;
		}

		/**
		 * Animation class
		 * Version 1.1
		 * Enterframe function can now take the _previous_ value as its second parameter
		 * Example:
		 * <pre>
	 		private var my_animation:Animation;
			public function startAnimation(){
				my_animation = new Animation(this, myFrameAnimation, 0, 1, 15);
				my_animation.addEventListener("animationComplete", myCompleteFunction);
			}
			private function myFrameAnimation(n:Number){
			 	// use the appropriate easing function here
			 	// in this example, the _alpha value of my_mc needs to go from
			 	// 50 to 100 with easeInQuad
				n = Tweens.easeInQuad(n);
				my_mc._alpha = 50 + (50 * n);
			}
			private function myCompleteFunction(){
				trace("Animation complete!!");
			}
		 * </pre>
		 *
		 * @param instance - the instance to animate
		 * @param anim_function - a function that will be called each frame, with one argument (the current position in the animation)
		 * @param start - value to start with
		 * @param end - value to finish on
		 * @param num_frames - the number of frames in the animation
		 */
		function Animation($anim_function:Function, start:Number, end:Number, num_frames:Number){
			engine = Engine.getInstance();
			this.complete_event = new Event("complete");
			anim_function = $anim_function;
			/** make sure it's integer, and >=1 **/
			this.num_frames = Math.round(num_frames);
			this.num_frames = Math.max(this.num_frames, 1);
			setStart(start);
			setEnd(end);

		}
		public function setStart(n:Number) : void {
			start = n;
		}
		public function setEnd(n:Number) : void {
			end = n;
		}
		public function go() : void {
			is_complete =false;
			increment = (end - start) / num_frames;
			this.current_frame = 0;
			engine.addEventListener(Event.ENTER_FRAME, doAnimation,false,0,true);
			isPlaying = true;
		}
		public function destroy() : void {
			engine.removeEventListener(Event.ENTER_FRAME, doAnimation);
			delete this;
		}
		private function doAnimation(e:Event) : void {
			var p:Number = start + (current_frame * increment);
			current_frame ++;
			var n:Number = start + (current_frame * increment);
			anim_function(n,p);
			if(current_frame == num_frames){
				engine.removeEventListener(Event.ENTER_FRAME, doAnimation);
				isPlaying = false;
				is_complete = true;
				dispatchCompleteEvent();
				destroy();
			}
		}
		public function pause() : void {
			if(	isPlaying){
				engine.removeEventListener(Event.ENTER_FRAME, doAnimation);
			}else{
				engine.addEventListener(Event.ENTER_FRAME, doAnimation,false,0,true);
			}
		}
		public function stop(dispatchComplete:Boolean = false) : void {
			engine.removeEventListener(Event.ENTER_FRAME, doAnimation);
			isPlaying = false;
			is_complete = true;
			if(dispatchComplete) dispatchCompleteEvent();
		}

		public function addLabel(l:String) : void {
			label = l;
		}
		public function isComplete():Boolean{
			return is_complete;
		}
		public function setFrames(n:Number) : void {
			this.num_frames = n;
		}
		public function getFrames():Number{
			return num_frames;
		}
		public function getCurrentFrame():Number{
			return current_frame;
		}
		override public function toString() : String {
			return getType() + " "  + label + ", playing: "+ isPlaying;
		}
		public function getType():String {
			return "animation " ;
		}
		private function dispatchCompleteEvent() : void {
			dispatchEvent(complete_event);
		}

		public function getStructure() : String {
			return toString();
		}

		public function setCompleteDelegate(delegate : Function) : void {

		}

		public function getCompleteDelegate() : Function {
			return null;
		}

	}
}