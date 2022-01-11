# Deploying vRealize Automation 8 with Easy Installer
vRealize Automation is a modern infrastructure automation platform that enables private and multi-cloud environments on VMware Cloud infrastructure. It delivers self-service automation, DevOps for infrastructure, configuration management and network automation capabilities that help you increase business and IT agility, productivity, and efficiency.
Integrate, streamline, and modernize traditional, cloud-native, and multi-cloud infrastructures with vRealize Automation and simplify IT while preparing for the future of your business.

The process of deploying vRealize Automation has been totally revised with vRealize Automation 8. The biggest change is that Installation is done via the VMware Lifecycle Manager

### Prerequisites
You must meet these prerequisites before you can install vRealize Suite Lifecycle Manager:

- Ensure you have a vCenter Server set up and access to the credentials.
- Ensure you have the network configuration details for vRealize Automation
- Ensure you know the Lifecycle VA deployment details

### Installation 

Please make sure, to have DNS names (also reverse lookup) for those components created beforehands.

Like always, the installation process begins with downloading the necessary software from the VMware download sections.

The appliances inside the source file:
* VRealize Life Cycle Manager.
* VRealize Identity Manager.
* VRealize Automation.

**VRealize Life Cycle Manager.**
This appliance is responsible for deploying the other appliances and responsible for the patches deployments and adding any additional components like (VROPS, LOG Insight, Network Insight).

**VRealize Identity Manager.**
This Appliance responsible for the user identity and to unify the login for all the VMware systems.

**VRealize Automation.**
This Appliance is the main solution which provide the self-service portal with the automation and management as mentioned in previous post and it includes the orchestrator embedded and we can split it and install it separately.


vRealize Automation provides an installation tool – the Easy Installer. The Easy Installer will deploy the Lifecycle Manager first, upload the Identity Manager and vRealize Automation appliance OVAs to the Lifecycle Manager and finally deploys and configures the latter component.

After having downloaded the Easy Installer as an ISO-file, please mount it.

In the following we will show the process for Windows, but the Easy Installer can also be triggered from MacOS or Linux.
Then launch the installer application. The installation wizard will load.

![](images/vRa/01.png)

Here you have the chance to choose if install a new vRealize Automation o migrate an alredy existing site
Click on Install 

![](images/vRa/02.png)

On the Introduction page, click on Next.

![](images/vRa/03.png)

On the End User License Agreement page, accept the terms of the license agreement and click on Next.

![](images/vRa/04.png)

In the next step, we need to establish a connection to vSphere. Provide the following settings and click Next:

* vCenter Server Hostname (or IP)
* HTTPS Port
* Username
* Password

![](images/vRa/05.png)

If you have an untrusted SSL certificate, click on Accept.

![](images/vRa/06.png)

On the following page, choose a location (data center or VM folder) and click Next.

![](images/vRa/07.png)

Now we have to select a Cluster in which we will allocate the Compute Resource.

![](images/vRa/08.png)

Of course, selecting a Storage Location is needed as well. Most likely you also want to enable Thin Disk Mode.

![](images/vRa/09.png)

Next step is to provide the Network Configuration. Provide the following information and click on Next.

* Network
* IP Assignment
* Subnet Mask
* Default Gateway
* DNS Servers
* Domain Name
* NTP Server (optionally)


![](images/vRa/10.png)

Now, provide a admin/root password for the vRealize Automation components:

![](images/vRa/11.png)

Next, continue with the Lifecycle Mananger Configuration. We need the following information:

* Virtual machine name
* IP address
* Hostname

![](images/vRa/12.png)

The next step is about configuring the Identity Appliance. Provide the following settings:

* Virtual Machine Name
* IP Address
* Hostname
* Default Configuration Admin

If you want not only groups from AD, but also members to be synced, active the “Sync Group Members to the Directory When Adding Group” checkbox.

Click Next.

![](images/vRa/13.png)


Now, we provide the necessary information for the Automation appliance:

* Provide the license key
* Virtual machine name
* IP Address
* Hostname

![](images/vRa/14.png)

The last screen summarizes the settings. Please review everything and let the installation start by clicking on submit.


![](images/vRa/15.png)

Now for the last step you will see a Progressiion bar that will let you know about the progress of the installation.
The first part of the installation will take 1-2 hours.

![](images/vRa/16.png)

Now you can Login to the VRA portal. And when you will login you will be redirected to the VIDM to enter the credentials and will redirect you again to the VRA automatically.

![](images/vRa/17.png)