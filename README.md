# COMBAT SQUADRON

## DESCRIPTION

A Sinatra web app for Mass Multiplayer Online (MMO) flight simulator communities to keep track of their team’s progress and stats. It allows for the creation of *pilots*(read: users), *planes* and *weapons* for the aforementioned *planes*. *Pilots* can create *planes* and *weapons*, but cannot delete other *pilots* or *planes* that they haven't signed up to fly. However any *pilot* can delete any *weapon*. I think this is a project that I would like to expand on in the future and perhaps include a scraping ability so as to retrieve data from player server pages as well as migrating this code to Rails.

## DOWNLOAD/INSTALL

**SSH**
`git clone git@github.com:jonpstone/portfolio-project-sinatra-combat-squadron.git`

**URL**
`git clone https://github.com/jonpstone/portfolio-project-sinatra-combat-squadron.git`

Install [Shotgun](https://github.com/rtomayko/shotgun) and [bundler](https://github.com/bundler/bundler) to run locally.

## USAGE

**setup local gems**
Enter directory `../portfolio-project-sinatra-combat-squadron` and run migrations `bundle install`.

**Run Migrations**
While in the same directory run `rake db:migrate`.

**Once in the directory**
Enter `shotgun`.

**Any issues? Try..**
Enter `bundle exec shotgun`.

## CONTRIBUTING

See [contributing](https://github.com/jonpstone/portfolio-project-sinatra-combat-squadron/blob/master/CONTRIBUTING.md).
