path    = require "path"
GulpCfn = require "../../gulp_cfn"

module.exports = (gulp, config) ->

  cfn = null

  GulpCfn.Cfn.releaseNames(config.release_names)

  deploy = (name) ->
    stack     = config.stacks[name]
    stack.cfn = path.resolve(stack.cfn)
    cfn       = new GulpCfn.Cfn(name, stack)

    cfn.deploy()

  gulp.task "deploy", ->
    if process.env.STACK
      deploy(process.env.STACK)
    else
      console.log "\nPlease provide a STACK env variable.\n"
  
  for name, stack of config.stacks
    gulp.task "deploy:#{name}", ->
      deploy(name)
