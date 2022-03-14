# Scenario1

## Overview

Based on your DevOps experience and DevOps best practices and principles, please fix the infrastructure described below. As an output, I expect pdf with fixed infrastructure (you can use draw io, lucidchart, or similar) and an explanation of why you chose this solution over the others and improvements which can be implemented in the future.

###
There could be many solution for the infrastructure provided above. Although I am providing 2 solutions which are simple but have capacity dand efficiency of scalable and High-Available. 

## AWS Services

1. Route53 - 
2. Web Application Firewal (WAF) - AWS WAF is a web application firewall service that lets you monitor web requests and protect your web applications from malicious requests. Use AWS WAF to block or allow requests based on conditions that you specify, such as the IP addresses
3. Application Load Balance (ALB) - https://aws.amazon.com/blogs/aws/new-host-based-routing-support-for-aws-application-load-balancers/
4. AWS Congnito - Authenticate users through corporate identities, using SAML, LDAP, or Microsoft AD, or social IdPs, such as Amazon, Facebook, or Google through the user pools supported by Amazon Cognito.
5. TargetGroups - Create Target groups with Production and Non-Production tags for differentiate the EC2 pools
6. AutoScaling Group(ASG)
7. Elasticache (Redis) - Amazon ElastiCache for Redis supports Redis Cluster configuration, which delivers superior scalability and availability. In addition, Amazon ElastiCache offers multiple Availability Zone (Multi-AZ) support with auto failover that enables us to set up a cluster with one or more replicas across zones.
8. RDS (Mysql) - 
9. 
## Workflow of Solution1

1. User(Actor) sends request to <b>example.com</b> and that redircts to route53.
2. Requests passes through WAF which monitors web-request and if request is fine then redirects to Application LB.
3. ALB has feature to route requests according to Host-based routing and will send request to destination Public LBs.
4. The production request further goes to Multi-AZ (AZ1 and AZ2) where we have autoscaling groups for Frontend EC2 instances in Public subnets and Non-production request goes to Single AZ1.
5. After that the request further goes to Internal LB which sends request to further Backend EC2 instances which is autoscaling groups. 
6. Here we have RDS Master(Mysql) running in AZ1 which will be synced with AZ2 and AZ3(Non-Production data for testing).
7. Also Elasticache service will be in Master and slave arch for high available and will be in synced. 
8. 
9. 


## Workflow of Solution2

1. User(Actor) sends request to <b>example.com</b> and that redircts to route53.
2. Requests passes through WAF which monitors web-request and if request is fine then redirects to Application LB.
3. ALB has feature to route requests according to Host-based routing and will send request to destination target groups.
4. Authenticating users for Staging using an Application Load Balancer
5. Frontend App and Backend App EC2 instances will be autoscale when required.(Health Checks)
6. Then Backend request will fetch data from Elasticache (Redis) service if the data is not available at Elasticache service then request will retry with RDS(Mysl) service and will also store the response data in Elasticache Service.
7. Both production and non-production environments are using same RDS and Elasticache services for 
8. Sharing RDS and Elastic service for both environments where RDS will be in sync with both RDS service (Master and Replica)



# Best practice
- We can modify python code with more informations like Logging  and argument of numbers. 
- We can run this code on container and pass the argument of numbers.
