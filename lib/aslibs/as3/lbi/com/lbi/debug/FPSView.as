package com.lbi.debug {
	import com.lbi.mvc.helper.TypographyBase;
	import com.lbi.mvc.view.ViewBase;

	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.getTimer;

	/**
	 * @author michaelforrest
	 * (based on http://kaioa.com/node/83)
	 */
	public class FPSView extends ViewBase {
		private var last : uint = getTimer();
		private var ticks : uint = 0;
		private var label : TextField;

		public function FPSView() {
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage,false,0,true);
		}

		private function onAddedToStage(event : Event) : void {
			trace("made fps view");
			var style : TypographyBase = new TypographyBase();
			style.embed_fonts = false;
			style.font = "_sans";
			style.align = "right";
			columnWidth = stage.stageWidth;
			label = addTextField(style, new Rectangle(0,0,100,30));
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame,false,0,true);
		}

		private function onEnterFrame(event : Event) : void {
			ticks++;
			var now : uint = getTimer();
			var delta : uint = now - last;
			if (delta >= 500) {
				var fps : Number = ticks / delta * 1000;
				label.text = fps.toFixed(1) + " fps";
				ticks = 0;
				last = now;
			}
		}
	}
}
