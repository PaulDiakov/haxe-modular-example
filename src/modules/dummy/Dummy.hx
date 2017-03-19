package modules.dummy;

import modules.dummy.sub.SubModule;
import common.BaseModule;

@:expose
@:keep
class Dummy extends BaseModule {
	public var sub:SubModule;

	public function new() {
		super();
		sub = new SubModule('Dummy');
		view.appendChild(sub.view);
	}
}