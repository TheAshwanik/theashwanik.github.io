---
layout: post
title: "Open VPN with LetsEncrypt certificate"
description: Difference between forward and reverse proxy
date_formatted: 2020-02-09 23:38
date: 2020-02-09
comments: true
categories: [Technical]
tags: OpenVpn, LetsEncrypt
keywords: OpenVpn, LetsEncrypt, OpenVPN AS Certificate, SSL Certificate
---

LetsEncrypt HTTPS Certificates for OpenVPN AS (Access Server)

So you want secure transport using ssl certificate for your openvpn Access server ( the admin GUI)
To load a new HTTPS certificate for OpenVPN AS (Access Server), you.ll want to use the ./usr/local/openvpn_as/scripts/confdba command. This can be combined with a Lets Encrypt client to obtain free a HTTPs certificate for the AS web server.

<!--more-->

#Step 1 . Installing Certbot
The first step to using LetsEncrypt to obtain an SSL certificate is to install the certbot software on your server. 

First, add the repository:
{{ codeblock }}
sudo add-apt-repository ppa:certbot/certbot ````
{{ endcodeblock }}

You'll need to press ENTER to accept. Afterwards, update the package list to pick up the new repository.s package information:
{{ codeblock }}
sudo apt-get update
{{ endcodeblock }}

And finally, install Certbot with apt-get:

{{ codeblock }}
sudo apt-get install python-certbot-nginx
{{ endcodeblock }}

The certbot LetsEncrypt client is now ready to use.

#Step 2 . Setting up Nginx - Optional Not needed for OpenVPN
Certbot can automatically configure SSL for Nginx, but it needs to be able to find the correct server block in your config. It does this by looking for a server_name directive that matches the domain you.re requesting a certificate for. If you.re starting out with a fresh Nginx install, you can update the default config file:
 
{{ codeblock }}
sudo nano /etc/nginx/sites-available/default
Find the existing server_name line:

/etc/nginx/sites-available/default
server_name localhost;
Replace localhost with your domain name:

/etc/nginx/sites-available/default
server_name example.com www.example.com;
Save the file and quit your editor. Verify the syntax of your configuration edits with:

sudo nginx -t
If that runs with no errors, reload Nginx to load the new configuration:

sudo service nginx reload
Certbot will now be able to find the correct server block and update it. Now we.ll update our firewall to allow HTTPS traffic.

{{ endcodeblock }}

#Step 3 . Obtaining an SSL Certificate
Certbot provides a variety of ways to obtain SSL certificates, through various plugins. The Nginx plugin will take care of reconfiguring Nginx and reloading the config whenever necessary:

{{ codeblock }}
sudo certbot --nginx -d example.com -d www.example.com
This runs certbot with the --nginx plugin, using -d to specify the names we.d like the certificate to be valid for.

If this is your first time running certbot, you will be prompted to enter an email address and agree to the terms of service. After doing so, certbot will communicate with the Let.s Encrypt server, then run a challenge to verify that you control the domain you.re requesting a certificate for.

If that.s successful, certbot will ask how you.d like to configure your HTTPS settings:

Output
Please choose whether or not to redirect HTTP traffic to HTTPS, removing HTTP access.
-------------------------------------------------------------------------------
1: No redirect - Make no further changes to the webserver configuration.
2: Redirect - Make all requests redirect to secure HTTPS access. Choose this for
new sites, or if you're confident your site works on HTTPS. You can undo this
change by editing your web server's configuration.
-------------------------------------------------------------------------------
Select the appropriate number [1-2] then [enter] (press 'c' to cancel):
Select your choice then hit ENTER. The configuration will be updated, and Nginx will reload to pick up the new settings. certbot will wrap up with a message telling you the process was successful and where your certificates are stored:

Output
IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at
   /etc/letsencrypt/live/example.com/fullchain.pem. Your cert will
   expire on 2017-10-23. To obtain a new or tweaked version of this
   certificate in the future, simply run certbot again with the
   "certonly" option. To non-interactively renew *all* of your
   certificates, run "certbot renew"
 - Your account credentials have been saved in your Certbot
   configuration directory at /etc/letsencrypt. You should make a
   secure backup of this folder now. This configuration directory will
   also contain certificates and private keys obtained by Certbot so
   making regular backups of this folder is ideal.
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le
Your certificates are now downloaded, installed, and configured. Try reloading your website using https:// and notice your browser.s security indicator. It should represent that the site is properly secured, usually with a green lock icon. If you test your server using the SSL Labs Server Test, it will get an A grade.

{{ endcodeblock }}

#Step 4 . Verifying Certbot Auto-Renewal
Let.s Encrypt.s certificates are only valid for ninety days. This is to encourage users to automate their certificate renewal process. The certbot package we installed takes care of this for us by running .certbot renew. twice a day via a systemd timer. On non-systemd distributions this functionality is provided by a script placed in /etc/cron.d. This task runs twice a day and will renew any certificate that.s within thirty days of expiration.

To test the renewal process, you can do a dry run with certbot:

{{ codeblock }}
sudo certbot renew --dry-run
{{ endcodeblock }}

#Commands Used

 <script src="https://gist.github.com/TheAshwanik/217872fc935431a6a1e8dd63992d9d24.js"></script>

