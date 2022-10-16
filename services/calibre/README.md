## setup

This image sets up the calibre desktop app and makes its interface available via Guacamole server in the browser. The interface is available at http://your-ip:8082.

By default, there is no password set for the main gui. Optional environment variable PASSWORD will allow setting a password for the user abc.

Port 8081 is reserved for Calibre's built-in webserver, which can be enabled within the desktop app settings, and the internal port must be set to 8081 although it will then be available at the host mapped port for external access.

You can access advanced features of the Guacamole remote desktop using ctrl+alt+shift enabling you to use remote copy/paste and different languages.

start calibre`s own web client:
goto: http://your-ip:8082 -> Connect/share -> start content server

enable uploads via calibre-web:
goto: admin -> edit basic configuration -> feature configuration -> enable uploads

enable reading inside browser:
goto: admin -> edit users -> edit user -> Allow eBook Viewer

## docker image

https://hub.docker.com/r/linuxserver/calibre