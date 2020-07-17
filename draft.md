---
# Related publishing issue:
draft: true

authors:
- name: "Balaji Kadambi"
  email: "bkadambi@in.ibm.com"

completed_date: "2020-07-16"
last_updated: "2020-07-16"

title: "Quick start guide to migrating and building applications on a public cloud"
sub_title: "Use cloud patterns to implement key IBM Cloud capabilities such as automated provisioning, logging, monitoring, and auto scaling"

excerpt: "This article introduces the IBM Cloud Patterns Guide, which helps enterprise developers quickly leverage key capabilities of IBM Cloud such as Infrastructure as Code, auto scaling, logging, monitoring, and CI/CD."

---

Cloud computing is rapidly proliferating enterprise IT. Organizations want to modernize their legacy applications or build new solutions on the cloud. There are certain key capabilities that most enterprises need for migrating or building applications on a public cloud:

* A secure network with network isolation and access controls.
* Data protection with encryption of data at rest and in motion.
* Access control to the cloud.
* A common shared logging and monitoring infrastructure.
* Deployment with immutable infrastructure as pre-built and pre-tested virtual machine (VM) images and fully automated continuous integration and continuous delivery (CI/CD) pipelines.
* The ability to make allocation match demand with auto scaling of VMs, containers, applications, and platform as a service (PaaS) offerings.

A new [set of cloud patterns](https://ibm.github.io/cloud-enterprise-examples/) are now available to help you quickly get started with the different capabilities of [IBM Cloud](https://cloud.ibm.com/). Each cloud pattern in the IBM Cloud Patterns Guide has detailed instructions to set up and explore a capability. The content is organized into six areas:

1. Infrastructure as Code
2. Logging
3. Monitoring
4. CI/CD
5. Auto scaling
6. Security

The amount of time it will take you to complete the patterns depends upon the areas you want to explore. The authors broke up the content into smaller pieces and each piece should take you anywhere from 15 minutes to two hours to set up and execute. For example, if you wish to learn how to send log events from a virtual server to the LogDNA service, you should be able to complete the task in 30 minutes. If you are exploring a piece under the auto scaling or CI/CD pipelines areas, your completion time can range from one to two hours. The time can vary depending on your expertise in each area.

## 1. Infrastructure as Code

Infrastructure as Code (IaC) is the process of managing and provisioning infrastructure through machine-readable definition files, rather than physical hardware configuration, pointing and clicking on a Web console, or using interactive configuration tools. With IaC, you capture a tedious and error prone provisioning process into code, so every time this code is executed, whether once, twice, or a million times, you get the same outcome. Thus, you reduce errors and obtain expected results.

With IaC, you are not just automating a process through a code, you are also documenting it. This code can be checked into version control to maintain a history of who changed what and how the infrastructure was defined at any given time. Just as with programming code, you can reuse the developed infrastructure code in other projects or infrastructure, which improves your process and produces faster results.

There are multiple IaC tools available, including Terraform by HashiCorp, IBM Cloud Schematics, and Red Hat Ansible. Learn how to use them in the [Infrastructure as Code section](https://ibm.github.io/cloud-enterprise-examples/iac/) of the guide.

## 2. Logging

The IBM Log Analysis with LogDNA service enables you to quickly find the source of an issue while you gain deep insights into your cloud applications. LogDNA provides the aggregation of event logging from your applications and services within the IBM Cloud environment. Learn how to create a LogDNA instance on IBM Cloud, control access with identity and access management, configure for virtual server instances and containers, customize views and notifications, and archive event logs for long term storage in the [Logging section](https://ibm.github.io/cloud-enterprise-examples/logging/content-overview) of the guide.

## 3. Monitoring

Monitoring is key to ensuring your applications perform well and are secure within IBM Cloud. The IBM Cloud Monitoring with Sysdig and IBM Cloud Activity Tracker with LogDNA services provide operational visibility into the performance and health of your applications, services, and platforms. Learn how to use the advanced features of these services to monitor and troubleshoot, define alerts, and design custom dashboard views in the [Monitoring section](https://ibm.github.io/cloud-enterprise-examples/monitoring/content-overview) of the guide.

## 4. CI/CD

Continuous integration is a software development practice where members of a team frequently integrate their work. Each integration is verified by an automated build (including test) to detect integration errors as quickly as possible. Many teams find that this approach leads to significantly reduced integration problems and allows a team to develop cohesive software more rapidly.

Continuous delivery is the DevOps approach of frequently making new versions of application components available for deployment to a runtime environment. The process involves an automation of the build and a validation process. It concludes with a new version of the application that is available for a promotion to another environment. Continuous deployment is closely related to continuous delivery except that an application automatically deploys when it is ready, instead of when manually triggered by a user.

The [CI/CD section](https://ibm.github.io/cloud-enterprise-examples/ci-cd/content-overview) of the guide introduces multiple options for CI/CD tooling that work with IBM Cloud. In particular, this section provides patterns for using IBM Cloud Toolchain and open source cloud-native tools that run on top of Kubernetes or Red Hat OpenShift. Pros and cons to each approach are explored in depth.

## 5. Auto scaling

Auto scaling topics are covered in several sections of the IBM Cloud Patterns Guide. You learn how to configure auto scaling for both a Kubernetes cluster and a virtual server instance (VSI) on a virtual private cloud (VPC).

Auto scaling in Kubernetes comes in two forms: Horizontal Pod Autoscaler (HPA) and Cluster Autoscaler (CA). HPA is auto scaling at the pod level and it scales the pod in a deployment, whereas CA is used to scale nodes in a cluster. The section about [auto scaling of the IBM Kubernetes Service (IKS) on VPC](https://ibm.github.io/cloud-enterprise-examples/deploy-iks/content-overview) provides you with resources to set up an IKS cluster on a VPC and see the auto scaling in action.

With auto scaling for a VPC, you can improve performance and costs by dynamically creating VSIs to meet the demands of your environment. You set scaling policies that define your desired average utilization for metrics like CPU, memory, and network usage. Learn more in the section about [auto scaling of VSIs on a VPC](https://ibm.github.io/cloud-enterprise-examples/deploy-vsi/content-overview/).

There is an additional [resources section](https://ibm.github.io/cloud-enterprise-examples/paas-services-resources/paas-autoscale) in the guide for scaling PaaS services such as IBM Event Streams, IBM Cloud Databases for MongoDB, IBM Cloud Databases for PostgreSQL, IBM Db2 on Cloud, and IBM Cloud Object Storage.

## 6. Security

Data protection capabilities within IBM Cloud help secure your data at rest, in motion, and in use. For example, IBM Cloud provides a service to securely handle certificates used for Transport Layer Security (TLS) termination by enterprise applications. This service can store certificates provided by certificate authorities and it can also order free certificates from Let's Encrypt. Learn how to use the IBM Cloud Certificate Manager to import and order certificates, and how to deploy certificates to VPC load balancers and Kubernetes applications in the [Managing Certificates section](https://ibm.github.io/cloud-enterprise-examples/certificate-management/service-setup) of the guide.

## Conclusion

The [IBM Cloud Patterns Guide](https://ibm.github.io/cloud-enterprise-examples/) provides a quick start on many capabilities of IBM Cloud. It is a ready reference for you to validate and understand cloud capabilities, and it can also reduce your learning curve when getting started on IBM Cloud. Thank you to the following IBM developer advocates for their work in creating the guide: Raj Patil, [Tim Robinson](https://developer.ibm.com/profiles/timro/), Matthew Perrins, Johandry Amador, [Shikha Maheshwari](https://developer.ibm.com/profiles/shikha.mah/), [John Zaccone](https://developer.ibm.com/profiles/john.zaccone/), Anthony Fuller, and Saranyya Chillal.
