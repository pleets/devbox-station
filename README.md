# PHP Web Dockerfiles

This project allows you to run a PHP web environment to execute your web projects by avoiding installing
any software package on your machine other than `docker`  and `docker-compose`.

## 1. Requirements

You need the following software to run this project.

- Docker v23+
- Docker compose v1.29+

We don't ensure compatibility for docker / docker-compose versions lower than the described above. However, it's probable
that this project runs on lower versions. We have not tested it yet, but you could do it.

## :gear: 2. Configuration

Configuration is one of the most important things when you're setting up your projects. You can set up several
components and customize this project as your desire. The minimum configuration you need to do is to create a
`.env` file in the root of this project. You can copy the `.env.example` file and modify it as you need.

```shell
cp .env.example .env
```

### 2.1 Web folder

You need a folder inside your machine in which your web project files are located. By default, `~/www is taken`.
You can set up any other folder using the following env var. 

```dotenv
VHOSTS_DIR=~/www
```

### 2.2 Host names

You need to set up the following hostnames in you local machine hosts file. If you're using Linux usually you
just need to modify the file `/etc/hosts` in most of the cases.

```text
127.0.0.1   app.local.com
127.0.0.1   www.local.com
```

These sites are useful to get some important information about your environment. For example, if you access
to `app.local.com` and you'll get all the information for PHP executed by the `phpinfo()` function (See
[3.1 Running the project](#31-running-the-project)).

The second site will show you all your web folders served by apache unless you have an `index.php` file
inside your `VHOSTS_DIR`. In that case `www.local.com` is going to serve that file.

You can also customize the IP address and port to point the container with the following env vars. The
following are the default values per each var.

```dotenv
BIND_WEB_HOST=127.0.0.1
BIND_WEB_HOST_PORT=80
```

If you change these variables you need to change also your entries in the `/etc/hosts` and any other vhosts you
have created.

### 2.3 Other services

Usually if you have mysql, redis or other services installed locally in your machine you'll need to change
the bindings for that services in the container. Look at the following values to set up those services. The
presented values are the default values per each env var.

**Database**

```dotenv
BIND_DB_HOST=127.0.0.1
BIND_DB_HOST_PORT=3306
```

**Redis**

```dotenv
BIND_REDIS_PORT=6379
```

**Network**

```dotenv
IPV4_NETWORK=172.25.2
```

### 2.4 Data permissions

Since redis db is created in the host machine, you need to run the following command to allow writing.

```bash
chmod o+rwx user/data/redis
```

## :books: 3. Usage

### 3.1 Running the project

Execute the following command in the root project folder to build and start all containers.

```bash
docker-compose up -d --build
```

To check if all was good type in your browser URL `http://app.local.com` and hit enter. You'll see the
PHP configuration executed by the `phpinfo()` function.

![PHPInfo](https://blog.pleets.org/img/articles/phpinfo_php_web_dockerfiles.png)

You can also see the "Index of" your web files by accessing `http://www.local.com`. If you have an `index.php` the server
will render your file.

![PHPInfo](https://blog.pleets.org/img/articles/index_of_directory_apache.png)

### 3.2 Accessing containers

Use any of the following commands to enter the desired container.

```bash
docker exec -it web_app bash
docker exec -it web_app_db bash
docker exec -it web_app_redis bash
```

### 3.3 Adding new virtual hosts

You can add new virtual hosts by creating new files inside `user/vhosts`. For instance, let's say you have the
folder `new-site` in your `VHOSTS_DIR` and you want to add the virtual host `new-site.com` for it. That said, you
can create the file `user/vhosts/new-site.com.conf` with the following contents. 

```apacheconf
<VirtualHost *:80>
    ServerName "new-site.com"
    DocumentRoot "/var/www/vhosts/new-site/"
</VirtualHost>
```

Also, you need to add the following entry to you `/etc/hosts`.

```text
127.0.0.1   new-site.com
```

Note that by default, we've used the address `127.0.0.1`. You need to use the address defined by the env var 
`BIND_WEB_HOST`. In most of the cases will be the same.

Finally, you need to refresh your containers.

```bash
docker-compose down && docker-compose up --build -d
```