package;

#if macro
import haxe.io.Path;
import haxe.macro.Compiler;
import haxe.macro.Context;
import sys.FileSystem;
import sys.io.File;

class Stub {
	static inline var SCOPE = 'typeof exports != "undefined" ? exports : typeof window != "undefined" ? window : typeof self != "undefined" ? self : this';
	static inline var RE_EXPORT = '\\$$hx_exports\\["([a-z0-9_]+)"] = \\$';
	
	static public function modules() {
		Context.onAfterGenerate(generated);
	}
	
	static private function generated() {
		var output = Compiler.getOutput();
		if (!FileSystem.exists(output)) return;
		
		var moduleName = Path.withoutDirectory(Path.withoutExtension(output));
		var src = File.getContent(output);
		var reExport = new EReg(RE_EXPORT, 'gi');
		var search = src;
		var refs = new Array<String>();
		var indexes = new Array<Int>();
		var offset = 0;

		while (reExport.match(search)) {
			var name = reExport.matched(1);
			refs.push(name);
			var pos = reExport.matchedPos();
			indexes.push(offset + pos.pos);
			search = reExport.matchedRight();
			offset += pos.pos + pos.len;
		}
		
		src = addInjections(refs, indexes, src);
		src = addJoinPoint(src);
		
		File.saveContent(output, src);
	}
	
	static function addInjections(refs:Array<String>, indexes:Array<Int>, src:String) {
		var i = indexes.length - 1;
		
		while (i >= 0) {
			src = src.substr(0, indexes[i])
				+ 'var ${refs[i]} = ' 
				+ src.substr(indexes[i]);
			i--;
		}
		
		return src;
	}
	
	static function addJoinPoint(src:String) {
		return StringTools.replace(src, SCOPE, 'typeof $$hx_scope != "undefined" ? $$hx_scope : $$hx_scope = {}');
	}
	
}
#end