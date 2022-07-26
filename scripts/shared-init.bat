cd ..
terraform init -var-file="envs/shared.tfvars" -backend-config="envs/shared.tfbackend" %*
cd scripts