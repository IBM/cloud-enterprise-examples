---
# Related publishing issue: 
draft: true

authors:
- name: "Raj Patil"
  email: "rpatil@ibm.com"
- name: "Tim Robinson"
  email: "timro@us.ibm.com"
- name: "Matthew Perrins"
  email: "mjperrin@us.ibm.com"
- name: "Johandry Amador"
  email: "johandry.amador@ibm.com"
- name: "Balaji Kadambi"
  email: "bkadambi@in.ibm.com"
- name: "Shikha Maheshwari"
  email: "shikha.mah@in.ibm.com"
- name: "John Zaccone"
  email: "john.zaccone@ibm.com"
- name: "Anthony Fuller"
  email: "anthony.fuller@ibm.com"
- name: "Saranyya Chillal"
  email: "sarannya.chilhal@ibm.com"

completed_date: "2020-07-03"
last_updated: "2020-07-03"

excerpt: "Explore IBM Cloud through cloud patterns"
abstract: "This article contains patterns to help an enterprise customer leverage key capabilities of IBM Cloud, including Infrastructure as code, auto-scaling, logging, monitoring, and CI/CD. "
---

# Introduction

Cloud computing is rapidly proliferating Enterprise IT. Organizations are looking at modernizing their legacy applications or building new solutions on the cloud. There are certain key capabilities that most enterprises need for migrating or building applications on a public cloud. 

- A secure network with network isolation and access controls.
- Data protection with encryption of data at rest and in motion.
- Access control to the cloud.
- Monitor the environment with a common shared logging and monitoring infrastructure.
- Deploy as infrastructure with immutable infrastructure as pre-built/pre-tested VM images and fully automated CI/CD pipelines.
- Make allocation match demand with autoscaling of VMs,containers,applications and PaaS services.

In this article, we will provide you resources in the form of cloud patterns to help Enterprise developers get started quickly on the different capabilities of IBM Cloud. 

We have organized the content into the below six areas with cloud patterns covering the important key capabilities of IBM Cloud. Each of these areas contain patterns to help an enterprise customer leverage key capabilities of IBM Cloud.
1. Infrastructure as Code <br/>
2. Logging <br/>
3. Monitoring <br/>
4. CI/CD <br/>
5. Autoscaling of applications <br/>
6. Security

## Prerequisites

[IBM Cloud account](https://cloud.ibm.com)

## Estimated time

The estimated time is dependent on the areas you would want to explore. We have broken the content into smaller pieces. Each piece should take anywhere from 15 mins to 2 hours to set up and execute. For example, if you wish to see how to send log events from a Virtual Server to LogDNA, you should be able to complete the task in 30 mins. If you are exploring an area under auto-scaling or CI/CD pipelines, it can range from an hour to 2 hours to complete. The time taken can vary depending on your expertise in the area. 

## 1. Infrastructure as Code

Infrastructure as Code (IaC) is the process of managing and provisioning of infrastructure through machine-readable definition files, rather than physical hardware configuration, pointing and clicking on a Web console, or using interactive configuration tools.

With IaC we capture a tedious and error prone provisioning process into code, so every time this code is executed - 1, 2, or a million times - we get the same outcome thus reducing errors and obtaining expected results. With IaC we are not just automating a process through a code, we are also documenting it. This code can be checked into version control to get versioning providing a history of who changed what and how the infrastructure was defined at any given time. Last but not least, same as with programming code, we can reuse the developed infrastructure code in other projects or infrastructure, improving our process and getting results faster.

There are multiple tools to do IaC, one of them is Terraform by HashiCorp. IBM Cloud offers Schematics: a simplified solution for provisioning and orchestrating infrastructure supported by the Terraform engine. This is a fully open Terraform service, so you can create and execute templates native to your organization’s hybrid cloud environment. RedHat offers Ansible: a post provisioning tool to automate the configuration of the provisioned resources. Terraform, Schematics and Ansible leverage your best practices to save time and money, while increasing performance.

Infrastructure as Code reduces costs, speeds delivery execution, and reduces risk by documenting and managing infrastructure using the same tools used in software engineering to document, version, and manage code.

The following topics are covered in the Infrastructure as Code section

1. [Environment Setup](https://ibm.github.io/cloud-enterprise-examples/iac/setup-environment)
2. [Getting Started with Terraform](https://ibm.github.io/cloud-enterprise-examples/iac/getting-started-terraform)
3. [IBM Cloud Schematics](https://ibm.github.io/cloud-enterprise-examples/iac/schematics)
4. IBM Cloud Resources Management and Provisioning
   1. [Identity and Access Management Groups and Policies](https://ibm.github.io/cloud-enterprise-examples/iac-resources/iam)
   2. [Virtual Private Cloud Networking](https://ibm.github.io/cloud-enterprise-examples/iac-resources/network)
   3. [Virtual Server Instances and Storage](https://ibm.github.io/cloud-enterprise-examples/iac-resources/compute)
   4. [Cloud Databases and Cloud Service Instances](https://ibm.github.io/cloud-enterprise-examples/iac-resources/services)
   5. [Containers and Kubernetes Services (IKS)](https://ibm.github.io/cloud-enterprise-examples/iac-resources/container)
5. Configuration Management
   1. [User Data and Cloud-Init](https://ibm.github.io/cloud-enterprise-examples/iac-conf-mgmt/user-data)
   2. [Ansible](https://ibm.github.io/cloud-enterprise-examples/iac-conf-mgmt/ansible)

## 2. Logging

Log Analysis with LogDNA provides a way for quickly finding the sources of issues while gaining deep insights into your cloud applications. LogDNA provides the aggregation of event logging from your applications and services within the IBM Cloud environment.

1. [IBM Cloud Log Analysis with LogDNA Overview](https://ibm.github.io/cloud-enterprise-examples/logging/content-overview)
2. [Deployment Architecture](https://ibm.github.io/cloud-enterprise-examples/logging/deployment-architecture)
3. [Controlling Access with IBM Cloud IAM, Configuring users, groups and applications permissions for Event Logs](https://ibm.github.io/cloud-enterprise-examples/logging/controlling-access)
4. [Configure Virtual Server for LogDNA](https://ibm.github.io/cloud-enterprise-examples/logging/configure-virtual-server)
5. [Configure containers for LogDNA](https://ibm.github.io/cloud-enterprise-examples/logging/configuring-for-containers)
6. [Customizing Event Log Views, Configuring Alert Notifications, configuring preset and alerts](https://ibm.github.io/cloud-enterprise-examples/logging/customize-alerts)
7. [Archive event Logs using IBM Cloud Object Storage (COS)](https://ibm.github.io/cloud-enterprise-examples/logging/archive-logs-for-long-term-storage)

## 3. Monitoring

Monitoring is key to making sure your applications perform well and are secure in IBM Cloud.
IBM Cloud Monitoring combined partnership with Sysdig and Activity Tracker with LogDNA, provide operational visibility into the performance and health of your applications, services, and platforms. IBM Monitoring offers administrators, DevOps teams and developers full stack telemetry with advanced features to monitor and troubleshoot, define alerts, and design custom dashboards.

1. [IBM Cloud Monitoring with Sysdig](https://ibm.github.io/cloud-enterprise-examples/monitoring/content-overview)
2. [Customize Monitor Alerts](https://ibm.github.io/cloud-enterprise-examples/monitoring/customizing-and-alerts)
3. [Configuring Monitoring for Resource](https://ibm.github.io/cloud-enterprise-examples/monitoring/configuring-monitoring-for-resources)
4. [Controlling Access to Monitoring Metrics and Event Data](https://ibm.github.io/cloud-enterprise-examples/monitoring/controlling-access-to-metrics-and-event-data)

## 4. CI/CD

Continuous Integration is a software development practice where members of a team integrate their work frequently, usually each person integrates at least daily - leading to multiple integrations per day. Each integration is verified by an automated build (including test) to detect integration errors as quickly as possible. Many teams find that this approach leads to significantly reduced integration problems and allows a team to develop cohesive software more rapidly

Continuous delivery is the DevOps approach of frequently making new versions of an application’s components available for deployment to a runtime environment. The process involves automation of the build and validation process and concludes with a new version of the application that is available for promotion to another environment.

Continuous deployment is closely related to continuous delivery except that in continuous deployment an application automatically deploys when it is ready instead of when manually triggered by a user.

### 4.1 CI/CD with IBM Cloud Public
The advantage of using IBM Cloud Toolchain is that it integrates seamlessly with all resources already deployed on IBM Cloud while providing full DevOps capabilities provided by the Open Toolchain. There are some built-in features as well such as enabling DevOps Insights to give you aggregate view of all tests that are running in your pipeline. For more details on IBM Cloud Toolchain refer the below links.

1. [Cloud Toolchain Setup](https://ibm.github.io/cloud-enterprise-examples/ci-cd/cloud-toolchain-setup)
2. [Cross Account Pipelines with IBM Cloud Toolchain](https://ibm.github.io/cloud-enterprise-examples/ci-cd/cloud-toolchain-across-accounts)
3. [IBM Cloud Toolchain- Managed Devops for Schematics/Terraform](https://ibm.github.io/cloud-enterprise-examples/ci-cd/cloud-toolchain-schematics)
4. [IBM Cloud Toolchain Testing/SDLC](https://ibm.github.io/cloud-enterprise-examples/ci-cd/cloud-toolchain-sdlc)

### 4.2 CI/CD with Cloud Native Tools
One of the patterns emerging with development teams is the ability to use CNCF Tools as part of a more open multi cloud CI/CD strategy. This approach is aligning around the Kubernetes platform. The IBM Cloud supports both upstream Kubernetes for advanced cutting edge workloads and Red Hat OpenShift the proven multi-cloud distribution of Kubernetes that can install on IBM Cloud, Azure, AWS, VMWare and on Premise and many more places. This approach removes cloud vendor lock in around CI/CD tools and enables development teams to be more flexible and the target cloud they focus on deploying and developing with. For further exploration, refer the below links.

1. [Install CNCF Cloud-Native DevOps Tools](https://ibm.github.io/cloud-enterprise-examples/ci-cd/cloud-native-setup) 
2. [Developer tools Setup](https://ibm.github.io/cloud-enterprise-examples/ci-cd/cloud-native-setup-tools)
3. [Continuous Integration with Jenkins](https://ibm.github.io/cloud-enterprise-examples/ci-cd/cloud-native-ci-tools)
4. [Deploy First Application](https://ibm.github.io/cloud-enterprise-examples/ci-cd/cloud-native-deploy)
5. [Continuous Delivery](https://ibm.github.io/cloud-enterprise-examples/ci-cd/cloud-native-cd)
6. [Code patterns for Cloud Native](https://ibm.github.io/cloud-enterprise-examples/ci-cd/cloud-native-codepatterns)

## 5. Autoscaling

In this section, we will see how to configure autoscaling for a IBM Kubernetes cluster and Virtual Server on a Virtual Private Cloud. A virtual private cloud (VPC) is a public cloud offering that lets an enterprise establish its own private cloud-like computing environment on shared public cloud infrastructure. A VPC gives an enterprise the ability to define and control a virtual network that is logically isolated from all other public cloud tenants, creating a private, secure place on the public cloud.

### 5.1 IBM Kubernetes Service on Virtual Private Cloud

IBM Cloud Kubernetes Service provides intelligent scheduling, self-healing, horizontal scaling, load balancing, secret and configuration management for your applications. Auto-scaling in Kubernetes comes in two forms: Horizontal Pod Autoscaler (HPA) and Cluster Autoscaler (CA). HPA is autoscaling at the pod level and it scales the pod in a deployment, whereas CA is used to scale nodes in a cluster. In this section, we provide you the resources that help you set up a IKS cluster on a Virtual Private Cloud, and see the autoscaling in action.

1. [Overview of autoscaling](https://ibm.github.io/cloud-enterprise-examples/deploy-iks/content-overview)
2. [Set up IKS and configure the environment](https://ibm.github.io/cloud-enterprise-examples/deploy-iks/setup-environment)
3. [Deploy a sample web application](https://ibm.github.io/cloud-enterprise-examples/deploy-iks/application-deployment)
4. [Horizontal Pod Autoscaler in action](https://ibm.github.io/cloud-enterprise-examples/deploy-iks/hpa)
5. [Cluster Autoscaler in action](https://ibm.github.io/cloud-enterprise-examples/deploy-iks/ca)

### 5.2 Virtual Server on Virtual Private Cloud

Virtual server instances for VPC give you access to all of the benefits of IBM Cloud VPC, including network isolation, security, and flexibility. When you provision an instance, you select a profile that matches the amount of memory and compute power that you need for the application that you plan to run on the instance. Instances are available on both x86 and POWER architectures. After you provision an instance, you control and manage those infrastructure resources. 

With Auto Scale for VPC, you can improve performance and costs by dynamically creating virtual server instances to meet the demands of your environment. You set scaling policies that define your desired average utilization for metrics like CPU, memory, and network usage. 

Please refer to the below resources to see autoscaling in action:

1. [Overview](https://ibm.github.io/cloud-enterprise-examples/deploy-vsi/content-overview)
2. [Set up environment](https://ibm.github.io/cloud-enterprise-examples/deploy-vsi/setup-environment)
3. [Autoscaling in action](https://ibm.github.io/cloud-enterprise-examples/deploy-vsi/monitor-vsi)

### 5.3 Scaling of PaaS services

In this section, we cover the ability to scale important PaaS services on IBM Cloud like Event Streams, MongoDB, PostgreSQL, DB2 and Cloud Object Storage.

- [Auto-scale configuration for PaaS services](https://ibm.github.io/cloud-enterprise-examples/paas-services-resources/paas-autoscale)

## 6. Security

IBM has a long-standing history as a leading security provider. Today, IBM Cloud® builds on that tradition as the most open and secure public cloud for business. Leverage market-leading data protection capabilities to secure your data at rest, in motion and in use.

Achieve continuous security for your enterprise applications and workloads with built-in isolation, access management and integrated security posture. IBM offers unmatched expertise to help your business meet security, quality and compliance objectives.

### 6.1 Certificate Manager

IBM Cloud provides a service to securely handle certificates used for TLS termination by enterprise applications. This service can store certificates provided by certificate authorities and it can also order free certificates from Let's Encrypt.

1. [Using Certificate Manager to import and order certificates](https://ibm.github.io/cloud-enterprise-examples/certificate-management/service-setup)
2. [Deploying certificates to VPC Load Balancers](https://ibm.github.io/cloud-enterprise-examples/certificate-management/deploy-to-vpclb)
3. [Deploying certificates to applications on Kubernetes](https://ibm.github.io/cloud-enterprise-examples/certificate-management/deploy-to-iks/)

### 6.2 IBM Cloud Event Log Integration with Third Party Security Tools

Streaming enables LogDNA to produce content to a message bus queue and Topic. LogDNA streaming helps you to connect third party consumers of topics to ingest into dashboards for visualization of event log data.
Third party horizonal technologies such as Splunk, used in organizations for application management, security and compliance are able to leverage IBM Cloud Log Analysis with LogDNA Streaming.

- [IBM Cloud Event Log Integration](https://ibm.github.io/cloud-enterprise-examples/log-streaming/configure-streaming-for-third-party-tools)

## Conclusion

In this article, we provided a quick start on some of the key capabilities of IBM Cloud. The cloud patterns are a ready reference for architects and developers to validate and understand cloud capabilities. 

For further or detailed information on each of the areas, please refer to [IBM Cloud documentation](https://cloud.ibm.com/docs).
Please visit [IBM Cloud](https://cloud.ibm.com) to explore further. 
