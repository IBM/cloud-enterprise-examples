# Introduction

In this article, we will provide you resources or cloud patterns that gets you started with the different capabilities on IBM Cloud.
For any organization to move their applications to the cloud, certain capabilities that are required are:

- Infrastructure as Code
- Logging
- Monitoring
- Autoscaling of applications
- CI/CD
- Security

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

[IBM Cloud Log Analysis with LogDNA Overview](https://ibm.github.io/cloud-enterprise-examples/logging/content-overview)

## 3. Monitoring

Monitoring is key to making sure your applications perform well and are secure in IBM Cloud.
IBM Cloud Monitoring combined partnership with Sysdig and Activity Tracker with LogDNA, provide operational visibility into the performance and health of your applications, services, and platforms. IBM Monitoring offers administrators, DevOps teams and developers full stack telemetry with advanced features to monitor and troubleshoot, define alerts, and design custom dashboards.

[IBM Cloud Monitoring with Sysdig](https://ibm.github.io/cloud-enterprise-examples/monitoring/content-overview)

## 4. CI/CD

## 5. Autoscaling

### 5.1 IBM Kubernetes Service

We can build highly available and scalable applications on IBM Cloud Kubernetes service. In this section, we provide you links to resources that help you set up a IKS cluster on a Virtual Private Cloud, and see the autoscaling in action.

[Overview of autoscaling](https://ibm.github.io/cloud-enterprise-examples/deploy-iks/content-overview)

[Set up IKS and configure the environment](https://ibm.github.io/cloud-enterprise-examples/deploy-iks/setup-environment)

[Deploy a sample web application](https://ibm.github.io/cloud-enterprise-examples/deploy-iks/application-deployment)

[Horizontal Pod Autoscaler in action](https://ibm.github.io/cloud-enterprise-examples/deploy-iks/hpa)

[Cluster Autoscaler in action](https://ibm.github.io/cloud-enterprise-examples/deploy-iks/ca)

## 6. Security

IBM has a long-standing history as a leading security provider. Today, IBM Cloud® builds on that tradition as the most open and secure public cloud for business. Leverage market-leading data protection capabilities to secure your data at rest, in motion and in use.

Achieve continuous security for your enterprise applications and workloads with built-in isolation, access management and integrated security posture. IBM offers unmatched expertise to help your business meet security, quality and compliance objectives.

### 6.1 Certificate Manager

IBM Cloud provides a service to securely handle certificates used for TLS termination by enterprise applications. This service can store certificates provided by certificate authorities and it can also order free certificates from Let's Encrypt.

[Using Certificate Manager to import and order certificates](https://ibm.github.io/cloud-enterprise-examples/certificate-management/service-setup)

[Deploying certificates to VPC Load Balancers](https://ibm.github.io/cloud-enterprise-examples/certificate-management/deploy-to-vpclb)

[Deploying certificates to applications on Kubernetes](https://ibm.github.io/cloud-enterprise-examples/certificate-management/deploy-to-iks/)

### 6.2 IBM Cloud Event Log Integration with Third Party Security Tools

Streaming enables LogDNA to produce content to a message bus queue and Topic. LogDNA streaming helps you to connect third party consumers of topics to ingest into dashboards for visualization of event log data.
Third party horizonal technologies such as Splunk, used in organizations for application management, security and compliance are able to leverage IBM Cloud Log Analysis with LogDNA Streaming.

[IBM Cloud Event Log Integration](https://ibm.github.io/cloud-enterprise-examples/log-streaming/configure-streaming-for-third-party-tools)
