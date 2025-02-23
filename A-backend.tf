terraform {
    backend "s3" {
        bucket = "2.22.25-terraformbackend"
        #key = "MyLinuxBox"
        region = "us-west-2"      
}
}