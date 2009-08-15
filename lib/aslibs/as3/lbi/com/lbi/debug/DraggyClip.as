package com.lbi.debug {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	/**
	 * @author michaelforrest
	 */
	public class DraggyClip {
		public static function initialize(sprite : Sprite) : void {

			sprite.mouseChildren = false;
			sprite.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown,false,0,true);
			sprite.addEventListener(MouseEvent.MOUSE_UP, onMouseUp,false,0,true)	;
			sprite.addEventListener(MouseEvent.ROLL_OVER, addKeyListener,false,0,true);
			sprite.addEventListener(MouseEvent.ROLL_OUT, removeKeyListener,false,0,true);

		}
		public static function addKeyListener(event:Event):void {
			var sprite : Sprite = event.target as Sprite;
			sprite.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyPress);

			sprite.alpha = 50;
			//SimpleDrawing.outline( sprite, 0xFF0000);
		}
		public static function removeKeyListener(event:Event):void{
			var sprite : Sprite = event.target as Sprite;
			//sprite.graphics.clear();
			sprite.removeEventListener(KeyboardEvent.KEY_DOWN, _onKeyPress);
		}
		public static function onMouseDown(event:MouseEvent):void{
			var sprite : Sprite = event.target as Sprite;
			if(!sprite) throw new Error(event.target + " was not a sprite ");
			sprite.startDrag();
		}
		public static function onMouseUp(event:MouseEvent):void{
			var sprite : Sprite = event.target as Sprite;
			sprite.stopDrag();
			trace("released ", sprite, " at ", sprite.x+","+sprite.y);
		}
		public static function _onKeyPress(event:KeyboardEvent):void{
			var sprite : Sprite = event.target as Sprite;
			var key_ascii : Number = event.keyCode;

			trace("pressed ", key_ascii);

			// = (equals) key
			if(key_ascii==0x3D){
				sprite.scaleX = sprite.scaleY = sprite.scaleX + 5;
			}
			// - (minus) key
			if(key_ascii==0x2d){
				sprite.scaleX = sprite.scaleY = sprite.scaleX - 5;
			}
			// _ (shift + minus) key
			if(key_ascii==0x2b){
				sprite.scaleX = sprite.scaleY = sprite.scaleX + .5;
			}
			// + (shift + plus) key
			if(key_ascii==0x5F){
				sprite.scaleX = sprite.scaleY = sprite.scaleX - .5;
			}
			// p ("print") key
			if(key_ascii==0x70){
				trace("Point(" + Math.round(sprite.x) + ", " + Math.round(sprite.y) +"), scale=" + sprite.scaleX + "("+  sprite + ")");
			}
			// t ("transparent") key
			if(key_ascii==0x74){
				sprite.alpha = 50;
			}
			// T ("untransparent") key
			if(key_ascii==0x54){
				sprite.alpha = 100;
			}
			var increment:Number = 1;
			if(event.ctrlKey){
				increment = 10;
			}
			if(key_ascii == Keyboard.LEFT) {

				sprite.x -= increment;
			}
			if(key_ascii == Keyboard.RIGHT) {
				sprite.x += increment;
			}
			if(key_ascii == Keyboard.UP){
				sprite.y -= increment;
			}
			if(key_ascii == Keyboard.DOWN){
				sprite.y += increment;
			}

		}
	}
}
