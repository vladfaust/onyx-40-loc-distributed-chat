[![Built with Crystal](https://img.shields.io/badge/built%20with-crystal-000000.svg?style=flat-square)](https://crystal-lang.org/)
[![Travis CI build](https://img.shields.io/travis/vladfaust/onyx-40-loc-distributed-chat/master.svg?style=flat-square)](https://travis-ci.org/vladfaust/onyx-40-loc-distributed-chat)

This repository contains code from the [Distributed websocket chat in 40 lines of code](https://blog.onyxframework.org/posts/distributed-websocket-chat-in-40-loc/) blog post. It is powered by [Crystal](https://crystal-lang.org/), [Onyx Framework](https://onyxframework.org/) and [Redis](https://redis.io/).

⚠️ **NOTE:** The application requires **Redis version >= 5**!

## Installation

0. Install Crystal. See the [installation instructions](https://crystal-lang.org/reference/installation/index.html).

1. Clone the repository:

```sh
> git clone https://github.com/vladfaust/onyx-40-loc-distributed-chat && \
cd onyx-40-loc-distributed-chat
```

2. Install dependenies:

```sh
> shards install
```

3. Run the server:

```sh
> env REDIS_URL=<YOUR_REDIS_5_URL> PORT=5000 crystal src/server.cr
```

4. Test the server with [wscat]():

```sh
> wscat --connect localhost:5000?username=Alice
> Hi
< Alice: Hi
>
```

5. Repeat steps 3 and 4 with another `PORT` to see the distribution in action.

## Contributors

- [Vlad Faust](https://github.com/your-github-user) - creator and maintainer

## Licensing

This software is licensed under [MIT License](LICENSE).

[![Open Source Initiative](https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Opensource.svg/100px-Opensource.svg.png)](https://opensource.org/licenses/MIT)
