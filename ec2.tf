# --- EC2 INSTANCES ---
resource "aws_instance" "EC2Instance" {
  ami                   = "ami-0b5358cc8c5df0b02"
  instance_type         = "t3.small"
  subnet_id             = aws_subnet.EC2Subnet.id
  vpc_security_group_ids = [aws_security_group.EC2SecurityGroup.id]
  iam_instance_profile  = aws_iam_instance_profile.IAMInstanceProfile2.name

  root_block_device {
    volume_size           = 30
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "t3-small-vm"
  }
}

# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_instance" "manual_vm" {
  ami                                  = "ami-02b64aa047cb5edf5"
  associate_public_ip_address          = false
  availability_zone                    = "us-east-1d"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = true
  enable_primary_ipv6                  = null
  get_password_data                    = false
  hibernation                          = false
  host_id                              = null
  host_resource_group_arn              = null
  iam_instance_profile                 = "instanceRole"
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3.small"
  ipv6_addresses                       = []
  key_name                             = "linux"
  monitoring                           = false
  placement_group                      = null
  placement_partition_number           = 0
  private_ip                           = "172.31.39.196"
  secondary_private_ips                = []
  security_groups                      = ["launch-wizard-2"]
  source_dest_check                    = true
  subnet_id                            = "subnet-09d92e113bf0ce55d"
  tags = {
    Name = "LInux_bastion"
  }
  tags_all = {
    Name = "LInux_bastion"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_base64            = null
  user_data_replace_on_change = null
  volume_tags                 = null
  vpc_security_group_ids      = ["sg-0a32092ae904a3c28"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    amd_sev_snp      = null
    core_count       = 1
    threads_per_core = 1
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 2
    http_tokens                 = "required"
    instance_metadata_tags      = "disabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 3000
    kms_key_id            = null
    tags                  = {}
    tags_all              = {}
    throughput            = 125
    volume_size           = 20
    volume_type           = "gp3"
  }
}
resource "tls_private_key" "ec2_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.ec2_ssh_key.private_key_pem
  filename        = "./terraform-ec2-keypair.pem"
  file_permission = "0400"
}