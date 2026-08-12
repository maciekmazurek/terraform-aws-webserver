# AWS EC2 Automated Infrastructure with Terraform (IaC)

![Terraform](https://img.shields.io/badge/Terraform-1.0+-7B42BC?style=flat&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-Free%20Tier-232F3E?style=flat&logo=amazon-aws&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-Web%20Server-009639?style=flat&logo=nginx&logoColor=white)

An Infrastructure as Code (IaC) project that automatically provisions a secure, publicly accessible Nginx web server on AWS using **Terraform**. 

This project demonstrates automated infrastructure deployment, network security configuration (Security Groups), dynamic AMI lookup, and post-provisioning server bootstrapping (`user_data`).

---

## Getting Started

### Prerequisites

Make sure you have the following tools installed locally:

- Terraform CLI (>= 1.0.0)
- AWS CLI
- An active AWS Account with configured IAM credentials (`aws configure`).

### Usage instructions

1. Clone the repository

```
git clone https://github.com/maciekmazurek/terraform-aws-webserver.git
cd terraform-aws-webserver
```

2. Initialize Terraform working directory:

```
terraform init
```

3. Review the execution plan:

```
terraform plan
```

4. Deploy infrastructure:

```
terraform apply
```

5. Verify the installation - Once apply completes, copy the URL provided in the website_url output and open it in your browser:

```
Outputs:
public_ip = "x.x.x.x"
website_url = "http://x.x.x.x"
```

6. Cleanup - To avoid incurring unexpected charges on AWS, destroy all created resources when finished testing:

```
terraform destroy
```

---

## Features

- **Infrastructure as Code (IaC)**: Fully declarative setup using HashiCorp Terraform.
- **Dynamic AMI Fetching**: Automatically queries AWS for the latest official Ubuntu 22.04 LTS Image.
- **Automated Bootstrapping**: Uses EC2 user_data shell script to install and launch Nginx on startup without manual intervention.
- **Granular Security**: Security Group configured to allow only necessary web (HTTP/80) and administration (SSH/22) traffic.
- **Parameterized & Modular**: Clean code structure utilizing Terraform variables (variables.tf) and dynamic outputs (outputs.tf).
