package com.lbi.media {
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;	
	/**
	 * @author michaelforrest
	 */
	public interface ITransportControllable {
		function play(startTime : Number = 0, loops : int = 0, sndTransform : SoundTransform = null) : SoundChannel;
		function pause() : void;
	}
}
