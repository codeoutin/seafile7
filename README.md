# Seafile 7 Docker Image (works with Synlogy)
Docker Image to create a container with Seafile 7, Memcached, MariaDB & NGINX in a single container. Works with Synlogy Docker.
You can also download the image from [Docker Hub](https://hub.docker.com/r/stegerpa/seafile7)

## Run
To run the container you could use 
`docker run -p 80:80 --name sf7 -i -t stegerpa/seafile7`

## Synology Setup
* Open Docker, go to Tab "Image", Add, Add from URL and enter on URL: `stegerpa/seafile7`
* Select the image, Launch and choose a Container-Name (for example "Seafile7")
* Click Advanced Settings

Recommended Settings:
* Advanced Settings: Enable auto-restart
* Volume: Mount Folder > docker/seafile7 (create if needed) to `/shared` | don't check "Read-Only"
* Port Settings: Local Port `8000` (or any port you like) to Container port `80`
* Apply > Next > Apply

To access Seafile from the web you have to configure your firewall and open the port you chose to map.

## Admin Account
The setup routine creates an admin account for you and saves the credentials in the file /shared/logs/setup.log
If you went with the Synology Setup you can also view this file by opening File Station > [your mounted path] > logs > setup.log
