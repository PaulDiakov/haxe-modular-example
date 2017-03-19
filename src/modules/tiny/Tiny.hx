package modules.tiny;

import modules.tiny.sub.SubModule;
import common.BaseModule;

@:expose
@:keep
class Tiny extends BaseModule {
	public var sub:SubModule;

	public function new() {
		super();
		sub = new SubModule('Tiny');
		view.appendChild(sub.view);
	}
}