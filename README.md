# aws-signing-helper

Inspired by [josh23french/iam-roles-anywhere-sidecar](https://github.com/josh23french/iam-roles-anywhere-sidecar)

Uses [aws/rolesanywhere-credential-helper](https://github.com/aws/rolesanywhere-credential-helper) cli instead of building a separate http server.

## sidecar

Add it to your own deployment as a sidecar.

Example:

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
    - name: DEBUG
      value: "false"
    image: ghcr.io/ehlomarcus/aws-signin-helper:v1.0.0
    imagePullPolicy: IfNotPresent
    name: iam-helper
    resources:
      requests:
        cpu: 100m
        memory: 128Mi
```

Next you need to add this ENV to your application container. Using this ENV will allow your application (aws-sdk) to discover credentials.

```yaml
spec:
  containers:
  - env:
    - name: AWS_EC2_METADATA_SERVICE_ENDPOINT
      value: http://localhost:8081/
```