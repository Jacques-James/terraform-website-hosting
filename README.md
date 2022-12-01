# Terraform-website-hosting
Desploying web-application using terraform provisioners in AWS.
The goal of this exercise was to highlight the differences between manually deploying a website vs using Terraform
################################################
============= The Manual Way =============
***Instructions***
- Create a VPC with 2 subnets (1 public and 1 private). This should be done from scratch, that is, you should provision an internet gateway, attach to your VPC, set the route tables with adequate routes and proper association route table association and create security groups opening adequate ports
- Launch an EC2 instance in each subnet (enable public ip for each)


***Testing***
- A friend, outside your network, should be able to ping your public EC2 instance but unable to ping your private EC2 instance
- You should be able to ping one instance from another


============= The Terraform Way =============
- Write the terraform code to do exactly the same as above
- Test that is works using testing instructions above
- Yes you are done!

============= Conclusion =============
- How long did it take you to create the infrastructure manually?
- How long would it take you to recreate this infrastructure manually?
- How long did it take you to create the infrastructure with terraform, code and execution?
- Now that you have the terraform code, how long will will it take you to recreate the infrastructure using the existing Terraform code?


============= More-Fun =============
- Save your terreform state file in an S3 bucket with a name of your choice (you can share the arn of the s3 in the group)
- Include all the provisioners you know and lunch the PHP webiste provided by FrancK {On the section that has everyone's name replace it with what you think of terraform}
- Then share the IP address of the website IP with your friends
- You could use DNS to make it more intersting. 
