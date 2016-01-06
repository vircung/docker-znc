# ZNC for Docker
Run the [ZNC][] IRC Bouncer in a Docker container.

## Prerequisites
1. Install [Docker][].

## Building

```
make
```

## Running

```
make run
```

Configs are stored in the docker container at `/znc-data` and on the host in `${HOME}/.znc`

The defult port is `36667`

## Configuring
If you've let the container create a default config for you, the default username/password combination is admin/admin. You can access the web-interface to create your own user by pointing your web-browser at the opened port.

I'd recommend you create your own user by cloning the admin user, then ensure your new cloned user is set to be an admin user. Once you login with your new user go ahead and delete the default admin user.

## SSL access
To enable SSL access to both HTTP and IRC, execute the following commands from within the DATADIR:

```
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes
cat cert.pem > znc.pem
cat key.pem >> znc.pem
```

Afterwards, shut down your container and start it up again.

## External Modules
If you need to use external modules, simply place the original `*.cpp` source files for the modules in your `${HOME}/.znc/modules` directory. The startup script will automatically build all .cpp files in that directory with `znc-buildmod` every time you start the container.

This ensures that you can easily add new external modules to your znc configuration without having to worry about building them. And it only slows down ZNC's startup with a few seconds.

## Notes on DATADIR
ZNC needs a data/config directory to run. Within the container it uses `/znc-data`, so to retain this data when shutting down a container, you should mount a directory from the host. Hence `-v ${HOME}/.znc:/znc-data` is part of the instructions above.

As ZNC needs to run as it's own user within the container, the directory will have it's ownership changed to UID 1000 (user) and GID 1000 (group). Meaning after the first run, you might need root access to modify the data directory from outside the container.

## Passing Custom Arguments to ZNC
As `docker run` passes all arguments after the image name to the entrypoint script, the [start-znc][] script simply passes all arguments along to ZNC.

For example, if you want to use the `--makepass` option, you would run:

```
docker run -i -t -v ${HOME}/.znc:/znc-data ${USER}/znc --makepass
```

Make note of the use of `-i` and `-t` instead of `-d`. This attaches us to the container, so we can interact with ZNC's makepass process. With `-d` it would simply run in the background.

[znc]: http://znc.in
[docker]: http://docker.io/
[start-znc]: https://github.com/jimeh/docker-znc/blob/master/start-znc
