package com.lbi.animation.single {
	import com.lbi.animation.single.Animation;
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
	public class Pause extends Animation {

		private var ease:Function;
		/**
		 * Pause creates a pause for a certain number of frames. This class can be used in conjunction with Queue.
		 * @see com.lbi.animation.Animation
		 * @see com.lbi.animation.Queue
		 */
		function Pause(frames:Number){
			super(pauseCheck, 0, 1, frames);
		}
		private function pauseCheck(n:Number, p:Number) : void {
		}
	}
}