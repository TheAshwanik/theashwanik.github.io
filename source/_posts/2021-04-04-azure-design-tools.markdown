---
layout: post
title: "Azure Design tools"
description: "Shapes, icons, tools and recommendations to document your Azure Environment!"
date: 2021-04-04 12:03:38 +0100
comments: true
tags: [azure, architecture]
categories: [ Azure, Architecture, Tools ]
---

_In this article I like to give you an overview about resources that helps you to visualize and document your Azure cloud solutions and environments._

# Shapes and icon sets
## Azure Design Visio VSSX
David Summers started an "Azure Icon Design project" to collect icons in Visio format (VSSX). You'll find the icon set from his GitHub repo:  
[https://github.com/David-Summers/Azure-Design](https://github.com/David-Summers/Azure-Design)
 
## Azure-Stencils (VSSX und SVG)
There is just another GitHub repository by "azurekid" with many (categorized) icons in Visio format (VSSX) and SVG:  
[https://github.com/azurekid/Azure-Stencils](https://github.com/azurekid/Azure-Stencils)

## Microsoft Azure UX Patterns
Few hundreds icons in SVG format are also available from the "official" Microsoft Azure site:  
[https://azure.microsoft.com/en-us/patterns/styles/glyphs-icons/](https://azure.microsoft.com/en-us/patterns/styles/glyphs-icons/)

## Microsoft Integration Stencils Pack for Visio
Microsoft updates regular this Visio stencils package with many symbols of on-premises, hybrid and cloud services/products:
[https://gallery.technet.microsoft.com/Collection-of-Integration-e6a3f4d0#content](https://gallery.technet.microsoft.com/Collection-of-Integration-e6a3f4d0)

## Microsoft Azure, Cloud and Enterprise   Symbol / Icon Set
The most updated collection of cloud related icons by Microsoft is the following one. It includes (categorized) symbols  in SVG format:
[https://www.microsoft.com/en-us/download/details.aspx?id=41937](https://www.microsoft.com/en-us/download/details.aspx?id=41937)

# Drawing your architecture (Samples)
## Azure Solutions Architectures
Microsoft's Azure solution architecture page shows some well-designed samples of reference architectures. This could be an inspiration to design your own architecture draws:  
[https://azure.microsoft.com/en-us/solutions/architecture/](https://azure.microsoft.com/en-us/solutions/architecture/)

## Microsoft 3D Visio Templates
You have probably already seen some beautiful Azure 3D blueprints from Microsoft (in the recent years). In this video you will get an introduction of using a Visio template that allows to create such isometric blueprints:  
[Microsoft 3D Blueprint Visio Training Video](https://www.youtube.com/watch?v=Tag2HNAJh4Y)

Microsoft has moved to a flatter style in the current architecture draws.
The development of this template has stopped in 2017 but it's still available from the Microsoft Download-Center:  
[Microsoft 3D Blueprint Visio Template Download](https://www.microsoft.com/en-us/download/48243)

# Online Diagram Tools
## Visual Paradigm Online Diagram
This cross-platform diagram solution includes standard Azure icons and samples to start drawing your own Azure diagram:  
[https://online.visual-paradigm.com](https://online.visual-paradigm.com/)

## Draw.io
The following diagram solution is a very popular free-to-license web app with integration in Atlassian products and other features (e.g. VSSX import, OneDrive-support).
Check out the various "Cloud" templates (including AWS, Azure and GCP) by clicking on "create new diagrams".  
I can strongly recommended to give them a try.  
[https://about.draw.io/](https://about.draw.io/)

## Represent Azure architectures accurately in Visio Online
You are using Vision Online? Take a look on the library which includes already Azure symbols, templates, and sample diagrams:
[https://techcommunity.microsoft.com/t5/Visio-Blog/Represent-Azure-architectures-accurately-in-Visio-Online/ba-p/274650](https://techcommunity.microsoft.com/t5/Visio-Blog/Represent-Azure-architectures-accurately-in-Visio-Online/ba-p/274650)

# Visualizer and Automated Documentation
## Azure Resource Visualizer
Using ARM parameter and template files are parts of Azure's native "Infrastructure as Code" approach but are also one of the best ways to document your deployment.
Visualizing your Azure resources based on your ARM files is (in my opinion) also a great option. Even in your draft phase this helps to visualize and review your planned solution.


That's why ARMViz was my first choice over the past years - available as online tool or install package (to run it in your own environment):
[https://github.com/ytechie/AzureResourceVisualizer](https://github.com/ytechie/AzureResourceVisualizer)
[http://armviz.io/designer](http://armviz.io/designer)

Unfortunately it seems that ARMViz is outdated and have been abandoned.
Ben Coleman started a project ("ARM Template Viewer") and released a first version of a VSCode extension to displays a graphical view of an opened ARM template file. Great user experience and value for ARM authors! Strongly recommended to check out the extension:
[https://marketplace.visualstudio.com/items?itemName=bencoleman.armview](https://marketplace.visualstudio.com/items?itemName=bencoleman.armview)

## Cloudockit
This tool allows you to generate documentation and diagrams for your Azure and other cloud service platforms (AWS, GCP, ...) environment as well. Exportable as document type for Excel, Word, Visio and Draw.io.  
Product details (subscription price) and trial version are available here:  
[https://www.cloudockit.com](https://www.cloudockit.com/)

## CloudCraft.co
Easy to use and popular architecture diagram generator.
Unfortunately (full) support only for AWS environment (status: 09/30/2019). 
Advanced collaboration and editing/export features (e.g. Draw.io support) included.  
Free version and pricing details are available:  
[http://cloudcraft.co](http://cloudcraft.co/)
 
# General advice on writing design documentations
1. **Define an efficient documentation structure:** Start with a short introduction of your key points such as scope, business/compliance requirements or technical background (initial situation).
All your design documentations should follow a common schema.
2. **Describe the relation of your designed solution to the general (cloud) architecture:** This is very important if your solution has dependency or strong references to other design decisions or guidelines.
3. **Start with a picture instead of using thousand words:** Describe your solution based on a well-designed architecture draw (in formats that can be easily modified by design changes)
4. **Capture the decisions (including pros and cons):** What were the reasons for the planned solutions? Review your design decision and the reasons to having cut off other variants?
5. **Design vs. implementation/operation guide**: Move details about implementation or specification to the appendix or splitting the documentation between architecture (design) document and implementation guide.



_If you want to learn more about architecture and design patterns in Azure this study collection might be interesting for you._

# Architecture & Patterns
## Azure for Architects (Free Edition)
You are looking for a book to start with the foundation of designing solutions in Azure? General guidance of core topics e.g. Azure Resource Manager (Templates), architectural considerations and overview of some Azure services are included in the following book.  You'll receive a free copy (e-book) from Microsoft:  
 [https://azure.microsoft.com/en-us/resources/azure-for-architects/](https://azure.microsoft.com/en-us/resources/azure-for-architects/) 

## AzureCAT Guidance
Microsoft's CAT stands for "Customer Advisory Team" and actively assists with customers in complex projects and take the learning backs to the product teams.
You'll find the white papers and resources of CAT here:  
[http://aka.ms/CAT](http://aka.ms/CAT)

## Azure Architecture Center
This is one of the most valuable sources for cloud architects. Including reference architecture of the most common solutions in Azure. Microsoft's cloud adoption framework and design patterns are also part of this library.  
[https://docs.microsoft.com/en-us/azure/architecture/](https://docs.microsoft.com/en-us/azure/architecture/)

### Azure Security Architecture
"Shared responsibility" and "modern perimeter" ("Zero Trust") are just few aspects of cloud transformation and IT modernization in mostly every organization. This section of the "Azure Architecture center" describes many best practices, reference architectures and recommendations that are related for architects or security administrators.  
[https://docs.microsoft.com/en-us/azure/architecture/security/overview](https://docs.microsoft.com/en-us/azure/architecture/security/overview) 

### Azure Application Architecture Guide
This guide gives you an overview and introduction on how to design and implement software architecture and applications in Azure. Great resource if you are interested to compare traditional on-premises and modernized cloud approaches.  
[https://docs.microsoft.com/azure/architecture/guide/](https://docs.microsoft.com/azure/architecture/guide/) 

## Microsoft 365 Enterprise foundation infrastructure
First you should build a strong foundation before you're starting the deployment of Microsoft 365 in your organization. The following deployment guide (divided up into several phases) is a great way for planning the most foundational subjects (from Network, Identity until Mobile Devices) on your journey to introduce Microsoft 365 services:  
[https://docs.microsoft.com/en-us/microsoft-365/enterprise/deploy-foundation-infrastructure](https://docs.microsoft.com/en-us/microsoft-365/enterprise/deploy-foundation-infrastructure)

## Microsoft Cloud IT architecture resources
If you like to learn more about core cloud architecture concepts for Microsoft identity, security and network this resource is very helpful:  
 [https://docs.microsoft.com/en-us/office365/enterprise/microsoft-cloud-it-architecture-resources)](https://docs.microsoft.com/en-us/office365/enterprise/microsoft-cloud-it-architecture-resources) 

## Serverless apps: Architecture, patterns and Azure implementations
The following e-book is a perfect (starter) guide to get an overview of "Serverless apps" in Azure. This includes benefits, potential solutions and different design patterns in developing cloud native development using serverless computing.  
[https://aka.ms/serverless-ebook](https://aka.ms/serverless-ebook) 

# Cloud Computing Services
## Enterprise Cloud Strategy
Definition of cloud strategy and roadmap are a key point before starting the transformation of an organization.
You can get a free copy of the e-book "Enterprise Cloud Strategy" by Microsoft which includes general aspects of moving to cloud computing (costs, cloud models, etc.):  
[https://azure.microsoft.com/en-us/resources/enterprise-cloud-strategy/](https://azure.microsoft.com/en-us/resources/enterprise-cloud-strategy/)

## Compare Cloud solutions
In a world of various cloud services and provides it is hard to compare and keep the different product names in mind.
This page helps to compare the name of several offerings between Azure, AWS, IBM and other major providers:  
 [http://comparecloud.in/](http://comparecloud.in/) 

## How I choose which services to use in Azure?
This is one of the most common question if you are designing or migrating services. The following articles shows a good approach to find the right answer:  
* [How I choose which services to use in Azure?](https://azure.microsoft.com/en-us/blog/how-i-choose-which-services-to-use-in-azure/)  
* [Decision tree for Azure compute services](https://docs.microsoft.com/en-us/azure/architecture/guide/technology-choices/compute-decision-tree)  
* [Criteria for choosing an Azure compute service](https://docs.microsoft.com/en-us/azure/architecture/guide/technology-choices/compute-comparison)  
<br>


Original content here: https://www.cloud-architekt.net/ 
