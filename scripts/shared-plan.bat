cd ..
terraform plan -var-file="envs/shared.tfvars" -out="envs/shared.tfplan" %*
cd scripts