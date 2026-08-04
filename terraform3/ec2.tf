module "my_server_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 6.0"

  name = "tf-server-private"

  ami           = data.aws_ami.my_ami.id
  instance_type = "t3.micro"
  subnet_id     = module.my_vpc.private_subnets[0]

  user_data = templatefile("${path.module}/userdata-tunnel.sh", {
    tunnel_token = data.aws_ssm_parameter.token.value
  })

  tags = {
    Name = "tf-server-private"
  }
}