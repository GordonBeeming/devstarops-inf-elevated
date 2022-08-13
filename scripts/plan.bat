cd ..
terraform plan -input=false -var-file="envs/shared.tfvars" -out="envs/shared.tfplan" %*
cd scripts