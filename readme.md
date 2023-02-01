### Dockerized [Callattendant](https://github.com/emxsys/callattendant)
The original project by [emxsys](https://github.com/emxsys) [https://github.com/emxsys/callattendant](https://github.com/emxsys/callattendant) is intended to run on the Raspberry Pi. This uses my fork of the project with gpiozero, RPi.GPIO and RPIO dependency removed.

Usage:
```bash
git clone git@github.com:foureight84/callattendant-docker.git callattendant

cd callattendant

Docker build -t callattendant:1.1.2-no-gpio .
```

The build process generates a non-root container. The running user is `ca` with the default data-path of `/home/ca/.callattendant`. I've included a basic config file. You can always replace that with your own or generate a sample with the `--create-folder` flag.

**Note** that this is currently using the latest master branch with an internal version of 1.1.1 and there are changes to the configuration file from the project's official 1.1.0 release.

Make sure to update the `docker-compose.yaml` with the correct device path for your modem as shown below before running `docker compose`.

```yaml
    devices:
      - /dev/ttyACM0:/dev/ttyACM0
```
