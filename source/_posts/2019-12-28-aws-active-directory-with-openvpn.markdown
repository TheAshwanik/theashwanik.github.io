---
layout: post
title: "AWS Active Directory with OpenVPN"
description: How to setup AWS Active Directory with OpenVPN
date_formatted: 2019-12-28 23:06
date: 2019-12-28
comments: true
categories: [Technical]
tags: AWS, Active Directory, OpenVpn
keywords: AWS Active Directory, AWS Directory Services, AWS AD, OpenVPN, VPN, Bastion
---

Many wonder what the benefits of Active Directory are in the modern era. We can leverage Active Directory to control access to resources. One absolutely great feature is Group Policy Objects (GPOs). GPOs enables seamless monitoring of Windows machines with Policies like OS updates, screen lock, and more.

Recently I did some probono work for one of the commpanies in UK and thought of documenting some setup required for [AWS MS Active Directory <!--more--> - Aka. Directory Services](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/directory_microsoft_ad.html) and [OpenVPN](https://openvpn.net/vpn-server-resources/amazon-web-services-ec2-byol-appliance-quick-start-guide/)

### Prerequistites
1.  [Launch Active Directory](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/ms_ad_getting_started_create_directory.html)   
2.  Setup you own EC2 instance and install Open VPN, or [Launch OpenVPN Access Server from AWS Market place](https://aws.amazon.com/marketplace/pp/OpenVPN-Inc-OpenVPN-Access-Server/B00MI40CAE)   
3.  You will need an EC2 instance to manage the Active Directory objects, See further how to Install the Active Directory Administration Tools on Windows Server 2016

### Target Architecture
{% img /assets/AWS-VPN-AD-Architeture.jpg 800 600 "AWS-VPN-AD-Architeture" "AWS-VPN-AD-Architeture Image" %}

<!-- <img style="-webkit-user-select: none;margin: auto;cursor: zoom-in;" src="https://lh3.googleusercontent.com/d/13tbYV0DdzptknM0VFIVWzDjrO3qxo76H?authuser=0"> -->

### Active Directory Management   
[Manage Users and Groups in AWS Managed Microsoft AD](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/ms_ad_manage_users_groups.html)    
[Create User](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/ms_ad_manage_users_groups_create_user.html)   

### Manually Join EC2 Instance to the AD
To [manually join](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/join_windows_instance.html) an existing Amazon EC2 Windows instance to a Simple AD or AWS Directory Service for Microsoft Active Directory directory, the instance must be launched as specified in [Seamlessly Join a Windows EC2 Instance](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/launching_instance.html)   

To join a Windows instance to a Simple AD or AWS Managed Microsoft AD directory   
Connect to the instance using any Remote Desktop Protocol client.   
Open the TCP/IPv4 properties dialog box on the instance.   
Open Network Connections usisng command.      
```
%SystemRoot%\system32\control.exe ncpa.cpl
```    
Change the DNS server addresses, change the Preferred DNS server and Alternate DNS server addresses to the IP addresses of the AWS Directory Service-provided DNS servers.    
                            
Open the System Properties dialog box for the instance, select the Computer Name tab, and choose Change.    
```
Use command %SystemRoot%\system32\control.exe sysdm.cpl
```

In the Member of field, select Domain, enter the fully-qualified name of your AWS Directory Service directory, and choose OK.    
When prompted for the name and password for the domain administrator, enter the username and password of an account that has domain join privileges.     
For more information about delegating these privileges, see Delegate Directory Join Privileges for AWS Managed Microsoft AD.   

Note:   
You can enter either the fully-qualified name of your domain or the NetBios name, followed by a backslash (\), and then the user name, in this case, Admin. For example, corp.example.com\Admin or corp\Admin.     

Restart the instance to have the changes take effect.    


### To allow domain users RDP access to the domain joined Windows instances, follow these steps:    
You will get error "The connection was denied because the user account is not authorized for remote login."    
To solve it follow this:    
Connect to your Windows EC2 instance using RDP.     
Create a user. Repeat this step if you need more than one user.     
Create a security group.    
Add the new users to the new security group.    
Open Group Policy Management. Select your domain.s Forest, expand Domains, and then expand your domain name.    
Expand your delegated OU (NetBIOS name of the directory). Open the context (right-click) menu for Computers, and then choose Create a GPO in this domain, and Link it here.    
For Name, enter a name, and then choose Ok.     
In the navigation pane, expand Computers. Open the context (right-click) menu for the policy, and then choose Edit.     
In the Computer Configuration section of the navigation pane, expand Preferences, Control Panel Settings.    
Open the context (right-click) menu for Local Users and Groups, and then choose New, Local Group.     
For Group name, choose Remote Desktop Users (built-in), and then choose Add.      
For Name, enter the name of the security group that you created in step 3, and then choose Ok.    
This policy updates your environment at the next policy refresh interval. To force the policy to apply immediately, run the gpupdate /force command on the target server.    

### Install the Active Directory Administration Tools on Windows Server 2016  
Open Server Manager from the Start screen by choosing Server Manager.   
In the Server Manager Dashboard, choose Add roles and features,   
In the Add Roles and Features Wizard choose Installation Type, select Role-based or feature-based installation, and choose Next.     
Under Server Selection, make sure the local server is selected, and choose Features in the left navigation pane.    
In the Features tree, open Remote Server Administration Tools, Role Administration Tools, select AD DS and AD LDS Tools, scroll down and select DNS Server Tools, and then choose Next.    
Review the information and choose Install. When the feature installation is finished, the Active Directory tools are available on the Start screen in the Administrative Tools folder.    
    
### Manage GPO permissions
[..](https://www.lepide.com/how-to/assign-permissions-to-files-folders-through-group-policy.html)

### Open VPN
[Authenticate VPN using LDAP](https://openvpn.net/vpn-server-resources/how-to-authenticate-users-with-active-directory/)     
[Authenticate VPN using LDAP - Another article](https://openvpn.net/vpn-server-resources/openvpn-access-server-on-active-directory-via-ldap/)     


#### Further Readings:
[How to Set Up DNS Resolution Between On-Premises Networks and AWS Using AWS Directory Service and Microsoft Active Directory](https://aws.amazon.com/blogs/security/how-to-set-up-dns-resolution-between-on-premises-networks-and-aws-using-aws-directory-service-and-microsoft-active-directory/)      
[How to Easily Log On to AWS Services by Using Your On-Premises Active Directory](https://aws.amazon.com/blogs/security/how-to-easily-log-on-to-aws-services-by-using-your-on-premises-active-directory/)   


Hope this will help someone.    




