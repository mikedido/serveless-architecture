resource "aws_s3_bucket" "sacem_files" {
   bucket = "sacem-bucket"
   
   force_destroy = true
}