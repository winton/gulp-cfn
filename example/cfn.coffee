module.exports = (config) ->
  AWSTemplateFormatVersion: "2010-09-09"
  Description: "Basic template with instance id output"
  Parameters:
    InstanceTypeInput:
      Description: "EC2 instance type"
      Type: "String"
      Default: "t2.micro"
    KeyName:
      Default: "FullStack"
      Description: "The name of an EC2 Key Pair to allow SSH access to the instance."
      Type: "String"
    SSHLocation:
      Description: "The IP address range that can be used to SSH to the EC2 instances"
      Type: "String"
      MinLength: "9"
      MaxLength: "18"
      Default: "0.0.0.0/0"
      AllowedPattern: "(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})/(\\d{1,2})"
      ConstraintDescription: "must be a valid IP CIDR range of the form x.x.x.x/x."
  Mappings:
    RegionMap:
      "us-west-1":
        AMI: "ami-42908907"
  Resources:
    Ec2Instance:
      Type: "AWS::EC2::Instance"
      Properties:
        InstanceType:
          Ref: "InstanceTypeInput"
        ImageId: "Fn::FindInMap": [
          "RegionMap"
          { "Ref": "AWS::Region" }
          "AMI"
        ]
        KeyName:
          Ref: "KeyName"
        SecurityGroups: [
          Ref: "InstanceSecurityGroup"
        ]
    InstanceSecurityGroup:
      Type: "AWS::EC2::SecurityGroup"
      Properties:
        GroupDescription: "Enable SSH access via port 22"
        SecurityGroupIngress: [
          IpProtocol: "tcp"
          FromPort: "22"
          ToPort: "22"
          CidrIp:
            Ref: "SSHLocation"
        ]
  Outputs: "InstanceId":
    Description: "InstanceId of the newly created EC2 instance"
    Value:
      Ref: "Ec2Instance"
