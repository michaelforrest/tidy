package com.lbi.animation.group {
	import com.lbi.animation.util.GroupCommon;
	import com.lbi.animation.util.IAnimation;

	import flash.events.Event;

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
	public class Set extends GroupCommon implements IAnimation {
		/**
		 * Use addAnimation or addQueue to populate the stack
		 */
		function Set(...$items){
			super($items);
		}

		public function stop(dispatchComplete:Boolean = false) : void {
			for(var i:String in items){
				var item:IAnimation = items[i];
				item.stop();
			}
			if(dispatchComplete) dispatchEvent(new Event("complete"));
		}
		public function go() : void {
			for (var i:Number=0; i<items.length; i++) {
				var item : IAnimation = items[i];
				item.addEventListener("complete", countFinishedAnims,false,0,true);
				item.go();
			}
		}
		public function isComplete():Boolean{
			return countItemsRemaining()==0;
		}
		private function countItemsRemaining():Number{
			var remaining:Number = 0;
			for(var i:Number=0;i<items.length; i++){
				var item:IAnimation = items[i];
				if(!item.isComplete()) remaining++;
			}
			return remaining;
		}
		private function countFinishedAnims(e:Event) : void {
			IAnimation(e.target).removeEventListener("complete",countFinishedAnims);

			var done:Boolean = true;
			for(var i:String in items){
				var item:IAnimation = items[i];
				if(!item.isComplete()) done=false;
			}
			if (done) {
				dispatchEvent(new Event("complete"));
				destroy();
			}
		}

		public function destroy() : void {
			for(var i:String in items){
				var s:IAnimation = items[i];
				s.destroy();
			}
			delete this;
		}
	}

}