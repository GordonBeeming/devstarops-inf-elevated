cd ..
terraform apply -auto-approve %* "envs/shared.tfplan"
cd scripts