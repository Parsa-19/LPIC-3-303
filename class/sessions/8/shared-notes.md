server_tokens       off;

curl -I http://127.0.0.1

        client_body_buffer_size 2k;
        client_max_body_size 4k;
        client_header_buffer_size 2k;
        large_client_header_buffers 2 2k;
        
    client_body_timeout 30s;
  client_header_timeout 30s;
 keepalive_timeout   45;

http{
    limit_conn_zone  $binary_remote_addr  zone=one:10m;
    
    
    server{
     limit_conn one 30;   

        location / {
        limit_except GET POST HEAD {
                deny all;
        }
        }


        location / {
        if ($http_user_agent ~* (WgeT|AcunEtix|nmap|CurL|nessUs) ) {
        return 444;
        }
        }

curl  --user-agent "mamad" -I http://127.0.0.1


add_header Content-Security-Policy "script-src 'self';" always;


/usr/share/nginx/html/
b.html
<html>
        <body>
        salam
        <script src="code.css"></script>
        </body>
</html>



code.css
console.log("Hello World!");
firefox-> f12 -> console


add_header X-Content-Type-Options  nosniff;
systemctl restart nginx

add_header X-XSS-Protection "1; mode=block";

bash -c "$(curl -fsSLk https://waf.chaitin.com/release/latest/setup.sh)"

