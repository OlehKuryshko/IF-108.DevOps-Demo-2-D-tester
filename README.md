# Demo 2 d-tester
# General scheme of the project
![Demo 1](http://i.piccy.info/i9/5acf6d566adae233fd3eeffe59da3864/1599768600/127509/1392829/75389demo.jpg)
### This repository contains all the necessary information to create the infrastructure, configure servers, frontend and backend builds, as well as CI/CD project also using kubernetes and docker
__Must be installed:__
- __[terraform](https://www.terraform.io/downloads.html)__ version => 0.12.0
### To get started, you'll need to change the variables:
* key to Google account
* access key and secret key for amazon cloud
* generate your ssh key
* generate tokens from the git lab runners
### Link to frontend and backend git repositories:
* __[frontend](https://github.com/OlehKuryshko/IF-105.UI.dtapi.if.ua.io)__
* __[backend](https://github.com/OlehKuryshko/dtapi)__
### After you have changed all the variables, run the following command
```bash
terraform init
```
### After "Terraform has been successfully initialized!" please run second command
```bash
terraform apply
```
##### P.S.
You can make yourself coffee, in 10-15 minutes, everything will be ready
___
### How does it work?
>Initially, Terraform creates the entire infrastructure, namely instances, creates and configures the network, firewalls, runs a script to install ansible on the ansible instance, after successful installation ansible launches ansible playbook for further configuration of servers and configuration of the Gitlab runner and kubernetes cluster. After that, this project is fully operational. After the implementation of any committee in the interface or backend repository, the Gitlab CI CD is launched, and our project is updated automatically.