package;

import js.Browser;
import js.html.DivElement;
import application.Test;
import framework.Require;

class Main {
	var root:DivElement;
	var me:Test;
	
	static function main() {
		var app = new Main();
	}
	
	public function new() {
		trace('Loading application');
		Require.module('application', initApplication, applicationFailed);
	}

	function initApplication(name:String) {
		trace('Application loaded');
		me = new Test();
	}
	
	function applicationFailed(name:String) {
		trace('Application load failed');
	}
}