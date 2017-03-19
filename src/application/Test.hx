package application;

import js.Browser;
import js.html.DivElement;
import framework.Require;
import modules.dummy.Dummy;
import modules.mighty.Mighty;
import modules.tiny.Tiny;

@:expose
@:keep
class Test {
	var root:DivElement;
	
	public function new() {
		var doc = Browser.document;
		root = doc.createDivElement();
		root.className = 'main';
		doc.body.appendChild(root);
		
		var hello = doc.createDivElement();
		hello.innerText = 'Application loaded';
		root.appendChild(hello);

		var link = doc.createAnchorElement();
		link.href = '#';
		link.onclick = loadModules;
		link.innerText = 'Load modules';
		root.appendChild(link);
	}
	
	function loadModules() {
		loadModule('dummy', function(name:String) {
			initModule(name, new Dummy());
		});

		loadModule('mighty', function(name:String) {
			initModule(name, new Mighty());
		});

		loadModule('tiny', function(name:String) {
			initModule(name, new Tiny());
		});

		return false;
	}

	function loadModule(name:String, callback) {
		Require.module(name, callback, moduleFailed);
	}

	function initModule(name:String, module) {
		trace('Module $name loaded');
		root.appendChild(module.view);	
	}
	
	function moduleFailed(name:String) {
		trace('Module $name failed');
	}
}