package com.lbi.media {
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;	
	/**
	 * @author michaelforrest
	 */
	public interface IBufferable {
		function get bytesLoaded() : uint;

		function get bytesTotal() : int;

		function get isBuffering() : Boolean;

		function load(stream : URLRequest, context : SoundLoaderContext = null) : void;
	}
}
