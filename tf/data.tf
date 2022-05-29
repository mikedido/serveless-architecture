data "archive_file" "lambda_sacem_get_files_package" {
    type= "zip"

    source_dir  = "${path.module}/../src/lambda_get_files"
    output_path = "${path.module}/../src/lambda_get_files.zip"
}

data "archive_file" "lambda_sacem_put_files_package" {
    type= "zip"

    source_dir = "${path.module}/../src/lambda_put_file"
    output_path = "${path.module}/../src/lambda_put_file.zip"
}

resource "random_pet" "lambda_bucket_name" {
  prefix = "learn-terraform-functions"
  length = 4
}

resource "aws_s3_bucket" "lambda_buckets" {
  bucket = random_pet.lambda_bucket_name.id

  acl           = "private"
  force_destroy = true
}

resource "aws_s3_object" "sacem_get_files" {
    bucket = aws_s3_bucket.lambda_buckets.id

    key = "get_files.zip"
    source = data.archive_file.lambda_sacem_get_files_package.output_path

    etag = filemd5(data.archive_file.lambda_sacem_get_files_package.output_path)
}

resource "aws_s3_object" "sacem_put_files" {
    bucket = aws_s3_bucket.lambda_buckets.id

    key = "put_files.zip"
    source = data.archive_file.lambda_sacem_put_files_package.output_path

    etag = filemd5(data.archive_file.lambda_sacem_put_files_package.output_path)
}