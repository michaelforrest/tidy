import com.lbi.core.events.EventDispatcher;
import com.lbi.framework.mvc.collection.Collection;
import com.lbi.framework.mvc.collection.Selectable;
import com.lbi.framework.mvc.io.xml.XMLListLoader;
import com.lbi.framework.mvc.io.xml.XMLModel;
/**
 * @author Michael Forrest
 */
class SampleClass {
	// A test variable
	private var x : Number;
	private static var y : Number;
	public static var z : Number;

	function SampleClass() {
		
	}

	public function get getter() : Number {
		return x;
	}

	public function set setter(x : Number) : Void {
		this.x = x;
	}
	
	private function privateMethod() : Number {
		return 0;
	}
	
	public function publicMethod() : String {
		return "public";
	}
}