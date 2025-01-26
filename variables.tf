variable "aws_region" {
    description = "AWS Region"
    type=string 
}
variable "bucket_name"{
    description = "Bucket Name"
    type=string
}
variable "acm_certificate_arn" {
    description = "ACM certificate ARN"
}

variable "domain_name" {
    description = "Domain name for website (e.g., example.com)"
}

variable "route53_zone_id" {
    description = "Route53 hosted zone ID"
    type=string
}
variable "aws_account_id" {
  description = "Your AWS Account ID"
}