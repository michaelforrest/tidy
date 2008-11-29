#-partial
import app.models.<%=model_name%>;

public static var READY : String = "ready";
private function dispatchReady():Void {dispatchEvent(new Event(READY));}

public function App() {
	var events : EventDispatcher = <%=model_name%>.prepare();
	events.addEventListener(READY, Delegate.create(this,onPrepared));
}

private function onPrepared() : Void {
	dispatchReady();
}