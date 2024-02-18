# 3 TIER ARCHITECTURE 

This Terraform project automates the provisioning of infrastructure resources on AWS using Infrastructure as Code (IaC) principles.

## Prerequisites

Before using this Terraform project, you need to have the following prerequisites:

- Terraform installed on your local machine (version v1.6.6 or higher)
- AWS account with appropriate permissions and credentials configured
- AWS CLI configured with access keys

## Installation and Usage

1. Clone the repository: 

git clone https://github.com/Yagmur1997/public-repo.git
cd repository

2. Initialize Terraform:

terraform init

3. Plan and apply changes:

terraform plan -out=tfplan
terraform apply tfplan

4. Clean up resources:

terraform destroy

## Contributing

Contributions are welcome! If you find any bugs or have suggestions for improvements, please [open an issue](https://github.com/Yagmur1997/3-TIER-ARCHITECTURE-PROJECT/issues) or [submit a pull request](https://github.com/Yagmur1997/3-TIER-ARCHITECTURE-PROJECT/pulls).