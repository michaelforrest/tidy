import com.lbi.core.events.EventDispatcher;
import com.lbi.framework.mvc.collection.Collection;
import com.lbi.framework.mvc.collection.Selectable;
import com.lbi.framework.mvc.io.xml.XMLListLoader;
import com.lbi.framework.mvc.io.xml.XMLModel;

/**
 * <%= credit %>
 */
class app.models.<%=model_name%> extends Selectable {
	public static var <%= collection_name%>  : Collection;
	private static var XML_URL : String = "xml/<%=collection_name%>.xml";
	private static var PATH_TO_COLLECTION : String = "<%= path_to_collection %>";
	public static function prepare() : EventDispatcher{
		return XMLListLoader.initialize(<%=model_name%>, 
										"<%= collection_name%>", 
										XML_URL, 
										PATH_TO_COLLECTION);
	}
	/* 
	* Instance variables start here 
	*/
	private var id : String;
	private var title : String;
	function <%=model_name%> ($model : XMLModel) {
		// TODO: map xml parameters onto this instance
		id = $model.id;
		title= $model.title;
	}
	public function getTitle() : String{
		return title;
	}
	public static function selectFirst() : Void {
		<%= collection_name%>.select(<%= collection_name%>.first());
	}
	public static function find($id : String) : <%=model_name%>{
		return <%=model_name%>(<%=collection_name%>.findByProperty("id",$id));
	}
	public static function select($item : <%=model_name%>) : Void{
		<%=collection_name%>.select($item);
	}
}
