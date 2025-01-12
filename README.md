## About
This project gives a way to run [Throttle](https://github.com/asherkin/throttle) locally on almost every platform without efforts. 

It allows to load application within [Docker](https://www.docker.com/) locally and makes it visible globally within [Ngrok](https://ngrok.com/).

## How to use
- Install Docker Engine and Compose plugin for your host machine. You can just install the newest version of [Docker Desktop](https://docs.docker.com/desktop/), it includes both of them. After installing, run it
- Clone this repository or download sources
- [Register Ngrok account](https://dashboard.ngrok.com/signup) and [receive auth token](https://dashboard.ngrok.com/get-started/your-authtoken) from Dashboard > Get Started > Your Authtoken menu.
- Open file `docker/ngrok/ngrok.yml` and write received token to `agent.authtoken` field's value (just replace `your_token` with your own)
- Open Terminal and run command `docker compose up -d`. Wait few minutes when both dependencies will be installed.
- Open in the browser url `http://localhost:8001` and make sure you are seeing the main page of Throttle.
- Go to Ngrok's [Endpoints](https://dashboard.ngrok.com/endpoints) page. You will see some unique address like `***.ngrok-free.app`, click on it to open endpoint's details page and then, copy your unique address.
- Open in the browser copied address and make sure it proxies to your locally launched app at `http://localhost:8001`
- Use copied address on your gameserver. Open file `addons/sourcemod/configs/core.cfg` and change variable values by replacing hostname with your Ngrok address:
  - `MinidumpUrl` should look like `http://***.ngrok-free.app/submit`
  - `MinidumpSymbolUrl` should look like `http://***.ngrok-free.app/symbols/submit`
  - `MinidumpBinaryUrl` should look like `http://***.ngrok-free.app/binary/submit`
- After server crash it will send information to your application. You can monitor traffic on the Ngrok's Inspect Traffic page (button is located on the right upper corner of endpoint's details page)

## Troubleshooting
- Check container logs `docker compose logs <container>`
- Check application logs `docker exec -it throttle bash` and open file `/var/www/throttle/logs/main.log`

## Credits
- [asherkin](https://github.com/asherkin/)
