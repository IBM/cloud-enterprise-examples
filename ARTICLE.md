# Introduction

In this article, we will provide you resources or cloud patterns that gets you started with the different capabilities on IBM Cloud.
For any organization to move their applications to the cloud, certain capabilities that are required are:

- Automated provisioning of resources (Infrastructure as code)
- Logging
- Monitoring
- Autoscaling of applications
- CI/CD
- Security

## 1. Automated provisioning of resources (Infrastructure as code)

### 1.1 Infrastructure as code tooling

### 1.2 Using Infrastructre as code to manage resources

Infrastructure as code tools can be used to manage all resource types on IBM Cloud including: Identitiy and Access Management (IAM), Virtual Private Cloud (VPC) networks, Virtual Server Instances for compute, PaaS Cloud services, and Containers with Kubernetes.

[Identity and Access Management Groups and Policies](https://ibm.github.io/cloud-enterprise-examples/iac-resources/iam)

[Virtual Private Cloud Networking](https://ibm.github.io/cloud-enterprise-examples/iac-resources/network)

[Virtual Server Instances](https://ibm.github.io/cloud-enterprise-examples/iac-resources/compute)

[Cloud Services](https://ibm.github.io/cloud-enterprise-examples/iac-resources/services)

[Containers and Kubernetes](https://ibm.github.io/cloud-enterprise-examples/iac-resources/container)

## 2. Logging

## 3. Monitoring

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

### 6.1 Certificate Manager

IBM Cloud provides a service to securely handle certificates used for TLS termination by enterprise applications. This service can store certificates provided by certificate authorities and it can also order free certificates from Let's Encrypt.

[Using Certificate Manager to import and order certificates](https://ibm.github.io/cloud-enterprise-examples/certificate-management/service-setup)

[Deploying certificates to VPC Load Balancers](https://ibm.github.io/cloud-enterprise-examples/certificate-management/deploy-to-vpclb)

[Deploying certificates to applications on Kubernetes](https://ibm.github.io/cloud-enterprise-examples/certificate-management/deploy-to-iks/)
