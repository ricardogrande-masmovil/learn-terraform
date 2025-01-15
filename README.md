
## Project Overview
```plaintext
project/
├── iam/                  # IAM user and policy management
├── lambda/              # Lambda function configuration
├── messaging/           # SQS queue setup
├── storage/            # S3 bucket configuration
├── main.tf             # Root configuration
├── providers.tf        # AWS provider configuration
├── variables.tf        # Root variables
└── .terraform.lock.hcl # Terraform dependency lock file
```

## Key Components
1. IAM Module (iam/)
- Creates a developers group
- Manages IAM users and their access keys
- Defines policies for S3, SQS, and Lambda access
- Outputs access keys (marked as sensitive)
2. Lambda Module (lambda/)
- Deploys a Python Lambda function
- Sets up IAM roles and permissions
- Configures SQS trigger
- Includes source code for message processing
3. Messaging Module (messaging/)
- Creates SQS queue for S3 notifications
- Configures queue policies and encryption
4. Storage Module (storage/)
- Creates three S3 buckets:
  - Raw tier (data lake)
  - Bronze tier (data lake)
  - Lambda artifacts
- Implements security features:
  - Versioning
  - Encryption
  - Public access blocking
  - Lifecycle policies
  - Access logging
- Configures S3 event notifications
5. Root Configuration
- Defines provider requirements
- Sets up module dependencies
- Manages environment variables
- Handles resource tagging
6. Notable Features
- Security
  - All S3 buckets have:
    - Public access blocking
    -   Server-side encryption
    - Versioning enabled
    - Access logging
  - SQS queues use server-side encryption
  - IAM follows least privilege principle
- Data Management
  - Lifecycle policies for cost optimization
  - Version control for all storage
  - Automated event notifications
