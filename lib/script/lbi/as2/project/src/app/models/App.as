import com.lbi.core.events.Event;
import com.lbi.core.events.EventDispatcher;
import com.lbi.framework.mvc.model.EventMapper;
/**
 * <%= credit %>
 */
class app.models.App extends EventMapper {
	
	public static var READY : String = "ready";
	private function dispatchReady():Void {dispatchEvent(new Event(READY));}

	private static var instance : App;
	public static function getInstance() : App {
		if(!instance) instance = new App();
		return instance;
	}
	public function App() {
	
	}

	
}