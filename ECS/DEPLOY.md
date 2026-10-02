# Deploying your Python app to ECS

This folder has a minimal Flask app, ready to containerize and push to ECR,
then plug into the Terraform module you already deployed.

## Files
- `app.py` — Flask app with `/` and `/health` endpoints, runs on port 8080
- `requirements.txt` — Flask + gunicorn
- `Dockerfile` — builds the image, runs it with gunicorn (production WSGI server)

## 1. Create an ECR repository

```bash
aws ecr create-repository --repository-name my-app --region us-east-1
```

Note the `repositoryUri` in the output — you'll need it below. It looks like:
`123456789012.dkr.ecr.us-east-1.amazonaws.com/my-app`

## 2. Authenticate Docker to ECR

```bash
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 123456789012.dkr.ecr.us-east-1.amazonaws.com
```

(Replace `123456789012` with your actual AWS account ID — you can get it via
`aws sts get-caller-identity --query Account --output text`.)

## 3. Build the image for the right architecture

Fargate runs on linux/amd64 by default. If you're on a Mac with Apple Silicon,
you need to explicitly target that platform:

```bash
docker build --platform linux/amd64 -t my-app .
```

On Windows/Intel Mac/Linux, a plain `docker build -t my-app .` is fine too,
but including `--platform linux/amd64` never hurts.

## 4. Tag and push

```bash
docker tag my-app:latest 123456789012.dkr.ecr.us-east-1.amazonaws.com/my-app:latest
docker push 123456789012.dkr.ecr.us-east-1.amazonaws.com/my-app:latest
```

## 5. Point Terraform at your new image

In your Terraform project's `terraform.tfvars`, update:

```hcl
container_image   = "123456789012.dkr.ecr.us-east-1.amazonaws.com/my-app:latest"
container_port    = 8080
health_check_path = "/health"
```

## 6. Apply

```bash
terraform apply
```

Terraform will update the task definition and roll the ECS service over to
the new image. Give it a minute, then hit `terraform output alb_dns_name`
again — you should see the JSON response from the Flask app instead of the
nginx welcome page.

## Iterating on the app

Each time you change `app.py`, repeat steps 3–4 (build, tag, push) with a new
tag (e.g. `:v2` instead of `:latest`) or just push over `:latest` again and
force a new deployment:

```bash
aws ecs update-service --cluster my-app-dev-cluster --service my-app-dev-service --force-new-deployment
```

This tells ECS to pull the image again even though the tag name didn't change.
