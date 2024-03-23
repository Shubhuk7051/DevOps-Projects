Architecture- 

- Web Tier: Amazon EC2 instances backed by an Elastic Load Balancer (ELB) to distribute incoming traffic efficiently.

- Application Tier: Auto-scaling group of EC2 instances ensuring scalability and availability of the application.

-Database Tier: Utilizing Amazon RDS (Relational Database Service) for secure and managed database storage.

- Networking: Configured within a Virtual Private Cloud (VPC) to provide isolation, with public and private subnets, security groups, and route tables ensuring secure communication.

![Architecture](https://github.com/Shubhuk7051/DevOps-Projects/blob/master/Day%204/Architecture.png)


AWS Services-
  1) Amazon EC2 (Server)

  2) Amazon Auto Scaling group (Scale on demand)

  3) Amazon VPC (Virtual private cloud: Private Network)

  4) Amazon RDS (Relational database services: Database)

  5) Amazon DynamoDB (State-locking for tfstate file)

  6) Amazon S3 (storing backend and achieving versioning)

  7) Amazon CloudWatch (Alarm when CPU utilization increases or decreases)



Create file 'terraform.tfvars' in the root directory:

  - region=""
  - vpc_cidr= ""   
  - pub-sub1-cidr=""
  - pub-sub2-cidr=""
  - pri-sub1-cidr=""
  - pri-sub2-cidr=""
  - data-pri-sub1-cidr=""
  - data-pri-sub2-cidr=""
  - db_username=""
  - db_password=""

  

Terraform Components:

- Leveraging the AWS provider for seamless resource provisioning.

- Deploying EC2 instances, ELB, auto-scaling group, RDS, VPC, subnets, security groups, and more using Terraform to automate infrastructure setup and configuration.


 Terraform Modules:

- Modular Infrastructure: Terraform modules help organize infrastructure into reusable components, promoting better code organization and maintenance.

- Abstraction: Modules abstract complex infrastructure details, allowing teams to define and manage infrastructure at a higher level of abstraction, boosting productivity.

- Reusability: Modules encourage code reusability across projects, saving time and effort by leveraging pre-built infrastructure components.

- Parameterization: Modules support parameterization, enabling customization for different environments or use cases without duplicating code.
  

Backend Configuration File:

- State Management: The backend file specifies where Terraform stores state files, ensuring consistency and tracking infrastructure changes.

- Remote State Storage: Utilizing remote storage solutions like Amazon S3 enhances resilience and collaboration by centralizing state management.

- Concurrency Control: State locking mechanisms prevent concurrent modifications to the state, ensuring data integrity in collaborative environments.

- Collaboration: Backend configurations enable multiple users to collaborate on infrastructure deployments by sharing a common state.

- Security: Secure backend configurations include authentication and authorization mechanisms to safeguard state data from unauthorized access or modifications.

Benefits:

- Scalability: Auto-scaling groups ensure that resources scale dynamically based on demand, optimizing costs and performance.

- Reliability: Utilizing ELB for load balancing and RDS for managed database services enhances reliability and fault tolerance.

- Security: Implementation within a VPC with proper security groups ensures secure communication and data protection.

Optional- You can also use AWS Cloudfront for content delivery and caching and AWS Route 53 for DNS management.
