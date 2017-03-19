package framework;

import js.Browser;
import js.html.LinkElement;
import js.html.ScriptElement;

class Require {
	static public var jsPath = './build/';
	static var required:Array<String> = new Array();
	
	static public function module(name:String, callback, failureCallback) {
		if (required.indexOf(name) != -1) return;

		required.push(name);

		var doc = Browser.document;
		var script:ScriptElement = null;
		
		script = doc.createScriptElement();
		
		script.onload = function () {
			callback(name);
		};
		script.onerror = function () {
			doc.body.removeChild(script);
			failureCallback(name);
		};
		
		script.src = jsPath + name + '.js';
		doc.body.appendChild(script);
	}
}