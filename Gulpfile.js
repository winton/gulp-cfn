var GulpCfn = require("./lib/gulp_cfn");
var gulp    = require("gulp");

new GulpCfn(gulp, {
	release_names: {
		adjectives: [ "beautiful" ],
		nouns:      [ "mind" ]
	},
	stacks: {
		my_app: {
			cfn: "example/cfn.coffee"
		}
	}
});
