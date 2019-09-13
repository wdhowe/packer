# Packer

Packer image builds

## Directories

- provision -> Scripts/Playbooks used in packer image provisioners

## Files

- packer_gitlabrunner_local.json -> Build an Amazon Linux 2 EC2 AMI, using an Ansible playbook in local mode.
- packer_gitlabrunner_remote.json -> Build an Amazon Linux 2 EC2 AMI, using an Ansible playbook in remote mode.

----

## Packer Examples

### Check Packer Syntax

```bash
packer validate packer_gitlabrunner_remote.json
```

### Info About Packer File

Show information about a packer file, such as the variables, builders, provisioners, etc.

```bash
packer inspect packer_gitlabrunner_remote.json
```

### Build with all default variables

```bash
packer build packer_gitlabrunner_remote.json
```

### Build with variable overrides on the command line

```bash
packer build -var 'aws_subnet_id=subnet-123456789' -var 'aws_security_group_id=sg-123456789' packer_gitlabrunner_remote.json
```

### Build with variable override file

```bash
packer build -var-file=my_vars.json packer_gitlabrunner_remote.json
```

File: my_vars.json

```json
{
    "aws_subnet_id": "subnet-123456789",
    "aws_security_group_id": "sg-123456789"
}
```
