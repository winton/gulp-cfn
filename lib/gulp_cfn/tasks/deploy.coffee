GulpCfn = require "../../gulp_cfn"

module.exports = (gulp, config) ->

  for stack, cfn of config.stacks
    gulp.task "deploy:#{stack}", ->
      new GulpCfn.Cfn(stack, cfn).deploy()
