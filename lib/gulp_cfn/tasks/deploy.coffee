path    = require "path"
GulpCfn = require "../../gulp_cfn"

module.exports = (gulp, config) ->

  GulpCfn.Cfn.releaseNames(config.release_names)

  deploy = (stack) ->
    cfn     = config.stacks[stack]
    cfn.cfn = path.resolve(cfn.cfn)
    new GulpCfn.Cfn(stack, cfn).deploy()

  gulp.task "deploy", ->
    if process.env.STACK
      deploy(process.env.STACK)
    else
      console.log "\nPlease provide a STACK env variable.\n"
  
  for stack, cfn of config.stacks
    gulp.task "deploy:#{stack}", ->
      deploy(stack)
