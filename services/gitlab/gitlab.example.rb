external_url 'https://gitlab.example.com'
gitlab_rails['lfs_enabled'] = true
gitlab_rails['gitlab_shell_ssh_port'] = 2222
nginx['listen_port'] = 80
nginx['listen_https'] = false
nginx['proxy_set_headers'] = {
 "Host" => "$http_host_with_default",
 "X-Real-IP" => "$remote_addr",
 "X-Forwarded-For" => "$proxy_add_x_forwarded_for",
 "X-Forwarded-Proto" => "https",
 "X-Forwarded-Ssl" => "on",
}
nginx['http2_enabled'] = false

pages_external_url "http://gitlab-pages.example.com"
gitlab_pages['enable'] = true
gitlab_pages['external_http'] = ['0.0.0.0:8081']
gitlab_pages['inplace_chroot'] = true
gitlab_pages['internal_gitlab_server'] = 'https://gitlab.example.com'
pages_nginx['enable'] = false
gitlab_pages['access_control'] = true

gitlab_rails['registry_enabled'] = true
registry_external_url 'https://gitlab-registry.example.com'
registry['enable'] = true
registry_nginx['enable'] = true
registry_nginx['proxy_set_headers'] = {
 "Host" => "$http_host",
 "X-Real-IP" => "$remote_addr",
 "X-Forwarded-For" => "$proxy_add_x_forwarded_for",
 "X-Forwarded-Proto" => "https",
 "X-Forwarded-Ssl" => "on"
}
registry_nginx['listen_port'] = 5050
registry_nginx['listen_https'] = false

# https://docs.gitlab.com/omnibus/settings/smtp.html#example-configurations
# Notify.test_email('test@example.com', 'Message Subject', 'Message Body').deliver_now
gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "smtp.strato.de"
gitlab_rails['smtp_port'] = 465
gitlab_rails['smtp_user_name'] = "test@example.com"
gitlab_rails['smtp_password'] = "password"
gitlab_rails['smtp_domain'] = "example.com"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = false
gitlab_rails['smtp_tls'] = true
gitlab_rails['smtp_openssl_verify_mode'] = 'none'
gitlab_rails['gitlab_email_from'] = 'gitlab@example.com'
gitlab_rails['gitlab_email_reply_to'] = 'gitlab@example.com'
