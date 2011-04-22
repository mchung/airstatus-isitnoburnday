# airstat.us

A quick project to celebrate Earth Day.

airstat.us visitors can view the current status of air quality for the following areas:

  * Maricopa County, http://www.cleanairmakemore.com/
  * San Francisco, http://sparetheair.org/

Support for other cities will be coming soon.

## Thanks

  * [Earth Day 2011](http://www.earthday.org/earth-day-2011)
  * [Matt Clower](http://clowerpower.com), for the name
  * [Jenny Poon](http://eekostudio.com), for the logo

## Developers

### Setting everything up

    git clone ....
    cd airstatus
    bundle update

### Starting the application

    shotgun --server=thin --port=5000 config.ru
    Visit http://localhost:5000

### Contributing

Once you've made your commits:

1. [Fork](http://help.github.com/forking/) airstatus
2. Create a topic branch - git checkout -b my_branch
3. Push to your branch - git push origin my_branch
4. Create a [Pull Request](http://help.github.com/pull-requests/) from your branch
5. That's it!
