# BUREAU DE CHANGE APP
This is a minimal implementation of a Bureau De Change app for currency exchange for a fictitious *Madam Ajebo*. <br>
[Live Demo](https://damp-beach-22683.herokuapp.com/)
- Demo Credentials for the Admin, Email: admin@test.com, Password: secret
- Demo Credentials for User, Email: user@test.com, Password: secret

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. 

### Prerequisites

- [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
- [Rails](http://installrails.com/)


### Installing

- Run `bundle` to install all project dependencies.
- Run `gem install foreman` to add Foreman.

### Setup Database

Run Migration and Seeder with the following command:

```
rails db:migrate
rails db:seed
```

### Serve Project

Run the server with the following command:

```
foreman start
```

Once its running, head over to your browser to [http://127.0.0.1:5000/](http://127.0.0.1:5000/).


## Authors

* **Tever Aosu** [truetechcode](https://github.com/truetechcode)

## License

![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)
