GulpCfn = require "../../gulp-cfn"

module.exports = (gulp, config) ->

  for stack, cfn of configs.stacks
    gulp.task "deploy:#{stack}", ->
      new GulpCfn.Cfn(stack, cfn).deploy()
