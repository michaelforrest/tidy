package com.lbi.mvc.model {	import flash.events.Event;	import flash.events.EventDispatcher;	import flash.events.IOErrorEvent;	import flash.events.ProgressEvent;	import flash.net.URLLoader;	import flash.net.URLRequest;		import com.lbi.debug.Log;	import com.lbi.mvc.collection.Collection;			/**	 * @author michaelforrest	 */	public class XMLListLoader extends EventDispatcher {		private var url : String;		private var item_class :  Class;
		private var path_to_items : String;		
		private var collection : Collection;
		private static const READY : String = "ready";		private var loader : URLLoader;
		public function XMLListLoader($url : String,$item_class : Class, $path_to_items : String) {			super();			url = $url;			item_class = $item_class;			path_to_items = $path_to_items;			loadXML();		}
		private function loadXML() : void {			var xml_request : URLRequest = new URLRequest(url);			loader = new URLLoader();			loader.addEventListener(Event.COMPLETE, onLoad);			loader.addEventListener(ProgressEvent.PROGRESS, onProgress);			loader.addEventListener(IOErrorEvent.IO_ERROR, onError);			loader.load(xml_request);		}
		private function onError(event : IOErrorEvent) : void {			trace("failed to load " + url);
		}		private function onProgress(event : ProgressEvent) : void {		}
		
		private function onLoad(event : Event) : void {			var xml : XML = new XML(loader.data);			prepare(xml);			dispatchEvent(new Event(READY));	 		}
		private function prepare(xml:XML) : void {			collection = new Collection();						var models:XMLList = xml.descendants(path_to_items);			if(models.length() == 0){				 Log.warn("No '" + path_to_items + "' nodes found in " + url);				 Log.debug("xml:" + xml);			}			for (var i : Number = 0;i < models.length(); i++) {				var model : XML = models[i];				var parsed_model : Object = new item_class(model);				collection.AS3::push(parsed_model);			}		}
		public function getItems() : Array {			return collection;		}
		public static function initialize($class : Class, $collection_name : String, $xml_url : String, $path_to_items : String) : EventDispatcher {			var __events__ : EventDispatcher = new EventDispatcher();			var __loader__ : XMLListLoader = new XMLListLoader($xml_url, $class, $path_to_items);			var __onXMLLoaded : Function = function() : void {				$class[$collection_name] = __loader__.getItems();				__events__.dispatchEvent(new Event(Event.COMPLETE));			};			__loader__.addEventListener(READY, __onXMLLoaded);			return __events__;		}
	}}