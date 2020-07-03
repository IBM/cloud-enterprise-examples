# Introduction

In this article, we will provide you resources in the form of cloud patterns to help you get started with the different capabilities on IBM Cloud.
For any organization to move their applications to the cloud, certain capabilities that are required are:

- Infrastructure as Code
- Logging
- Monitoring
- Autoscaling of applications
- CI/CD
- Security

In the sections below, we cover each of these areas to help you start the journey to migrate or build applications om IBM Cloud.

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

[Deployment Architecture](https://ibm.github.io/cloud-enterprise-examples/logging/deployment-architecture)

[Controlling Access with IBM Cloud IAM, Configuring users, groups and applications permissions for Event Logs](https://ibm.github.io/cloud-enterprise-examples/logging/controlling-access)

[Configure Virtual Server for LogDNA](https://ibm.github.io/cloud-enterprise-examples/logging/configure-virtual-server)

[Configure containers for LogDNA](https://ibm.github.io/cloud-enterprise-examples/logging/configuring-for-containers)

[Customizing Event Log Views, Configuring Alert Notifications, configuring preset and alerts](https://ibm.github.io/cloud-enterprise-examples/logging/customize-alerts)

[Archive event Logs using IBM Cloud Object Storage (COS)](https://ibm.github.io/cloud-enterprise-examples/logging/archive-logs-for-long-term-storage)

## 3. Monitoring

Monitoring is key to making sure your applications perform well and are secure in IBM Cloud.
IBM Cloud Monitoring combined partnership with Sysdig and Activity Tracker with LogDNA, provide operational visibility into the performance and health of your applications, services, and platforms. IBM Monitoring offers administrators, DevOps teams and developers full stack telemetry with advanced features to monitor and troubleshoot, define alerts, and design custom dashboards.

[IBM Cloud Monitoring with Sysdig](https://ibm.github.io/cloud-enterprise-examples/monitoring/content-overview)

[Customize Monitor Alerts](https://ibm.github.io/cloud-enterprise-examples/monitoring/customizing-and-alerts)

[Configuring Monitoring for Resource](https://ibm.github.io/cloud-enterprise-examples/monitoring/configuring-monitoring-for-resources)

[Controlling Access to Monitoring Metrics and Event Data](https://ibm.github.io/cloud-enterprise-examples/monitoring/controlling-access-to-metrics-and-event-data)

## 4. CI/CD

### 5.1 Continuous Integration
Continuous Integration is a software development practice where members of a team integrate their work frequently, usually each person integrates at least daily - leading to multiple integrations per day. Each integration is verified by an automated build (including test) to detect integration errors as quickly as possible. Many teams find that this approach leads to significantly reduced integration problems and allows a team to develop cohesive software more rapidly

### 5.2 Continuous Delivery
Continuous delivery is the DevOps approach of frequently making new versions of an application’s components available for deployment to a runtime environment. The process involves automation of the build and validation process and concludes with a new version of the application that is available for promotion to another environment.

Continuous deployment is closely related to continuous delivery except that in continuous deployment an application automatically deploys when it is ready instead of when manually triggered by a user.

### 5.3 CI/CD with IBM Cloud Public
The advantage of using IBM Cloud Toolchain is that it integrates seamlessly with all resources already deployed on IBM Cloud while providing full DevOps capabilities provided by the Open Toolchain. There are some built-in features as well such as enabling DevOps Insights to give you aggregate view of all tests that are running in your pipeline.

[Go here](https://ibm.github.io/cloud-enterprise-examples/ci-cd/cloud-toolchain-setup) to get started.

### 5.4 CI/CD with Cloud Native Tools
One of the patterns emerging with development teams is the ability to use CNCF Tools as part of a more open multi cloud CI/CD strategy. This approach is aligning around the Kubernetes platform. The IBM Cloud supports both upstream Kubernetes for advanced cutting edge workloads and Red Hat OpenShift the proven multi-cloud distribution of Kubernetes that can install on IBM Cloud, Azure, AWS, VMWare and on Premise and many more places. This approach removes cloud vendor lock in around CI/CD tools and enables development teams to be more flexible and the target cloud they focus on deploying and developing with.

[Go here](https://ibm.github.io/cloud-enterprise-examples/ci-cd/cloud-native-setup) to get started.

## 5. Autoscaling

### 5.1 IBM Kubernetes Service

We can build highly available and scalable applications on IBM Cloud Kubernetes service. In this section, we provide you links to resources that help you set up a IKS cluster on a Virtual Private Cloud, and see the autoscaling in action.

[Overview of autoscaling](https://ibm.github.io/cloud-enterprise-examples/deploy-iks/content-overview)

[Set up IKS and configure the environment](https://ibm.github.io/cloud-enterprise-examples/deploy-iks/setup-environment)

[Deploy a sample web application](https://ibm.github.io/cloud-enterprise-examples/deploy-iks/application-deployment)

[Horizontal Pod Autoscaler in action](https://ibm.github.io/cloud-enterprise-examples/deploy-iks/hpa)

[Cluster Autoscaler in action](https://ibm.github.io/cloud-enterprise-examples/deploy-iks/ca)

### 5.2 Virtual Server on Virtual Private Cloud

Virtual server instances for VPC give you access to all of the benefits of IBM Cloud VPC, including network isolation, security, and flexibility. With virtual server instances for VPC, you can quickly provision instances with high network performance. When you provision an instance, you select a profile that matches the amount of memory and compute power that you need for the application that you plan to run on the instance. Instances are available on both x86 and POWER architectures. After you provision an instance, you control and manage those infrastructure resources. 

With Auto Scale for VPC, you can improve performance and costs by dynamically creating virtual server instances to meet the demands of your environment. You set scaling policies that define your desired average utilization for metrics like CPU, memory, and network usage. 

Please refer to the below resources to see autoscaling in action:

[Overview](https://ibm.github.io/cloud-enterprise-examples/deploy-vsi/content-overview)

[Set up environment](https://ibm.github.io/cloud-enterprise-examples/deploy-vsi/setup-environment)

[Autoscaling in action](https://ibm.github.io/cloud-enterprise-examples/deploy-vsi/monitor-vsi)

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
