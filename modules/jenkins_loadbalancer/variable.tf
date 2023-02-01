variable "jenkins-lb-name" {
    default = "jenkins-lb"
}
variable "subnet_id" {
  type        = string
  default     = "subnet-76a8163a"
  description = "Subnet ID"
}
variable "securitygroup_id" {
   type = string
   default="sg-036254702898cb50c"
}
variable "lb_instance_port" {
    default = 8080
    description = "Jenkins loadbalance listen port"
}
variable "instance-lb_protocol" {
   default = "http"
   description = "Instance and lb protocol"
}
variable "lb_port" {
    default = 80
    description = "lb listening port"
}
variable "healthy_threshold" {
    default = 2
}
variable "unhealthy_threshold" {
    default = 2
}
variable "timeout" {
    default = 3
}
variable "interval" {
    default = 30
  
}
variable "idle_timeout" {
    default = 400
}
variable "connection_draining_timeout" {
    default = 400
}
variable "instance_id" {
    default = "i-0bf8a0bdb91706de2"
}

