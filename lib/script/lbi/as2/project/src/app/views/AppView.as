import com.lbi.core.helper.Attach;
import com.lbi.framework.mvc.view.ViewBase;

import app.models.App;
/**
 * <%= credit %>
 */
class app.views.AppView extends ViewBase {
	private var app : App;
	
	public static function create ( $parent : MovieClip, $depth : Number ) : AppView
	{
		return Attach.MovieClipClass($parent,AppView, $depth);     
	}
	public function AppView() {
		app = App.getInstance();
		app.registerEvents(this, [App.READY], "AppView");
	}
	private function onReady () : Void {
	}
}