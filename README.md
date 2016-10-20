EC2 Bundle for Cog
==================

This bundle provides commands for viewing, inspecting, and controlling EC2
instances on AWS, as well as related resources. To communicate with the AWS API
we use the aws-sdk library written in Ruby. Permissions are used to control
which users are authorized to run each command.  Listing and searching for
resources requires the ec2:read permission.  Modifying the state or other
values of a resource requires the ec2:write permission.  And, creating a new
instance requires the ec2:admin permission.

To view more information about the bundle and the documentation for each
command use Cog's help command:

For bundle information:

```
help ec2
```

For specific command information:

```
help ec2:instance-create
```

Configuration
-------------

* AWS_ACCESS_KEY_ID - Requried ID of the access key used to authenticate with the AWS API
* AWS_SECRET_ACCESS_KEY - Required secret of the access key used to authenticate with the AWS API
* AWS_REGION - Optional region used for all commands unless one is provided via the -r,--region flag

You can set these environment variables with Cog's dynamic config feature:

```
echo 'AWS_ACCESS_KEY_ID: "AKJAJ4OZ5KYFVRVKZRWM"' >> config.yaml
echo 'AWS_SECRET_ACCESS_KEY: "WQ9b84VDvE5dJhs2SdOdEgO8ZpAIbuzBlb6ZCGkQ"' >> config.yaml
echo 'AWS_REGION: us-east-1' >> config.yaml
cogctl dynamic-config create ec2 config.yaml
```

When creating the access key for use with the following environment variables,
make sure the IAM user that owns the key has the `AmazonEC2FullAccess` policy.

Development
-----------

Build a new image:

```
VERSION=0.1.0 make build
```

Push a new image to DockerHub:

```
VERSION=0.1.0 make push
```

Cut a new release (build, push, and tag on GitHub):

```
VERSION=0.1.0 make release
```
