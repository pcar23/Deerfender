# The Deerfenders have struck again, view the ultimate repository for all things moose-related.

<img src="Images\the-deerfender.gif" />

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Download Diagram](Images/diagram.svg)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, additional components such as metricbeat and filebeat could be added to this playbook. For this project we used specific isolated playbooks for these modules ![See other playbooks](Scripts/)

  ```
- name: Configure Elk VM with Docker
  hosts: elk
  remote_user: sysadmin
  become: true
  tasks:
    # Use apt module
    - name: Install docker.io
      apt:
        update_cache: yes
        force_apt_get: yes
        name: docker.io
        state: present

      # Use apt module
    - name: Install python3-pip
      apt:
        force_apt_get: yes
        name: python3-pip
        state: present

      # Use pip module (It will default to pip3)
    - name: Install Docker module
      pip:
        name: docker
        state: present

      # Use command module
    - name: Increase virtual memory
      command: sysctl -w vm.max_map_count=262144

      # Use sysctl module
    - name: Use more memory
      sysctl:
        name: vm.max_map_count
        value: 262144
        state: present
        reload: yes

      # Use docker_container module
    - name: download and launch a docker elk container
      docker_container:
        name: elk
        image: sebp/elk:761
        state: started
        restart_policy: always
        # Please list the ports that ELK runs on
        published_ports:
          - 5601:5601
          - 9200:9200
          - 5044:5044

      # Use systemd module
    - name: Enable service docker on boot
      systemd:
        name: docker
        enabled: yes
  ```
<br/><br/>
This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build

<br /><br />

### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
- A load balancer is a device (physical/virtual) that efficiently distributes network traffic to a pool of backend servers, also known as a server farm or server pool based on configured logic. Load balancers provide multiple advantages; including, reduced downtime, scalability, redundancy, flexibility, and efficiency. Direct access to servers within the pool is not required which reduces the attack surface of the system.
- A Jump Box is our gateway to the azure virtual network. A docker ansible image was used to provision and accesss the web servers in the pool directly. Advantages of this include having 1 point of external access, the ability to move the docker container to other machines, another region or jump point and then reprovision as neccessary. 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the resources and system logs.
- Filebeat monitors log files or specified locations. Once the data is collected it is then forwarded to Elasticsearch for visualisation via Kibana thereafter.
- Metricbeat collects statistics and metric data from the respective operating systems periodically before it's sent to Elasticsearch to be viewed via Kibana.

The configuration details of each machine may be found below.

| Name         | Function   | IP Address | Operating System     |
|--------------|------------|------------|----------------------|
| Jump Box     | Gateway    | 10.0.0.4   | Linux (Ubuntu 18.04) |
| Web Server 1 | Web Server | 10.0.0.5   | Linux (Ubuntu 18.04) |
| Web Server 2 | Web Server | 10.0.0.6   | Linux (Ubuntu 18.04) |
| Web Server 3 | Web Server | 10.0.0.7   | Linux (Ubuntu 18.04) |
| Deerfender   | Elk Stack  | 10.1.0.4   | Linux (Ubuntu 18.04) |

<br /><br />

### Access Policies
__All public IP references have been redacted to ensure privacy of the developers__
<br /> <br />
The machines on the internal network are not exposed to the public Internet. 

The Jump Box can accept SSH connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- Use your public IP from [here](whatismyip.org)

The Load balancer can accept HTTP (tcp:80) connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- Use your public IP from [here](whatismyip.org)

Machines within the network can only be accessed via SSH from the Ansible container hosted on the Jump Box machine (10.0.0.4).
- The ELK machine is only accessible from the ansible container on the Jump Box via SSH using the the public/private keys created during initial setup.

A summary of the access policies in place can be found in the table below.

| Name         | Publicly Available     | IP Address                        |
|--------------|------------------------|-----------------------------------|
| Jump Box     | Yes (SSH ONLY - 22)    | 10.0.0.4                          |
| Web Server 1 | No                     | 40.127.75.124 - via Load Balancer |
| Web Server 2 | No                     | 40.127.75.124 - via Load Balancer |
| Web Server 3 | No                     | 40.127.75.124 - via Load Balancer |
| Deerfender   | Yes (HTTP ONLY - 5601) | XXX.XXX.XXX.XXX                   |

<br /><br />

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because of the following:
- Skill Level: Little to zero coding skills required
- Consistency: The ability to remotely configure and setup multiple instances with the exact same environment at ease by just specifying the host group.
- Flexibility: Same configurations are possible on any environment no matter where it is being deployed.
- Simple to Learn: Easy to use for beginners and professionals, being in YAML it also super easy to read and understand.
- Dependancies: No agents are required to be setup as dependancies on the remote machines
- Timeliness: Quick implementation of services and applications.

The playbook implements the following tasks:
- Install Docker and Python3 using the apt module
- Increase ELK Server's virtual memory via Systemctl
- After running Docker via pip, install the ELK image using Docker Container. __(Remember to publish relevant ports!)__
- Enabling Docker Service on boot to ensure availability.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![TODO: Update the path with the name of your screenshot of docker ps output](Images/docker-ps.png)

<br /><br />

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.0.0.5 - Web Server 1
- 10.0.0.6 - Web Server 2
- 10.0.0.7 - Web Server 3

We have installed the following Beats on these machines:
- Filebeat
  - Data Collected: 
  - Example: SSH Login Attempt
- Metricbeat
  - Data Collected:
  - Example: High CPU Usage



<br /><br />

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the _____ file to _____.
- Update the _____ file to include...
- Run the playbook, and navigate to ____ to check that the installation worked as expected.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
- _Which URL do you navigate to in order to check that the ELK server is running?

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._
