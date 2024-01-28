# Introduction

AuthRails provides a simple authentication API for Ruby on Rails application.

## Features

### API Controller to Sign In User

AuthRails provides a default controller to do sign in for your user using JWT.

This controller will generate `access_token` to verify user for their next access and `refresh_token` to re-generate `access_token` when it is expired.

### Allowed Token Strategy

Allowed Token Strategy will store the `refresh_token` to the database. Only those valid tokens can be used to re-generate `access_token`.

Whenever the `refresh_token` is used, it will be deleted and new `refresh_token` is stored in the database.

## Alternative

- [devise](https://github.com/heartcombo/devise)
