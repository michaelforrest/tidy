package com.lbi.mvc.model {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import com.lbi.debug.Log;
	import com.lbi.mvc.collection.Collection;
import flash.utils.getQualifiedClassName;	/**
	 * @author michaelforrest
	 */
	public class XMLListLoader extends EventDispatcher {

		private static var loaders : Object = {};

		private var url : String;
		private var item_class :  Class;
		private var path_to_items : String;

		private var collection : Collection;
		private static const READY : String = "ready";
		private var loader : URLLoader;
		public function XMLListLoader($url : String,$item_class : Class, $path_to_items : String) {
			super();
			url = $url;
			item_class = $item_class;
			path_to_items = $path_to_items;
			loadOrAttachToLoaderInProgress();
			loadXML();
		}

		private function loadOrAttachToLoaderInProgress() : void {
//			if(loaders[url]!=null) {
//				trace("retrieving ")
//				loader = loaders[url];
//			}else{
				loader = new URLLoader();
				loaders[url] = loader;
//			}
		}

		private function loadXML() : void {
			var xml_request : URLRequest = new URLRequest(url);
			loader.load(xml_request);
			loader.addEventListener(Event.COMPLETE, onLoad,false,0,true);
			loader.addEventListener(ProgressEvent.PROGRESS, onProgress,false,0,true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onError,false,0,true);

		}
		private function onError(event : IOErrorEvent) : void {
			trace("failed to load " + url);
		}
		private function onProgress(event : ProgressEvent) : void {
			dispatchEvent(event);
		}

		private function onLoad(event : Event = null) : void {
			var xml : XML = new XML(loader.data);
			//trace("DATA FOUND FOR " + url + "? "  +(loader.data != null).toString().toUpperCase());
			prepare(xml);
			dispatchEvent(new Event(READY));
		}
		private function prepare(xml:XML) : void {
			collection = new Collection();

			var models:XMLList = xml.descendants(path_to_items);
			if(models.length() == 0){
				 Log.warn("No '" + path_to_items + "' nodes found in " + url);
				 Log.debug("xml:" + xml);
			}
			for (var i : Number = 0;i < models.length(); i++) {
				var model : XML = models[i];
				var parsed_model : Object = new item_class(model);
				collection.AS3::push(parsed_model);
			}
		}
		public function getItems() : Array {
			return collection;
		}
		public static function initialize($class : Class, $collection_name : String, $xml_url : String, $path_to_items : String) : XMLListLoaderDispatcher {
			var events : XMLListLoaderDispatcher = new XMLListLoaderDispatcher($class);
			var xmlListLoader : XMLListLoader = new XMLListLoader($xml_url, $class, $path_to_items);
			var callback : Function = function() : void {
				$class[$collection_name] = xmlListLoader.getItems();
				trace("Loaded ",  $class[$collection_name].length, "instances into", getQualifiedClassName($class) + "."  +$collection_name, "from", $xml_url);
				events.dispatchEvent(new Event(Event.COMPLETE));
			};
			xmlListLoader.addEventListener(READY, callback,false,0,true);
			var progressCallback : Function = function(e:ProgressEvent) : void{
				events.dispatchEvent(e);
			}
			xmlListLoader.addEventListener(ProgressEvent.PROGRESS, progressCallback,false,0,true);
			return events;
		}
	}
}
