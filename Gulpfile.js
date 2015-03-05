var GulpCfn = require("./lib/gulp_cfn");
var gulp    = require("gulp");

new GulpCfn(gulp, {
	releases: {
		adjectives: [ "beautiful" ],
		nouns:      [ "mind" ]
	},
	stacks: {
		my_app: {
			cfn: "example/cfn.coffee"
		}
	}
});
