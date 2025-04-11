# Terraform S3 Web Hosting with Cloudfront and Route53
<h1>Amaç/Aim</h1> 
<h2>TR</h2>
Bu projenin amacı, terraform kullanarak s3 ile statik bir websitesi oluşturmak. Hazır olan Route53 Domain adresini kullanarak S3 üzerinden tek tıkla bir website kurmanızı sağlamakta ve CloudFront aracılığı ile websitenize HTTPS sağlamakta. Umarım kendi websitesini yapmak isteyen herkese yardımcı olur. 
<h2>EN</h2>
The purpose of this project is to create a static website using S3 with Terraform. By utilizing an existing Route53 domain, it allows you to set up a website with a single click via S3 also grants HTTPS to website with CloudFront. I hope it will be helpful for anyone who wants to create their own website.
<h1>Ön Gereksinim/Pre-Requirements</h1>
<h2>TR</h2>
<ul>
 <li>1-Çalışma Ortamınızda Terraform Bulunması</li>
 <li>2-AWS Hesabınızın bulunması</li>
 <li>3-Route53 tarafından bir domain satın almanız</li>
 <li>2-ACM Kullanarak Route53 Domaininize (us-east-1 Regionından) SSL/TLS sertifikası almanız gerekmektedir.</li>
</ul>
<h2>EN</h2>
<ul> 
 <li>1- Terraform must be installed in your working environment.</li> 
 <li>2- You must have an AWS account.</li> 
 <li>3- You need to purchase a domain through Route53.</li> 
 <li>4- You must obtain an SSL/TLS certificate for your Route53 domain using ACM (from the us-east-1 region).</li> 
</ul>
<h1>Kullanım/Usage</h1>
<h2>TR</h2>
<ul>
<li>1-Websitenizin içeriğini website isimli dizine atınız.</li>
<li>2-Terminalinizden Terraform ve AWS CLI arasında bağlantıyı kurun</li>
</ul>

```
aws configure
```
<ul>
<li>3- **terraform.tfvars** dosyası içerisinden değişkenlerin isimlerini size uygun şekilde değiştiriniz.</li>
<li>4- Sırasıyla alttaki komutları Terminalinize yazınız</li>
</ul>

```hcl
terraform init
```
```hcl
terraform plan
```
```hcl
terraform apply
```

Websiteniz artık kullanıma hazırdır.
Bir Sorun Yaşadığınızda bana ulaşmaktan çekinmeyiniz.

 <h2>EN</h2>
 <ul>
<li>1- Place the content of your website into the directory named website.</li>
<li>2- Establish the connection between Terraform and AWS CLI via your terminal by running:</li>
</ul>

```
aws configure
```
<ul>
<li>3- Modify the variable names in the terraform.tfvars file to suit your preferences.</li>
<li>4- Enter the following commands sequentially in your terminal:</li>
</ul>

```hcl
terraform init
```
```hcl
terraform plan
```
```hcl
terraform apply
```
Your website is now ready for use.
If you encounter any issues, feel free to reach out to me.
