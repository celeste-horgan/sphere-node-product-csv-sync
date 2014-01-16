_ = require('underscore')._
Csv = require 'csv'

class Validator
  constructor: (options) ->

  parse: (csvString, callback) ->
    Csv().from.string(csvString)
    .to.array (data, count) ->
      callback data, count
    .on "error", (error) ->
      throw new Error error

  validate: (csvContent) ->
    errors = []
    errors.concat(@valHeader csvContent)
    errors

  valHeader: (csvContent) ->
    errors = []
    necessaryAttributes = [ 'productType', 'variantId' ]
    header = csvContent[0]
    remaining = _.difference necessaryAttributes, header
    if _.size(remaining) > 0
      for r in remaining
        errors.push "Can't find necessary header '#{r}'"
    errors

module.exports = Validator
