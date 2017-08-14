# README

[![Build Status](https://travis-ci.org/honeymoon-answer/answer.svg?branch=master)](https://travis-ci.org/honeymoon-answer/answer)

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  - 2.4

* System dependencies
  - mysqld
  - [yarn](https://yarnpkg.com/lang/en/)

* Configuration

* Setup

```bash
$ bundle install --path vendor/bundle
$ yarn install
```

* Database creation

```bash
$ bin/rake db:create
```

* Database initialization

```bash
$ bin/rake db:migrate
```

* How to run the test suite

```bash
$ bin/rake test
```

* How to run the local development server

```bash
# Run both servers
$ bin/webpack-dev-server
$ rails s
```
