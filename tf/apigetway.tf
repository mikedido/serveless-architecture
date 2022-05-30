resource "aws_api_gateway_rest_api" "apiSacem" {
    name          = "sacem_api"
    description   = "Terraform Serverless Application Example"
}

/*resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = "${aws_api_gateway_rest_api.apiSacem.id}"
  parent_id   = "${aws_api_gateway_rest_api.apiSacem.root_resource_id}"
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxyMethod" {
  rest_api_id   = "${aws_api_gateway_rest_api.apiSacem.id}"
  resource_id   = "${aws_api_gateway_resource.proxy.id}"
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "proxy_root" {
  rest_api_id   = "${aws_api_gateway_rest_api.apiSacem.id}"
  resource_id   = "${aws_api_gateway_rest_api.apiSacem.root_resource_id}"
  http_method   = "ANY"
  authorization = "NONE"
}*/

resource "aws_api_gateway_resource" "sacem_files" {
  rest_api_id = "${aws_api_gateway_rest_api.apiSacem.id}"
  parent_id   = "${aws_api_gateway_rest_api.apiSacem.root_resource_id}"
  path_part   = "files"
}

resource "aws_api_gateway_method" "sacem_get_files" {
  rest_api_id   = "${aws_api_gateway_rest_api.apiSacem.id}"
  resource_id   = "${aws_api_gateway_resource.sacem_files.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "sacem_put_file" {
  rest_api_id   = "${aws_api_gateway_rest_api.apiSacem.id}"
  resource_id   = "${aws_api_gateway_resource.sacem_files.id}"
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda1" {
   rest_api_id = aws_api_gateway_rest_api.apiSacem.id
   resource_id = aws_api_gateway_resource.sacem_files.id
   http_method = aws_api_gateway_method.sacem_get_files.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.sacem_get_files.invoke_arn
}

resource "aws_api_gateway_integration" "lambda2" {
  rest_api_id = "${aws_api_gateway_rest_api.apiSacem.id}"
  resource_id = "${aws_api_gateway_resource.sacem_files.id}"
  http_method = "${aws_api_gateway_method.sacem_put_file.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.sacem_put_files.invoke_arn}"
}

resource "aws_api_gateway_deployment" "apideploy" {
  depends_on = [
    aws_api_gateway_integration.lambda1,
    aws_api_gateway_integration.lambda2
  ]

  rest_api_id = "${aws_api_gateway_rest_api.apiSacem.id}"
  stage_name  = "api"

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sacem_get_files.function_name
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${aws_api_gateway_rest_api.apiSacem.execution_arn}/*/*"
}


output "base_url" {
  value = aws_api_gateway_deployment.apideploy.invoke_url
}