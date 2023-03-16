# README

## Introduction ##

Our team is creating an application for the Latino Aggie Mentorship Program (LAMP) organization. This application will enable mentors to keep track of the hours that they have mentored. In addition, mentees will be able to browse all mentors that have similar hobbies and classes to compatible tutors. In addition, the application will be able to keep track of attendance for all members.

## Requirements ##

This code has been run and tested on:

* Ruby - 3.0.2p107
* Rails - 6.1.4.1
* Ruby Gems - Listed in `Gemfile`
* PostgreSQL - 13.3 
* Nodejs - v16.9.1
* Yarn - 1.22.11
* Docker (Latest Container)


## External Deps  ##

* Docker - Download latest version at https://www.docker.com/products/docker-desktop
* Heroku CLI - Download latest version at https://devcenter.heroku.com/articles/heroku-cli
* Git - Download latest version at https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

## Installation ##

Download this code repository by using git:

 `git clone https://github.com/SP23-CSCE431/csce431-sprints-latino-aggie-mentorship.git`


## Tests ##

An RSpec test suite is available and can be ran using:

  `rspec spec/`

## Execute Code ##

Run the following code in Powershell if using windows or the terminal using Linux/Mac

  `cd csce431`

  `docker run --rm -it --volume "$(pwd):/csce431" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 --platform linux/amd64 paulinewade/csce431:latest`

  `cd csce431`

Install the app

  `bundle install && rails webpacker:install && rails db:create && db:migrate`

Run the app
  `rails server --binding:0.0.0.0`

The application can be seen using a browser and navigating to http://localhost:3000/

## Deployment ##

Setup a Heroku account: https://signup.heroku.com/

From the heroku dashboard select `New` -> `Create New Pipline`

Name the pipeline, and link the respective git repo to the pipline

Our application does not need any extra options, so select `Enable Review Apps` right away

Click `New app` under review apps, and link your test branch from your repo

Under staging app, select `Create new app` and link your main branch from your repo

Now once your pipeline has built the apps, select `Open app` to open the app

With the staging app, if you would like to move the app to production, click the two up and down arrows and select `Move to production`

And now your application is setup and in production mode!


## CI/CD ##

For continuous development, we set up Heroku to automatically deploy our apps when their respective github branches are updated.

  `Review app: test branch`

  `Production app: main branch`

For continuous integration, we set up a Github action workflow to run our specs, security checks, linter, etc. after every push or pull-request. This allows us to automatically ensure that our code is working as intended.

## Support ##

Admins looking for support should first look at the application documentation.
Users looking for help seek out assistance from the admins.