package common;

import js.Browser;
import js.html.Text;

@:expose
class BaseSubModule {
	public var view:Text;

	public function new(name:String) {
		view = Browser.document.createTextNode("Hello, " + name + " module");
	}
}