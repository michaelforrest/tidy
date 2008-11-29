import com.lbi.core.helper.Attach;
import com.lbi.framework.mvc.collection.Collection;
import com.lbi.framework.mvc.view.ViewBase;

import app.models.<%=model_name%>;
import app.views.<%=package_name%>.<%=model_name%>View;
/**
 * @author michaelforrest
 */
class app.views.<%=package_name%>.<%=model_name%>sView extends ViewBase {
	private var <%=collection_name%> : Collection;
	
	public static function create ( $parent : MovieClip, $depth : Number ) : <%=model_name%>sView
	{
		return Attach.MovieClipClass($parent,<%=model_name%>sView, $depth);     
	}
	public function <%=model_name%>sView() {
		super();
		// assume that the tracks have loaded by now
		<%=collection_name%> = <%=model_name%>.<%=collection_name%>;
		addTracks();
	}
	
	private function addTracks() : Void {
		var y : Number = 0;
		for (var i : Number = 0; i < <%=collection_name%>.length; i++) {
			var <%=instance_name%>:<%=model_name%> = <%=collection_name%>[i];
			var view : <%=model_name%>View = <%=model_name%>View.create(<%=instance_name%>,this);
			view._y = y;
			y = view.getBottom();
		}
	}
}
