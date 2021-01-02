## Run it

ansible-playbook playbook.yml --vault-password-file vault_pass

## Homework aliases

* Create a inventory file with four groups, each provisioning VM should be in separate group and group named `iaas` what should include childrens from two first groups;
    [hosts.yml](https://github.com/iamnotaskynet/glbasecamp_devops/blob/main/01_ANSIBLE_HW/hosts.yml)
* Create reusable roles for that:
- creating a empty file `/etc/iaac` with rigths `0500`, this role should be idempodent
    [01_iaac](https://github.com/iamnotaskynet/glbasecamp_devops/blob/main/01_ANSIBLE_HW/roles/01_iaac/tasks/main.yml)
- define content of `/etc/issue` as variable
    [02_issue](https://github.com/iamnotaskynet/glbasecamp_devops/blob/main/01_ANSIBLE_HW/roles/02_issue/tasks/main.yml)
* Create playbook for: [playbook.yml](https://github.com/iamnotaskynet/glbasecamp_devops/blob/main/01_ANSIBLE_HW/playbook.yml)
- invoke the role for `/etc/iaac` for hosts group `iaas`
- invoke the role for defining variable for all hosts
- print in registered variables
- printing hostnames together with registered variables will be a plus.
* Create a repo in your GitHub account and commit code above
    [repo](https://github.com/iamnotaskynet/glbasecamp_devops/tree/main/01_ANSIBLE_HW)

Optional:
- use `ansible_user` and `ansible_password` for ssh connection and store passwords for each VM in encrypred way (add vault password to README.md in this case)
    [host_vars (ip, user, sudo password)](https://github.com/iamnotaskynet/glbasecamp_devops/tree/main/01_ANSIBLE_HW/host_vars) encrypted with [password](https://github.com/iamnotaskynet/glbasecamp_devops/blob/main/01_ANSIBLE_HW/vault_pass)
