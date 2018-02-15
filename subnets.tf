resource "aws_subnet" "TFPublicAZA" {
  vpc_id = "${aws_vpc.terraformmain.id}"
  cidr_block = "${var.Subnet-Public-AzA-CIDR}"
  tags {
        Name = "TF PublicAZA"
  }
 availability_zone = "${data.aws_availability_zones.available.names[0]}"
}
resource "aws_route_table_association" "TFPublicAZA" {
    subnet_id = "${aws_subnet.TFPublicAZA.id}"
    route_table_id = "${aws_route_table.public.id}"
}
