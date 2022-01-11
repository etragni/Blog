# vSphere with Tanzu

You can use vSphere with Tanzu to transform vSphere to a platform for running Kubernetes workloads natively on the hypervisor layer. When enabled on a vSphere cluster, vSphere with Tanzu provides the capability to run Kubernetes workloads directly on ESXi hosts and to create upstream Kubernetes clusters within dedicated resource pools

![image](images/tanzu/i1.png)

The different roles do not have visibility or control over each other's environments:
* As an application developer, you can run Kubernetes pods, and deploy and manage Kubernetes based applications. You do not have visibility over the entire stack that is running hundreds of applications.


* As a DevOps engineer, you only have control over the Kubernetes infrastructure, without the tools to manage or monitor the virtual environment and resolve any resource-related and other problems.

* As a vSphere administrator, you have full control over the underlying virtual environment, but you do not have visibility over the Kubernetes infrastructure, the placement of the different Kubernetes objects in the virtual environment, and how they consume resources.

Operations on the full stack can be challenging, because they require communication between all three roles. The lack of integration between the different layers of the stack can also introduce challenges. For example, the Kubernetes scheduler does not have visibility over the vCenter Server inventory and it cannot place pods intelligently.


Having a Kubernetes control plane on the hypervisor layer enables the following capabilities in vSphere:
* As a vSphere administrator, you can create namespaces on the Supervisor Cluster, called vSphere Namespaces, and configure them with specified amount of memory, CPU, and storage. You providevSphere Namespaces to DevOps engineers.

* As a DevOps engineer, you can run workloads consisting of Kubernetes containers on the same platform with shared resource pools within avSphere Namespace. In vSphere with Tanzu, containers run inside a special type of VM called vSphere Pod. You can also deploy regular VMs.

* As a DevOps engineer, you can create and manage multiple Kubernetes clusters inside a namespace and manage their lifecycle by using the Tanzu Kubernetes Grid Service.
Kubernetes clusters created by using the Tanzu Kubernetes Grid Service are called Tanzu Kubernetes clusters.

* As a vSphere administrator, you can manage and monitor vSphere Pods, VMs, and Tanzu Kubernetes clusters by using the vSphere Client.

* As a vSphere administrator, you have full visibility over vSphere Pods, VMs, and Tanzu Kubernetes clusters running within different namespaces, their placement in the environment, and how they consume resources.
Having Kubernetes running on the hypervisor layer also eases the collaboration between vSphere administrators and DevOps teams, because both roles are working with the same objects.

### Create and Configure a vSphere Cluster
A vSphere cluster is a collection of ESXi hosts managed by a vCenter Server system. The
Supervisor Cluster runs on a vSphere cluster. Create a vSphere cluster that meets the following
requirements so that you can enable Workload Management on it:
*  Create and configure a vSphere cluster with at least three host. If you are using vSAN you need a minimum of four ESXi hosts. See Creating and Configuring Clusters.
* Configure the cluster with shared storage such as vSAN. Shared storage is required for vSphere HA, DRS, and for storing persistent container volumes. See Creating a vSAN Cluster.
*  Enable the cluster with vSphere HA. See Creating and Using vSphere HA Clusters.
*  Enable the cluster with vSphere DRS in fully-automated mode. See Creating a DRS Cluster.
*  Verify that your user account has the Modify cluster-wide configuration on the vSphere

cluster so that you can enable the Workload Management functionality.

To enable Workload Management on a vSphere cluster, you must configure the networking stack to be used for the Supervisor Cluster. You have two options: NSX-T Data Center or vSphere Distributed Switch (vDS) networking with a load balancer. You can configure the NSX Advanced Load Balancer or the HAProxy load balancer


### Create a Content Library
To provision Tanzu Kubernetes clusters and VMs, you need a Content Library created in the vCenter Server that manages the vSphere cluster where the Supervisor Cluster runs.
The Content Library provides the system with the distributions of Tanzu Kubernetes releases in the form of OVA templates. When you provision a Tanzu Kubernetes cluster, the OVA template for the selected version is used to create the Kubernetes cluster nodes.

![image](images/tanzu/c1.png)

You can create a Subscribed Content Library to automatically pull the latest released images, or you can create a Local Content Library and manually upload the images, which may be required for air-gapped provisioning of Tanzu Kubernetes clusters.
to create a Subscribed Content Library enter the Subscription URL address of the publisher: https://wpcontent.vmware.com/v2/latest/lib.json


![image](images/tanzu/c2.png)


### Create Storage Policies for vSphere with Tanzu
Before you enable vSphere with Tanzu, create storage policies to be used in the Supervisor Cluster and namespaces. The policies represent datastores available in the vSphere environment. They control the storage placement of such objects as control plane VMs, pod ephemeral disks, container images, and persistent storage volumes. If you use Tanzu Kubernetes clusters, the storage policies also dictate how the Tanzu Kubernetes cluster nodes are deployed.
Depending on your vSphere storage environment and the needs of DevOps, you can create several storage policies to represent different classes of storage. For example, if your vSphere storage environment has three classes of datastores, Bronze, Silver, and Gold, you can create storage policies for all datastores. You can then use the Bronze datastore for ephemeral and container image virtual disks, and use the Silver and Gold datastores for persistent volume virtual
disks.

In the vSphere Client, open the Create VM Storage Policy wizard.
- a Click Menu > Policies and Profiles

![image](images/tanzu/s0.png)

Under Policies and Profiles, click **VM Storage Policies.**
Click Create VM Storage Policy.
Enter the policy name and description.

![image](images/tanzu/s1.png)

On the **Policy structure** page under Datastore specific rules, enable tag-based placement rules

![image](images/tanzu/s2.png)

On the **Tag based** placement page, create the tag rules

![image](images/tanzu/s3.png)

On the **Storage compatibility** page, review the list of datastores that match this policy.

![image](images/tanzu/s4.png)

On the **Review and finish** page, review the storage policy settings and click Finish

![image](images/tanzu/s5.png)

### Enable Workload Management

As a vSphere administrator, you can enable the Workload Management platform on a vSphere cluster by configuring the vSphere networking stack to provide connectivity to workloads. A Supervisor Cluster that is configured with vSphere networking supports the deployment of Tanzu Kubernetes clusters created by using the Tanzu Kubernetes Grid Service. It does not support running vSphere Pod or using the embedded Harbor Registry

From the home menu, select Workload Management.

![image](images/tanzu/w1.png)

On the **Workload Management** screen, click Get Started again.

![image](images/tanzu/w2.png)

Select a vCenter Server system
select NSX-T , and click Next.

![image](images/tanzu/w3.png)

Select a cluster from the list of compatible clusters

![image](images/tanzu/w4.png)

From the **Control Plane** Size page, select the size for the Kubernetes control plane VMs that will be created on each host from the cluster.
The amount of resources that you allocate to control plane VMs determines the number of Kubernetes workloads that the Supervisor Cluster can manage.

![image](images/tanzu/w5.png)

In the **Storage settings**, configure storage for the Supervisor Cluster.
The storage policy you select for each of the following objects ensures that the object is placed on the datastore referenced in the storage policy. You can use the same or different storage policies for the objects.

![image](images/tanzu/w6.png)

On the **Management Network** screen, configure the parameters for the network that will be used for Kubernetes control plane VMs
* Network
* Starting Control IP address
* Gateway
* Subnet Mask
* DNS Servers
* DNS Search Domains
* NTP

![image](images/tanzu/w7.png)

In the **Workload Network** page, enter the settings for the network that will handle the networking traffic for Kubernetes workloads running on the Supervisor Cluster.
* vSphere Distributed Switch 
* Edge Cluster 
* API Server Endpoint FQDN
* DNS Server
* Pod CIDRs 
* Services CIDRs 
* Ingress CIDRs
* Egress CIDRs

![image](images/tanzu/w8.png)

In the **TKG Configuration** click add to select the Content library previously created.

![image](images/tanzu/w9.png)

Select the Subscribed content Library

![image](images/tanzu/w10.png)
In the **Ready to Complete** section, review the settings and Finish

![image](images/tanzu/w11.png)

If you mode in the **Host and Cluster** page you can clearly see the new control plane and resource pool created

![image](images/tanzu/result.png)
