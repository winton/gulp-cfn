GulpCfn = require("./lib/gulp_cfn")
NodeCfn = require("node-cfn")
gulp    = require("gulp")

new GulpCfn(gulp,
  release_names:
    adjectives: [
      "beautiful", "kind", "gracious", "humble", "present"
    ]
    nouns: [
      "mind", "body", "spirit", "nature", "tao", "pugs"
    ]
  stacks:
    test:
      cfn: "example/cfn.coffee"
      deployFail: (cfn) ->
        console.log "The CloudFormation deploy failed :("
      deploySuccess: (cfn) ->
        api  = new NodeCfn.Aws.Api.Ec2()
        name = cfn.stack.params.stack_name 

        console.log "Getting EC2 instance info..."

        api.listInstances(
          Filters: [
            Name: "tag:aws:cloudformation:stack-name"
            Values: [ name ]
          ]
        ).then (output) ->
          console.log JSON.stringify(output, null, 2)
      restartSuccess: (instances) ->
        console.log JSON.stringify(instances, null, 2)
)
