path    = require "path"
GulpCfn = require "../../gulp_cfn"

module.exports = (gulp, config) ->

  GulpCfn.Cfn.releaseNames(config.release_names)
  
  for stack, cfn of config.stacks
    gulp.task "deploy:#{stack}", ->
      cfn.cfn = path.resolve(cfn.cfn)
      new GulpCfn.Cfn(stack, cfn).deploy()
