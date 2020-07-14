---
layout: post
title: "Install Hashicorp Vault on a Credit card sized computer - RaspberryPi"
description: Install Hashicorp Vault on a Credit card sized computer - RaspberryPi
date_formatted: 2020-05-12 08:43
date: 2020-05-12
comments: true
categories: [Technical]
tags: security, hashicorp, vault
keywords: security, hashicorp vault, vault, token auth, HSM, raspberryPi
---

We want to discuss about one of growing secret service, which can be used with most of cloud services and DevOps tools. 
In this guide, will explain about How to Setup HashiCorp Vault on RaspberryPi.

{% codeblock %}
cat /etc/os-release
PRETTY_NAME="Raspbian GNU/Linux 9 (stretch)"
NAME="Raspbian GNU/Linux"
VERSION_ID="9"
VERSION="9 (stretch)"
VERSION_CODENAME=stretch
ID=raspbian
ID_LIKE=debian
HOME_URL="http://www.raspbian.org/"
SUPPORT_URL="http://www.raspbian.org/RaspbianForums"
BUG_REPORT_URL="http://www.raspbian.org/RaspbianBugs"

{% endcodeblock %}



Note: In this blog, we're using the filesystem backend to store encrypted secrets on the local filesystem at ~/Hashicorp/vault-data. This is suitable for local or single-server deployments that do not need to be replicated. This is not suitable for HA Setup.

Introduction

Vault is an open-source tool that provides a secure, reliable way to store and distribute secrets like API keys, access tokens, and passwords. Software like Vault can be critically important when deploying applications that require the use of secrets or sensitive data.

To download latest vault package, Go to Hashicorp vault downloads page and download the latest package. 
I am using this:

https://releases.hashicorp.com/vault/1.4.3/vault_1.4.3_linux_arm.zip

Unzip the package
{% codeblock %}
unzip vault_1.4.3_linux_arm.zip
{% endcodeblock %}

Make the vault executable to /usr/bin
{% codeblock %}
sudo mv vault /usr/bin/
{% endcodeblock %}

Checking its version.
{% codeblock %}
vault -v
{% endcodeblock %}

Finally, set a Linux capability flag on the binary. This adds extra security by letting the binary perform memory locking without unnecessarily elevating its privileges.

{% codeblock %}
sudo setcap cap_ipc_lock=+ep /usr/bin/vault
{% endcodeblock %}

Create vault data folder.

{% codeblock %}
sudo mkdir ~/hashicorp/vault-data
{% endcodeblock %}

Creating the Vault startup file
{% codeblock %}
sudo useradd -r -d ~/hashicorp/vault-data -s /bin/nologin vault
{% endcodeblock %}
Set the ownership of /vault-data to the vault user and the vault group exclusively.
{% codeblock %}
sudo install -o vault -g vault -m 750 -d ~/hashicorp/vault-data
{% endcodeblock %}
Now let’s set up Vault’s configuration file, /etc/vault.hcl
{% codeblock %}
sudo vi /etc/vault.hcl
ui = true
storage "file" {
  path = "/home/theashwanik/hashicorp/vault-data""
}
listener "tcp" {
 address     = "0.0.0.0:8200"
 tls_disable = 1
}
{% endcodeblock %}

Change ownership
{% codeblock %}
sudo chown vault:vault /etc/vault.hcl
sudo chmod 640 /etc/vault.hcl
{% endcodeblock %}

Startup script /etc/systemd/system/vault.service
{% codeblock %}
sudo vi /etc/systemd/system/vault.service

[Unit]
Description=HashiCorp Vault to manage secrets
Documentation=https://vaultproject.io/docs/
After=network.target
ConditionFileNotEmpty=/etc/vault.hcl

[Service]
User=vault
Group=vault
ExecStart=/usr/bin/vault server -config=/etc/vault.hcl
ExecReload=/usr/local/bin/kill --signal HUP $MAINPID
CapabilityBoundingSet=CAP_SYSLOG CAP_IPC_LOCK
AmbientCapabilities=CAP_IPC_LOCK
SecureBits=keep-caps
NoNewPrivileges=yes
KillSignal=SIGINT

[Install]
WantedBy=multi-user.target

{% endcodeblock %}

#Start the service using following command
{% codeblock %}
systemctl deamon-reload  
systemctl start vault.service  
systemctl status vault.service  
{% endcodeblock %}

##Initialize Vault

There are two pieces of information that Vault will expose at initialization time that will not be available at any other point, so make sure you noted some secure place,

    Initial root token: This is equivalent to root permissions to your Vault deployment, which allows the management of all Vault policies, mounts, and so on.

    Unseal keys: These are used to unseal Vault when the daemon starts, which permits the Vault daemon to decrypt the backend secret stor

{% codeblock %}
vim /etc/systemd/system/vault.service
{% endcodeblock %}

#### Seal/Unseal
Every initialized Vault server starts in the sealed state. From the configuration, Vault can access the physical storage, but it can't read any of it because it doesn't know how to decrypt it. The process of teaching Vault how to decrypt the data is known as unsealing the Vault.

Unsealing has to happen every time Vault starts. It can be done via the API and via the command line. To unseal the Vault, you must have the threshold number of unseal keys. In the output above, notice that the "key threshold" is 3. This means that to unseal the Vault, you need 3 of the 5 keys that were generated.

Note: Vault does not store any of the unseal key shards. Vault uses an algorithm known as [Shamir's Secret](https://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing) Sharing to split the master key into shards. Only with the threshold number of keys can it be reconstructed and your data finally accessed.

##Initialize vault to get the keys.

{% codeblock %}
vault operator init
Unseal Key 1: UBXbFKpvvytWeR3rUWi1k3xxxxxxxxxK8LIKtdMGvsjA
Unseal Key 2: 13sjixnJMSvNyANqwdxxxxxxxxE3OPd/izsg8nezTv3F
Unseal Key 3: /Jo+IW40WN7UQZXL6TxxxxxxxQAABhdlwth8IenTuduV
Unseal Key 4: 8YkysMXH/rsS3GOdCfW1qEwBiBk4JaKSXPjv/B0StaSF
Unseal Key 5: RRqXVkJ7o0nSsYxxxxxxxFUvvONI2meiF+E+dhssnSdO

Initial Root Token: s.VCVsxxxxxxxYMaxeYbMBUNPF0
{% endcodeblock %}
By default, vault will be sealed. It should be unsealed with minimum of three unseal keys as shown below.

{% codeblock %}
vault operator unseal UBXbFKpvvytWeR3rUWi1k3xxxxxxxxxK8LIKtdMGvsjA
vault operator unseal 13sjixnJMSvNyANqwdxxxxxxxxE3OPd/izsg8nezTv3F
vault operator unseal RRqXVkJ7o0nSsYxxxxxxxFUvvONI2meiF+E+dhssnSdO

theashwanik@ashberrypi:~/hashicorp/vault $   vault operator unseal UBXbFKpvvytWeR3rUWi1k3xxxxxxxxxK8LIKtdMGvsjA
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    1/3
Unseal Nonce       634a8b1a-6d15-d4a3-740f-f6b8f01a4a37
Version            1.4.3+ent
HA Enabled         false
theashwanik@ashberrypi:~/hashicorp/vault $  vault operator unseal 13sjixnJMSvNyANqwdxxxxxxxxE3OPd/izsg8nezTv3F
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    2/3
Unseal Nonce       634a8b1a-6d15-d4a3-740f-f6b8f01a4a37
Version            1.4.3+ent
HA Enabled         false
theashwanik@ashberrypi:~/hashicorp/vault $  vault operator unseal RRqXVkJ7o0nSsYxxxxxxxFUvvONI2meiF+E+dhssnSdO
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    5
Threshold       3
Version         1.4.3+ent
Cluster Name    vault-cluster-7944b651
Cluster ID      2573fdfa-01a5-19e1-8a20-0cd5fcc89df8
HA Enabled      false


{% endcodeblock %}


Check the status
{% codeblock %}
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    5
Threshold       3
Version         1.4.3+ent
Cluster Name    vault-cluster-7944b651
Cluster ID      2573fdfa-01a5-19e1-8a20-0cd5fcc89df8
HA Enabled      false

{% endcodeblock %}


Note: Every time you restart vault or if it gets restarted during server restarts, you need to perform the unseal operation using the same unseal key.

You can also access the vault UI on port 8200 of your vault server.

{% codeblock %}
http://192.168.1.111:8200/ui/
{% endcodeblock %}


# Usage 
 
## Create secrets at the kv/my-secret path.
{% codeblock %}

$ vault kv put kv/my-secret value="s3c(eT"
Success! Data written to: kv/my-secret
{% endcodeblock %}

##Read the secrets at kv/my-secret.
{% codeblock %}
$ vault kv get kv/my-secret

==== Data ====
Key      Value
---      -----
value    s3c(eT
{% endcodeblock %}


## Delete the secrets at kv/my-secret.
{% codeblock %}
$ vault kv delete kv/my-secret
Success! Data deleted (if it existed) at: kv/my-secret
{% endcodeblock %}

## List existing keys at the kv path.
{% codeblock %}

$ vault kv list kv/

Keys
----
hello
{% endcodeblock %}

## Disable a Secrets Engine
When a secrets engine is no longer needed, it can be disabled. When a secrets engine is disabled, all secrets are revoked and the corresponding Vault data and configuration is removed.

{% codeblock %}
$ vault secrets disable kv/
Success! Disabled the secrets engine (if it existed) at: kv/
{% endcodeblock %}

Note that this command takes a PATH to the secrets engine as an argument, not the TYPE of the secrets engine.


## Dynamic Secret Engines:
{% codeblock %}
vault secrets enable -path=aws aws
Success! Enabled the aws secrets engine at: aws/
{% endcodeblock %}

## Getting help   

{% codeblock %}
vault path-help aws

DESCRIPTION

The AWS backend dynamically generates AWS access keys for a set of
IAM policies. The AWS access keys have a configurable lease set and
are automatically revoked at the end of the lease.

After mounting this backend, credentials to generate IAM keys must
be configured with the "root" path and policies must be written using
the "roles/" endpoints before any access keys can be generated.

PATHS

The following paths are supported by this backend. To view help for
any of the paths below, use the help command with any route matching
the path pattern. Note that depending on the policy of your auth token,
you may or may not be able to access certain paths.

    ^(creds|sts)/(?P<name>\w(([\w-.@]+)?\w)?)$
        Generate AWS credentials from a specific Vault role.

    ^config/lease$
        Configure the default lease information for generated credentials.

    ^config/root$
        Configure the root credentials that are used to manage IAM.

    ^config/rotate-root$
        Request to rotate the AWS credentials used by Vault

    ^roles/(?P<name>\w(([\w-.@]+)?\w)?)$
        Read, write and reference IAM policies that access keys can be made for.

    ^roles/?$
        List the existing roles in this backend
{% endcodeblock %}


## Authentication

{% codeblock %}

vault token create
Key                  Value
---                  -----
token                s.7vM3kUTFSNxxxxxxxxxf4f8R9
token_accessor       Dtuk4LtxxxxxxxrEDNXiB5EZ
token_duration       ∞
token_renewable      false
token_policies       ["root"]
identity_policies    []
policies             ["root"]

{% endcodeblock %}
The token is created and displayed here as s.7vM3kUTFSNxxxxxxxxxf4f8R9. Each token that Vault creates is unique.


{% codeblock %} 
vault login s.7vM3kUTFSNxxxxxxxxxf4f8R9
WARNING! The VAULT_TOKEN environment variable is set! This takes precedence
over the value set by this command. To use the value set by this command,
unset the VAULT_TOKEN environment variable or set it to the token displayed
below.

Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.

Key                  Value
---                  -----
token                s.7vM3kUTFSNxxxxxxxxxf4f8R9
token_accessor       Dtuk4LtxxxxxxxrEDNXiB5EZ
token_duration       ∞
token_renewable      false
token_policies       ["root"]
identity_policies    []
policies             ["root"]

{% endcodeblock %} 
	

When a token is no longer needed it can be revoked.

Revoke the first token you created.
{% codeblock %}
$ vault token revoke s.7vM3kUTFSNxxxxxxxxxf4f8R9
Success! Revoked token (if it existed)
{% endcodeblock %}

The token has been revoked.

That's it folks.    
        http://gist-it.appspot.com/http://github.com/theashwanik/theashwanik/readme.md
https://github-myreadme-stats-64u7ufgl7.vercel.app/api?username=theashwanik

 <iframe frameborder=0 style="min-width: 200px; width: 60%; height: 460px;" scrolling="no" seamless="seamless" srcdoc='<html><body><style type="text/css">.gist .gist-data { height: 400px; }</style><script src="http://gist-it.appspot.com/http://github.com/theashwanik/theashwanik/readme.md"></script></body></html>'></iframe> 


## More information here by [hashicorp](https://learn.hashicorp.com/vault/getting-started/vault-intro)   
[Issue](https://github.com/hashicorp/vault/issues/6616)     

