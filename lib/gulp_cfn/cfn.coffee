NodeCfn = require "node-cfn"
Promise = require "bluebird"

module.exports = (GulpCfn) -> 

  # Entry point for building Docker images and running containers.
  #
  class GulpCfn.Cfn

    # Initializes the stack name and configuration.
    #
    # @param [String] @name stack configuration name
    # @param [String] @config stack configuration
    #
    constructor: (@name, @config) ->
      NodeCfn.Aws.updateRegion(@config.region)
      @stack = new NodeCfn.Aws.Stack(@name, @config)

    # Start a timer to continually check if a stack finished
    # deploying.
    #
    # @param [String] stack_name the CloudFormation stack name
    # @param [Function] resolve the function to run once the
    #   container is found
    # @return [Number] `setTimeout` id
    #
    checkFinished: (stack_name, resolve) ->
      process.stdout.write(".")

      @stack.api.describeStacks(
        StackName: stack_name
      ).then (output) =>
        status = output.Stacks[0].StackStatus

        if status != "CREATE_IN_PROGRESS"
          console.log ""
          resolve(status == "CREATE_COMPLETE")
        else
          Promise.delay(5000).then =>
            @checkFinished(stack_name, resolve)

    # Deploy a CloudFormation stack.
    #
    deploy: ->
      @stack.create().then =>
        new Promise(
          (resolve) =>
            @checkFinished(@stack.params.stack_name, resolve)
        ).then (success) =>
          if @config.deploySuccess && success
            @config.deploySuccess(@)

          if @config.deployFail && !success
            @config.deployFail(@)

    # Update release names.
    #
    # @param [Object] names an object with adjectives and nouns
    #
    @releaseNames: (names) ->
      NodeCfn.NameGen.adjectives = names.adjectives;
      NodeCfn.NameGen.nouns      = names.nouns;
