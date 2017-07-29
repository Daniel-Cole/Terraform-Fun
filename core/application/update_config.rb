require 'ostruct'
require 'erb'

#recieve input from a basic web application
#e.g. update_config.rb -e 15 -r us-central1 -rz us-central1-a -pn terraform-app

environment = ARGV[0]

customise = OpenStruct.new()

customise.region          = "us-central1"
customise.region_zone     = "us-central1-a"
customise.project_name    = "terraform-app"
customise.dmz_subnet      = "10.0.#{environment}.0/26"
customise.app_subnet      = "10.0.#{environment}.64/26"
customise.db_subnet       = "10.0.#{environment}.128/26"
customise.factory_subnet  = "10.0.#{environment}.192/26"
allowed_ssh_ips           = ["202.92.110.10"]

terraform_tfvars = File.read('terraform.tfvars.erb')

rendered_tfvars = ERB.new(terraform_tfvars).result(customise.instance_eval { binding })

File.open('terraform.tfvars', 'w'){ |file| file.write(rendered_tfvars)}
