package com.lbi.animation.single {
	import flash.display.DisplayObject;
	
	import com.lbi.animation.single.Animation;
	import com.lbi.animation.util.Easing;	
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
	public class Tween extends Animation{
		private var property_name:String;
		private var property_start:Number;
		private var property_end:Number;
		private var delta:Number;
		private var object:Object;
		private var ease:Function;
		/**
		 * Tween handles simple MovieClip property animations - all animations will start from the property's current value
		 * Example:
		 * <pre>
		 * var fade_animation:Tween = new Tween(my_mc, "_alpha", 50, 20, Easing.easeInCubic);
		 * fade_animation.go();
		 * </pre>
		 * @see com.lbi.animation.Animation
		 */
		function Tween(object:DisplayObject, property_name:String, target_value:Number, frames:Number, easing:Function = null) {
			super(tweenValue, 0, 1, frames);
			if(easing == null) ease = Easing.linearTween;
			this.object = object;
			this.property_name = property_name;
			property_end = target_value;
			
		}
		public function setTargetValue(v:Number) : void {
			property_end = v;	
		}
		override public function go() : void {
			is_complete = false;
			this.property_start = object[property_name];	
			this.delta = (property_end - object[property_name]);
			super.go();	
		}
		private function tweenValue(n:Number,p:Number) : void {
			n = ease(n);
			object[property_name] = (n * delta ) + property_start; 
		}
		
		public function getTweenValues ( ) : Array
		{
			property_start = object[property_name];	
			delta = (property_end - property_start);
			var res_arr:Array = [];
			for(var i:Number=0; i<num_frames; i++){
				res_arr.push( ease(i / (num_frames + 1)) * delta + property_start );
			}
			return res_arr;
		}
	}
	}