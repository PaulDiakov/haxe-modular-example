package modules.mighty;

import modules.mighty.sub.SubModule;
import common.BaseModule;

@:expose
@:keep
class Mighty extends BaseModule {
	public var sub:SubModule;

	public function new() {
		super();
		sub = new SubModule('Mighty');
		view.appendChild(sub.view);
	}
}