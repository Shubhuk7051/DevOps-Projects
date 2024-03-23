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

- AWS Provider Configuration: Terraform is configured with the AWS provider to provision resources on the AWS platform.

- Virtual Private Cloud (VPC): The project creates a VPC with a specified CIDR block, enabling isolation and control over the networking environment.

- Internet Gateway (IGW): An internet gateway is attached to the VPC, allowing outbound and inbound internet traffic for resources within the VPC.

- Public and Private Subnets: Public and private subnets are created within the VPC across multiple availability zones (AZs) to distribute resources and enhance fault tolerance.

- Route Tables: Route tables are configured to define routing rules for traffic within the VPC and to external destinations, ensuring proper communication between subnets and the internet.

- Security Groups: Security groups are defined to control inbound and outbound traffic for EC2 instances, ELB, and RDS, enforcing security policies and access control.

- Elastic Load Balancer (ELB): An Application Load Balancer (ALB) is provisioned to evenly distribute incoming traffic across EC2 instances in the Web Tier, improving scalability and fault tolerance.

- Auto Scaling Group (ASG): An Auto Scaling Group is established to manage EC2 instances in the Application Tier, automatically adjusting capacity based on traffic demand and health checks.

- Launch Template: A launch template is defined to specify configuration details for EC2 instances launched within the Auto Scaling Group, ensuring consistency and scalability.

- Amazon RDS Instance: An RDS instance is deployed to provide a managed database solution, facilitating storage and retrieval of application data with reliability and scalability.

- NAT Gateways: NAT Gateways are set up in public subnets to enable private subnet instances to access the internet while maintaining security.

- Elastic IPs (EIPs): Elastic IPs are allocated and associated with NAT Gateways to provide static IP addresses for outbound internet traffic.


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
