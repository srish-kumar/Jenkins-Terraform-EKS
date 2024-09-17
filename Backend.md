# Note:
# Command to create dynamodb table manually:
# aws dynamodb create-table \
# --table-name Lock-Files \
# --attribute-definitions AttributeName=LockID,AttributeType=S \
# --key-schema AttributeName=LockID,KeyType=HASH \
# --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

# Note:
# Error: Error acquiring the state lock
# ConditionalCheckFailedException

# ConditionalCheckFailedException, occurs when Terraform fails to acquire the state lock in DynamoDB. 
# This can happen if the DynamoDB table used for state locking already has a lock or the lock conditions were not met.

# Common Causes:
# 1. Existing Lock: Another Terraform process may already be holding the lock, causing your current operation to fail.
# 2. Stale Lock: Sometimes, a lock can be left in place after an abnormal termination (e.g., if a previous terraform command was interrupted or failed).

# How to troubleshoot:
# 1. Check for Active Lock - aws dynamodb scan --table-name <Lock-Table-Name>
# 2. Removing a Lock - If the lock entry exists in your DynamoDB table with LockID set to path/to/terraform.tfstate
# remove it - 
# aws dynamodb delete-item \
# --table-name Lock-Files \
# --key '{"LockID": {"S": "path/to/terraform.tfstate"}}'

# Best Practice 
# Use the -lock-timeout Option: terraform apply -var-file="dev.tfvars" -lock-timeout=10m 