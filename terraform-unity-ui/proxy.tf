resource "aws_ssm_parameter" "uiux_dashboard_proxy_config" {
  depends_on = [ aws_lb.main ]
  name       = "/unity/${var.project}/${var.venue}/cs/management/proxy/configurations/010-uiux-dashboard"
  type       = "String"
  value      = <<-EOT

    <location /dashboard>
      ProxyHTMLEnable on
      RequestHeader unset Accept-Encoding
      ProxyHTMLCHarsetOut *
      ProxyHTMLExtended On

      Header always set Strict-Transport-Security "max-age=63072000"
      ProxyPass http://${aws_lb.main.dns_name}:8080/
      ProxyPassReverse http://${aws_lb.main.dns_name}:8080/
      ProxyHTMLURLMap / /unity/dev/dashboard/
    </location>

EOT
}

resource "aws_lambda_invocation" "proxy_lambda_invocation" {
  depends_on = [ aws_lb.main, aws_ssm_parameter.uiux_dashboard_proxy_config ]
  function_name = "${var.project}-${var.venue}-httpdproxymanagement"
  input = ""
  triggers = {
    redeployment = sha1(jsonencode([
      aws_ssm_parameter.uiux_dashboard_proxy_config
    ]))
  }
}