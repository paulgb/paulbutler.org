

module.exports =
  templateData:
    moment: require 'moment'

  collections:
    posts: (database) ->
      database.findAllLive({type: 'post'}, {date: -1})

