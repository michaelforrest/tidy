package com.lbi.animation.util {
	import flash.events.IEventDispatcher;

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
	* IAnimation is used for any class that you can tell go() and dispatches "complete" when it has finished doing whatever it was doing
	 */
	[Event("complete")]
	public interface IAnimation extends IEventDispatcher {
		function go() : void;
		function destroy() : void;
		function stop(dispatchComplete:Boolean = false) : void;
		function isComplete():Boolean;
	}
}