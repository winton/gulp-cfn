NodeCfn = require "node-cfn"
Promise = require "bluebird"

module.exports = (GulpCfn) -> 

  # Entry point for building Docker images and running containers.
  #
  class GulpCfn.Cfn

    # Initializes the stack name and configuration.
    #
    # @param [Object] @stack stack name
    # @param [Object] @cfn CloudFormation configuration object
    #
    constructor: (@stack, @cfn) ->

    # Deploy a CloudFormation stack.
    #
    deploy: ->
      new NodeCfn.Aws.Stack(@stack, @cfn.cfn).create()

    # Update release names.
    #
    # @param [Object] names an object with adjectives and nouns
    #
    @releaseNames: (names) ->
      NodeCfn.NameGen.adjectives = names.adjectives;
      NodeCfn.NameGen.nouns      = names.nouns;
