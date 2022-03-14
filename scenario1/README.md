# Scenario1

## Overview

Based on your DevOps experience and DevOps best practices and principles, please fix the infrastructure described below. As an output, I expect pdf with fixed infrastructure (you can use draw io, lucidchart, or similar) and an explanation of why you chose this solution over the others and improvements which can be implemented in the future.

- There could be many solution for the infrastructure provided above. Although I am providing 2 solutions which are simple but have capacity dand efficiency of scalable and High-Available. 

## AWS Services

1. Route53 - Amazon Route 53 is a highly available and scalable cloud Domain Name System (DNS) web service. It is designed to give developers and businesses an extremely reliable and cost effective way to route end users to Internet applications by translating names like www.example.com into the numeric IP addresses like 192.168.43.12
2. Web Application Firewal (WAF) - AWS WAF is a web application firewall service that lets you monitor web requests and protect your web applications from malicious requests. Use AWS WAF to block or allow requests based on conditions that you specify, such as the IP addresses.
3. Application Load Balance (ALB) - Application Load Balancer (ALB) is a fully managed layer 7 load balancing service that load balances incoming traffic across multiple targets, such as Amazon EC2 instances. ALB supports advanced request routing features based on parameters like HTTP headers and methods, query string, host and path based routing.
- [NEW Policy Launched by AWS (Hostbased routing) for ALB](https://aws.amazon.com/blogs/aws/new-host-based-routing-support-for-aws-application-load-balancers/)
4. AWS Congnito - Authenticate users through corporate identities, using SAML, LDAP, or Microsoft AD, or social IdPs, such as Amazon, Facebook, or Google through the user pools supported by Amazon Cognito.
5. TargetGroups - Create Target groups with Production and Non-Production tags for differentiate the EC2 targetgroups. A target group tells a load balancer where to direct traffic to : EC2 instances, fixed IP addresses; or AWS Lambda functions, amongst others. When creating a load balancer, you create one or more listeners and configure listener rules to direct the traffic to one target group.
6. AutoScaling Group(ASG) - An Auto Scaling group enables you to use Amazon EC2 Auto Scaling features such as health check replacements and scaling policies. 
7. Elasticache (Redis) - Amazon ElastiCache for Redis supports Redis Cluster configuration, which delivers superior scalability and availability. In addition, Amazon ElastiCache offers multiple Availability Zone (Multi-AZ) support with auto failover that enables us to set up a cluster with one or more replicas across zones.
8. RDS (Mysql) - With Amazon RDS, We deployed scalable MySQL servers in minutes with cost-efficient and resizable hardware capacity. Amazon RDS for MySQL frees us to focus on application development by managing time-consuming database administration tasks including backups, software patching, monitoring, scaling and replication.
9. 
## Workflow of Solution1

![alt text](http://url/to/img.png)

1. User(Actor) sends request to <b>example.com</b> and that redircts to route53.
2. Requests passes through WAF which monitors web-request and if request is fine then redirects to Application LB.
3. ALB has feature to route requests according to Host-based routing and will send request to destination Public LBs.
4. Authenticating of users will be happening at Application Load Balancer layer where request will verifies from AWS Cognito mode. In case of user is not present then it will callback an action to generate token or ask for signup.
4. The production request further goes to Multi-AZ (AZ1 and AZ2) where we have autoscaling groups for Frontend EC2 instances in Public subnets and Non-production request goes to Single AZ3.
5. After that the request further goes to Internal LB which sends request to further Backend EC2 instances which is autoscaling groups. 
6. Here we have RDS Master(Mysql) running in AZ1 which will be synced with AZ2 and AZ3(Non-Production data for testing).
7. Also Elasticache service will be in Master and slave arch for high available and will be in synced. 

### Pros 
- Solution is high-available, scalable.

### Cons
- High cost need to pay for such environment. We can convert it into microservice architecutre or serverless. 

## Workflow of Solution2

![alt text](http://url/to/img.png)

1. User(Actor) sends request to <b>example.com</b> and that redircts to route53.
2. Requests passes through WAF which monitors web-request and if request is fine then redirects to Application LB.
3. ALB has feature to route requests according to Host-based routing and will send request to destination target groups.
4. Authenticating of users will be happening at Application Load Balancer layer where request will verifies from AWS Cognito mode.
5. Frontend App and Backend App EC2 instances will autoscalw when required according to Health Checks.
6. Then Backend application request first will fetch data from Elasticache (Redis) service if the data is not available at Elasticache service then second request will retry with RDS(Mysl) service and will also store the response data in Elasticache Service.
7. Both production and non-production will have common Elasticache service and will write or read queries by both backend EC2.
8. Setting up Master and Slave RDS(Mysql) service for both environments for High Availablity. Slave will poll for new writes and update itself. 
 
### Pros 
- Solution is simple but scalable.
- Less cost to pay

### Cons
- Single Point of failure with Elasticache service. 


# Best practice
- We can also implement the Cloudwatch, Cloudtrail, Eventbridge and Lambda service to make it more reliable. 
- We can warm up the machine in Production environment when expected traffic in weekends. 
- We can run this code on container or design it in serverless architecture to save cost. 
- We can also use compliance tool to verify that the existing infrastrutre is running without any vulnerabilities. i.e. AWS Sheild or AWS Governance.
