requireDirectory = require("require-directory")

# Adds CloudFormation tasks to Gulp.
#
class GulpCfn

  # Load gulp tasks. Silence gulp if necessary.
  #
  # @param [Object] @gulp instance of gulp
  # @param [Object] @containers container information object
  #
  constructor: (@gulp, @config) ->
    @tasks = requireDirectory(module, "./gulp_cfn/tasks")
    fn(@gulp, @config) for task, fn of @tasks

require("./gulp_cfn/cfn")(GulpCfn)

module.exports = GulpCfn
