
provider "aws" {
	region = "us-west-1"
}
/*
resource "aws_key_pair" "auth" {
 key_name = "${var.key_name}"
 public_key = "${file(var.public_key_path)}"
}
*/
locals {
  # The default username for our AMI
  vm_user = "centos"
}

output "public_ip" {
  value = ["${aws_instance.nginx_nodejs.*.public_ip}"]
}

output "id_list" {
  value = ["${aws_instance.nginx_nodejs.*.id}"]
}

resource "aws_instance" "nginx_nodejs" {
  ami           = "${lookup(var.AmiLinux, var.region)}"
  instance_type = "t2.micro"

  count = "${var.number_of_instances}"

  associate_public_ip_address = "true"
  subnet_id = "${aws_subnet.TFPublicAZA.id}"
  vpc_security_group_ids = ["${aws_security_group.FrontEnd.id}"]
  key_name = "${var.key_name}"
  tags {
    Name = "TF_nginx_nodejs-${count.index}"
  }
   
}

resource "local_file" "inventory-meta" {
  filename = "aws_hosts"

  content = <<-EOF
[web]
${join("\n",aws_instance.nginx_nodejs.*.public_ip)}

[private]
${join("\n",aws_instance.nginx_nodejs.*.private_ip)}
  EOF
}


# Run Ansible
resource "null_resource" "Ansible" {
#  depends_on = ["aws_instance.nginx_nodejs", "null_resource.Add_Public_IP1", "null_resource.Add_Public_IP2"]
  depends_on = ["aws_instance.nginx_nodejs"]

   provisioner "local-exec" {
       command = "sleep 6m && ansible-playbook -vvvv -i aws_hosts  ansible/playbook-nodejs.py"
   }
}


