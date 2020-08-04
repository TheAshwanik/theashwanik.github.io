---
layout: post
title: "Google 2FA with OpenVPN on AWS"
description: "How to install and configure OpenVPN on Raspberry Pi"
date_formatted: 2020-04-02 23:31
date: 2020-04-02
comments: true
categories: [Technical]
tags: Raspberry, PI, OpenVpn, AWS, 2FA, Google Authenticator
keywords: OpenVPN, VPN, Raspberry, PI, OpenVpn, AWS, 2FA, Google Authenticator
---

# **OpenVPN Google authenticator setup**

### **How to enable Google Authenticator**

The Access Server supports the Google Authenticator multi-factor authentication system, but it is not enabled by default. It can be enabled globally via the admin web service (AS 2.7.4 and older) or via the .Authentication" section (AS 2.7.5 and newer) <!-- more--> or via the command line with the command line examples given below. It is also possible to enable or disable the requirement for a Google Authenticator per user or per group on the command line. This can be important if for example for some reason a client device making a VPN connection is unable to provide the Google Authenticator key by itself.

### **Command line configuration parameters**

Disable Google Authenticator globally for all users and groups (the default):
```
./sacli --key "vpn.server.google_auth.enable" --value "false" ConfigPut

./sacli start
```
Enable Google Authenticator globally for all users and groups:
```
./sacli --key "vpn.server.google_auth.enable" --value "true" ConfigPut

./sacli start
```
Disable Google Authenticator for a specific user or group:
```
./sacli --user <USER_OR_GROUP> --key "prop_google_auth" --value "false" UserPropPut
```
Enable Google Authenticator for a specific user or group:
```
./sacli --user <USER_OR_GROUP> --key "prop_google_auth" --value "true" UserPropPut
```

Undo an enable/disable override for Google Authenticator on a group or user, so that it inherits the setting instead:
```
./sacli --user <USER_OR_GROUP> --key "prop_google_auth" UserPropDel
```

To unlock an already scanned and locked secret for a user, so the user can obtain/scan it again:
```
./sacli --user <USER> --lock 0 GoogleAuthLock
```

To manually lock a secret key, for example when you as administrator have already set up the user.s device yourself:
```
./sacli --user <USER> --lock 1 GoogleAuthLock
```

To generate a new secret key and unlock it so the user can enroll anew:
```
./sacli --user <USER> --lock 0 GoogleAuthRegen
```
To generate a new secret key and lock it so the user must obtain the secret key from the server administrator:
```
./sacli --user <USER> --lock 1 GoogleAuthRegen
```
The **GoogleAuthLock** and **GoogleAuthRegen** functions that actually handle these two keys, which can also be edited manually:
```
./sacli --user <USER> --key "pvt_google_auth_secret" --value <GOOGLE_AUTH_SECRET> UserPropPut

./sacli --user <USER> --key "pvt_google_auth_secret_locked" --value <SCANNED/LOCKED> UserPropPut
```
Where <GOOGLE_AUTH_SECRET> must be a 16 character alphanumerical value in capitals and must be known at the Google Authenticator device/application to generate the 6 digit codes, and the <SCANNED/LOCKED> value must be either 1 or 0, indicating that the code is scanned and must now be used by the user, or is awaiting enrollment by the user.

### A few useful commands:
```shell 
cd /usr/local/openvpn_as/scripts

sudo ./confdba -us -p joe _#display info about a user_

{

  "joe": {

  "access_to.0": "+NAT:10.0.0.0/8",

  "pvt_google_auth_secret": "Z********B", _#this is GoogleAuth MFA secret_token that a user scans as QR code_

  "pvt_google_auth_secret_locked": "false",

  "pvt_password_digest": "30******bb71",

  "type": "user_compile"

 }

}

sudo ./confdba -u -m -k pvt_google_auth_secret_locked -v false -p joe _#unlock locked out user_

_#Disable/enable Google Authenticator for a specific user or group:_

./sacli --user <USER_OR_GROUP> --key "prop_google_auth" --value "false" UserPropPut _#disable_

./sacli --user <USER_OR_GROUP> --key "prop_google_auth" --value "true" UserPropPut _#enable_

_#Undo an enable/disable override for Google Authenticator on a group or user, so that it inherits the setting instead_

./sacli --user <USER_OR_GROUP> --key "prop_google_auth" UserPropDel

_#To unlock an already scanned and locked secret for a user, so the user can obtain/scan it again_

./sacli --user <USER> --lock 0 GoogleAuthLock

_#To manually lock a secret key, for example when you as administrator have already set up the user.s device yourself_

./sacli --user <USER> --lock 1 GoogleAuthLock

_#To generate a new secret key and lock or leave it unlocked_

./sacli --user <USER> --lock 0 GoogleAuthRegen _#unlocked, user can scan_

./sacli -u  joe  GoogleAuthRegen _#regenerate Google token, so a user can scan QR code again_

['Z*********B', 'otpauth://totp/OpenVPN:joe@ivpn.acme.com?secret=Z*******B&issuer=OpenVPN']

_#./sacli_ 

_#-u, --user_
```

The GoogleAuthLock and GoogleAuthRegen functions that actually handle these two keys, which can also be edited manually
```
./sacli --user <USER> --key "pvt_google_auth_secret" --value <GOOGLE_AUTH_SECRET> UserPropPut

./sacli --user <USER> --key "pvt_google_auth_secret_locked" --value <SCANNED/LOCKED>  UserPropPut
```
Logs
```
_#Logs_

tail -f /var/log/openvpnas.log
```
When new MFA/Google secret has been generated user need to login to Access Server, scann QR code, then download the Connection Client that the bundle contains the new user settings; this will enable VPN login.

### AWS SSM Document:
Handy AWS Sytems Manager Document that can be used to unlock Google Authenticator for a user. Simply add this Document to Systems Manager and Run it with an instance and the username of the user to unlock. This requires installation of the SSM agent on each OpenVPN instance. You'll probably need to read up on the AWS Systems Manager docs but it is well worth it for this and a whole host of other use cases.

```json
<![endif]-->

{

"schemaVersion": "2.2",

"description": "Unlock the Google Authenticator for a given Username. After doing this, the user must login to the OpenVPN server with their browser and scan the barcode.",

"parameters": { 
	"Username": {
	"description": "Username of the user to unlock",
	"minChars": 3,
	"type": "String"
	}
},

"mainSteps": [
	{
		"action": "aws:runShellScript",
		"name": "OpenVPNASUnlockGoogleAuthenticator",
		"inputs": {
			"runCommand": [
				"#!/bin/bash",
				"cd /usr/local/openvpn_as/scripts",
				
				"sudo ./sacli -u {{ Username }} --lock 0 GoogleAuthLock"
				]
			},
		"precondition":{
		"StringEquals":[
				"platformType",
				"Linux"
				]

		}

	}

]

}
```
### Issues:

Sometimes you would wonder , why is my EC2 instance not appearing under Managed Instances in the Systems Manager console?

A [managed instance](https://docs.aws.amazon.com/systems-manager/latest/userguide/managed_instances.html) is an EC2 instance that is configured for use with Systems Manager. Managed instances can use Systems Manager services such as Run Command, Patch Manager, and Automation workflows.

Instances must meet the following prerequisites to be managed instances:

* Have the AWS Systems Manager Agent (SSM Agent) installed and running.

* Have connectivity with Systems Manager endpoints using the SSM Agent.

* Have the correct AWS Identity and Access Management (IAM) role attached.

Have connectivity to the instance metadata service

Resolution

1. SSM Agent is installed and running on the instance

Latest Ubuntu 18.04 systems that use snap:
```
$ sudo snap services amazon-ssm-agent

Service  Startup  Current  Notes

amazon-ssm-agent.amazon-ssm-agent  enabled  active  -
```
2. Verify connectivity to Systems Manager endpoints on port 443
To test connectivity to endpoints from port 443, use the telnet command. The following example shows how to test connectivity to endpoints in the us-east-1 Region.

```
telnet ssm.us-east-1.amazonaws.com 443
```

```
telnet ec2messages.us-east-1.amazonaws.com 443
```

```
telnet ssmmessages.us-east-1.amazonaws.com 443
```

3. Verify that the correct IAM role is attached to the instance
To use APIs to call a Systems Manager endpoint, the correct IAM role must be attached to the instance. Make sure that the IAM role has the AWS managed policy AmazonSSMManagedInstanceCore attached to it. If you are using a custom IAM policy, make sure that the permissions found under AmazonSSMManagedInstanceCore are used in your custom policy. Also, make sure that the trust policy of the IAM role allows ec2.amazonaws.com to assume this role.

4. Verify connectivity to the instance metadata service
SSM Agent must be able to communicate with the instance metadata service in order to get necessary information about the instance. To test this connection, use the telnet command.

```
telnet 169.254.169.254 80
```

### References
[https://openvpn.net/vpn-server-resources/google-authenticator-multi-factor-authentication/](https://openvpn.net/vpn-server-resources/google-authenticator-multi-factor-authentication/)

[https://openvpn.net/vpn-server-resources/additional-security-command-line-options/](https://openvpn.net/vpn-server-resources/additional-security-command-line-options/)

[https://aws.amazon.com/premiumsupport/knowledge-center/systems-manager-ec2-instance-not-appear/](https://aws.amazon.com/premiumsupport/knowledge-center/systems-manager-ec2-instance-not-appear/)

[https://docs.aws.amazon.com/systems-manager/latest/userguide/agent-install-ubuntu.html](https://docs.aws.amazon.com/systems-manager/latest/userguide/agent-install-ubuntu.html)

