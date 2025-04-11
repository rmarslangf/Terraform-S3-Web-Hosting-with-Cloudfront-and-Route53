# Terraform S3 Web Hosting with Cloudfront and Route53 🌐🚀

## Amaç/Aim 🎯

### TR
Bu projenin amacı, Terraform kullanarak S3 ile statik bir websitesi oluşturmak. Hazır olan Route53 Domain adresini kullanarak S3 üzerinden tek tıkla bir website kurmanızı sağlamakta ve CloudFront aracılığı ile websitenize HTTPS sağlamakta. Umarım kendi websitesini yapmak isteyen herkese yardımcı olur. 🌍💻

### EN
The purpose of this project is to create a static website using S3 with Terraform. By utilizing an existing Route53 domain, it allows you to set up a website with a single click via S3 and also grants HTTPS to the website with CloudFront. I hope it will be helpful for anyone who wants to create their own website. 🌍💻

## Ön Gereksinim/Pre-Requirements 📝

### TR
- 1️⃣ Çalışma Ortamınızda Terraform Bulunması
- 2️⃣ AWS Hesabınızın bulunması
- 3️⃣ Route53 tarafından bir domain satın almanız
- 4️⃣ ACM Kullanarak Route53 Domaininize (us-east-1 Regionından) SSL/TLS sertifikası almanız gerekmektedir. 🔒

### EN
- 1️⃣ Terraform must be installed in your working environment.
- 2️⃣ You must have an AWS account.
- 3️⃣ You need to purchase a domain through Route53.
- 4️⃣ You must obtain an SSL/TLS certificate for your Route53 domain using ACM (from the us-east-1 region). 🔒

## Kullanım/Usage ⚙️

### TR

1. Websitenizin içeriğini `website` isimli dizine atınız. 📂
2. Terminalinizden Terraform ve AWS CLI arasında bağlantıyı kurun:

    ```bash
    aws configure
    ```

3. **terraform.tfvars** dosyasındaki değişkenleri size uygun şekilde düzenleyin. ✏️
4. Aşağıdaki komutları sırayla terminalinize yazınız:

    ```bash
    terraform init
    ```

    ```bash
    terraform plan
    ```

    ```bash
    terraform apply
    ```

Websiteniz artık kullanıma hazırdır. 🎉 Bir sorun yaşadığınızda bana ulaşmaktan çekinmeyiniz. 📩

### EN

1. Place the content of your website into the directory named `website`. 📂
2. Establish the connection between Terraform and AWS CLI via your terminal by running:

    ```bash
    aws configure
    ```

3. Modify the variable names in the `terraform.tfvars` file to suit your preferences. ✏️
4. Enter the following commands sequentially in your terminal:

    ```bash
    terraform init
    ```

    ```bash
    terraform plan
    ```

    ```bash
    terraform apply
    ```

Your website is now ready for use. 🎉 If you encounter any issues, feel free to reach out to me. 📩
