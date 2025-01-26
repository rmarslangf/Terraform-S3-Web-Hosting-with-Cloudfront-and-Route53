#This module must targeting your website files/Bu modül website dosyalarınızın yerini gösterir 
module "template_files"{
    source="hashicorp/dir/template"
    base_dir = "${path.module}/website"
}
#S3 bucket creation/bucketı yaratma
resource "aws_s3_bucket" "webucket" {
    bucket= var.bucket_name
}
#S3 Bucket Acces Block Configuration / S3 Bucket'ının erişim bloğunun ayarları
resource "aws_s3_bucket_public_access_block" "webucket_public_access" {
  bucket = aws_s3_bucket.webucket.id

  block_public_acls       = true      #Blocking public acl's must be true because we are using CDN / CDN kullanıldığı için Public ACL'leri engellenmeli 
  block_public_policy     = false 
  ignore_public_acls      = true      # Same with block_public_acls / block_public_acls ile aynı durum
  restrict_public_buckets = false
}

  #S3 Bucket policy must be give a permission to CDN/ S3 Bucket poliçesi CDN'e izin vermeli.
resource "aws_s3_bucket_policy" "webucket_policy" {
    bucket = aws_s3_bucket.webucket.id
    policy = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "AllowCloudFrontAccess",
                "Effect": "Allow",
                "Principal": {
                    "Service": "cloudfront.amazonaws.com"
                },
                "Action": "s3:GetObject",
                "Resource": "arn:aws:s3:::${var.bucket_name}/*",
                "Condition": {
                    "StringEquals": {
                        "AWS:SourceArn": "arn:aws:cloudfront::${var.aws_account_id}:distribution/${aws_cloudfront_distribution.webucket_cdn.id}"
                    }
                }
            }
        ]
    })
}

#Adding the Website files / Website Dosyalarının S3 e eklenmesi
resource "aws_s3_bucket_website_configuration" "webucket_website_configuration"{
    bucket=aws_s3_bucket.webucket.id
    index_document {
      suffix="index.html"
    }
}
resource "aws_s3_object" "webucket_files" {
  bucket = aws_s3_bucket.webucket.id
  for_each = module.template_files.files
  
  key=each.key
  content_type = each.value.content_type
  source= each.value.source_path
  content=each.value.content

  etag=each.value.digests.md5

}
#CDN Creation and Configuration /CDN'i yaratma ve Yönetme kısmı
resource "aws_cloudfront_distribution" "webucket_cdn" {
  aliases             = [var.domain_name]
  default_root_object = "index.html"
  enabled             = true
  is_ipv6_enabled     = true
  wait_for_deployment = true

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    target_origin_id       = aws_s3_bucket.webucket.bucket
    viewer_protocol_policy = "redirect-to-https"                    #for take https tag / https etiketi almamız için
  }

  origin { #Our S3 #S3'ümüz
    domain_name              = aws_s3_bucket.webucket.bucket_regional_domain_name #Original S3's domain name /S3'ün kendi domain adı
    origin_access_control_id = aws_cloudfront_origin_access_control.webucket_ac.id #CDN ID is attaching to OAC / CDN'in ID'si OAC'ye atanmalı 
    origin_id                = aws_s3_bucket.webucket.bucket #Bucket id /Bucket'ın id'si
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }
}
#Origin Must be targeting S3 Bucket / Origin S3 bucketını hedefliyor olmalı
resource "aws_cloudfront_origin_access_control" "webucket_ac" {
  name                              = "s3-cloudfront-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}


# Route 53 Record for CDN / CDN için Route 53 kayıdı
resource "aws_route53_record" "cdn_alias" {
    zone_id = var.route53_zone_id
    name    = var.domain_name
    type    = "A"

    alias {
        name                   = aws_cloudfront_distribution.webucket_cdn.domain_name
        zone_id                = aws_cloudfront_distribution.webucket_cdn.hosted_zone_id
        evaluate_target_health = false
    }
}

