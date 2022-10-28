cd ..
terraform init -reconfigure -var-file="envs/shared.tfvars" -backend-config="envs/shared.tfbackend" -upgrade %*
cd scripts