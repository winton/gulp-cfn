Promise = require "bluebird"
path    = require "path"
GulpCfn = require "../../gulp_cfn"

module.exports = (gulp, config) ->

  GulpCfn.Cfn.releaseNames(config.release_names)

  run = (name, fn, fn_param) ->
    stack = config.stacks[name]

    if stack
      stack.cfn = path.resolve(stack.cfn)
      new GulpCfn.Cfn(name, stack)[fn](fn_param)
    else
      Promise.try -> throw "please specify a correct STACK env variable"

  gulp.task "deploy", ->
    run(process.env.STACK, "deploy")

  gulp.task "deploy:restart", ->
    run(process.env.STACK, "instances", "restart")
  
  for name, stack of config.stacks

    gulp.task "deploy:#{name}", ->
      run(name, "deploy")

    gulp.task "deploy:restart:#{name}", ->
      run(name, "restart")
    
