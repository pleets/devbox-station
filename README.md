# PHP Web Dockerfiles

This project allows you to execute a PHP web based environment to execute your personal or business projects.

## 1. Requirements

You need the following software to run this project.

- Docker
- Docker compose

## :gear: 2. Configuration

Configuration is one of the most important things when you're setting up your projects. You can set up several
components and customize this project as your desire.

### 2.1 Web folder

You need a folder inside your machine in which your web project files are located. By default, ~/www is taken.
You can set up another folder with the env var. 

```dotenv
VHOSTS_DIR=~/www
```

### 2.2 Host names

You need to set up the following hostnames in you local machine hosts file.

```text
127.0.0.1	app.local.com
127.0.0.1   www.local.com
```

You can also customize the IP address or port to point the container with the following env vars. 

```dotenv
BIND_WEB_HOST=127.0.0.1
BIND_WEB_HOST_PORT=80
```

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

## :books: 3. Usage

### 3.1 Running the project

Execute the following command in the root project folder to build and start containers.

```bash
docker-compose up -d --build
```

To check if all was good enter in your browser to `http://app.local.com`. You'll see the PHP configuration executed
by the `phpinfo()` function.

![PHPInfo](https://blog.pleets.org/img/articles/phpinfo_php_web_dockerfiles.png)

You can also see the "Index of" your web files accessing to `http://www.local.com`. If you have a `index.php` the server
will render your file.

To enter inside the terminal for the web container use the following command.

```bash
docker exec -it web_app bash
```