import flash.geom.Rectangle;

import com.lbi.core.helper.Attach;
import com.lbi.debug.Log;
import com.lbi.framework.mvc.collection.Selectable;
import com.lbi.framework.mvc.view.ViewBase;
import com.lbi.helpers.view.SimpleDrawing;

import app.helpers.Colours;
import app.helpers.Typography;
import app.models.<%=model_name%>;
/**
 * <%= credit %>
 */
class app.views.<%=package_name%>.<%=model_name%>View extends ViewBase {
	private static var BACKGROUND : Rectangle = new Rectangle(0,0,400,50);
	private var <%=instance_name%> : <%=model_name%>;
	private static var BORDER_WIDTH : Number = 1;
	private static var BORDER_ALPHA : Number = 80;
	private var title : TextField;

	public static function create ( $track : <%=model_name%>, $parent : MovieClip ) : <%=model_name%>View
	{
		return Attach.MovieClipClass($parent,<%=model_name%>View,null,[$track]);
	}
	private function <%=model_name%>View($<%=instance_name%> : <%=model_name%>) {
		super();
		<%=instance_name%> = $<%=instance_name%>;
		addBackground();
		addTitle();
		<%=instance_name%>.registerEvents(this,[Selectable.SELECTED,
									Selectable.DESELECTED], "<%=model_name%>View");
		animator.registerTransition("_alpha");
	}

	private function addBackground() : Void {
		lineStyle(BORDER_WIDTH, Colours.GREY, BORDER_ALPHA);
		SimpleDrawing.rectangle(this, BACKGROUND, Colours.GREY, 50);
	}

	private function addTitle() : Void {
		title = Attach.TextField(this,new Typography(),null,BACKGROUND);
		title.text = <%=instance_name%>.getTitle();
	}

	function onPress() : Void {
		<%=model_name%>.<%=collection_name%>.select(<%=instance_name%>);
	}
	private function respondToSelected () : Void {
		Log.debug("selected " + <%=instance_name%>);
		animator._alpha = 100;
	}
	private function respondToDeselected () : Void {
		Log.debug("deselected " + <%=instance_name%>);
		animator._alpha = 30;
	}
	
	public function getBottom() : Number {
		return _y + _height;
	}
}
