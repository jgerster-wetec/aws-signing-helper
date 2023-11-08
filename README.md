# aws-signing-helper

Inspired by [josh23french/iam-roles-anywhere-sidecar](https://github.com/josh23french/iam-roles-anywhere-sidecar).

Uses [aws/rolesanywhere-credential-helper](https://github.com/aws/rolesanywhere-credential-helper) cli instead of building a separate http server.

Makes use of the [serve](https://github.com/aws/rolesanywhere-credential-helper#serve) command to run a metadata service endpoint on localhost.

## sidecar

Add a sidecar container to your own deployment.

Here is an example, showing all of the `env` that are configurable:

```yaml
spec:
  containers:
  - env:
    - name: PRIVATE_KEY
      value: /certificates/MyService.key.pem
    - name: CERTIFICATE
      value: /certificates/MyService.crt.pem
    - name: ROLE_ARN
      value: arn:aws:iam::123456789012:role/MyRole
    - name: PROFILE_ARN
      value: arn:aws:rolesanywhere:eu-west-1:123456789012:profile/e7acdea9-3c21-42ab-affc-c448b69eee1b
    - name: TRUST_ANCHOR_ARN
      value: arn:aws:rolesanywhere:eu-west-1:123456789012:trust-anchor/ee461377-7abd-428f-bc04-ff99b7538920
    # DEBUG and PORT are optional.
    # Use DEBUG to turn on more logging.
    # Use PORT to change which port endpoint should be served on.
    - name: DEBUG
      value: "false"
    - name: PORT
      value: "8081"
    image: ghcr.io/ehlomarcus/aws-signing-helper:main
    imagePullPolicy: IfNotPresent
    name: iam-helper
    resources:
      requests:
        cpu: 100m
        memory: 128Mi
```

Next you need to add this environmental variable to your application container. 

Using `AWS_EC2_METADATA_SERVICE_ENDPOINT` environment variable allow your application ([aws-sdk](https://docs.aws.amazon.com/sdkref/latest/guide/feature-imds-credentials.html)) to discover credentials.

```yaml
spec:
  containers:
  - env:
    - name: AWS_EC2_METADATA_SERVICE_ENDPOINT
      value: http://localhost:8081/
```
