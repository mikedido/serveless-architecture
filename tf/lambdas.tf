resource "aws_lambda_function" "sacem_get_files" {
    function_name    = "sacem_get_files"

    s3_bucket        = aws_s3_bucket.lambda_buckets.id
    s3_key           = aws_s3_object.sacem_get_files.key

    runtime          = "python3.8"
    handler          = "main.lambda_handler"
    timeout          = 10

    source_code_hash = data.archive_file.lambda_sacem_get_files_package.output_base64sha256

    role             = aws_iam_role.lambda_role.arn
}


resource "aws_lambda_function" "sacem_put_files" {
    function_name    = "sacem_put_files"

    s3_bucket        = aws_s3_bucket.lambda_buckets.id
    s3_key           = aws_s3_object.sacem_put_files.key

    runtime          = "python3.8"
    handler          = "main.lambda_handler"
    timeout          = 10

    source_code_hash = data.archive_file.lambda_sacem_put_files_package.output_base64sha256

    role             = aws_iam_role.lambda_role.arn
}