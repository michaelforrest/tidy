package com.lbi.mvc.helper {
	import flash.utils.ByteArray;	
	/**
	 * @author michaelforrest
	 */
	public class Cloner {
		// from kirupa
		public static function clone(source:Object):* {
		    var copier:ByteArray = new ByteArray();
		    copier.writeObject(source);
		    copier.position = 0;
		    return(copier.readObject());
		}
	}
}
