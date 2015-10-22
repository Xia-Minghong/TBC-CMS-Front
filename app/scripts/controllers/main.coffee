'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
  .controller 'MainCtrl', ($scope, $location, Incident)->

    $scope.incidents = []

    $scope.isActive = (viewLocation) ->
      return (viewLocation == $location.path());

    $scope.getIncidents = ()->
      #send an empty token and a callback to the Incident Service
      Incident.getIncidents "", (data)->
        # what to do after getting data
        $scope.incidents = data;
        return

    $scope.parseDate = (timestamp) ->
      datetime = new Date timestamp
      date = [
        datetime.getDate()
        datetime.getMonth() + 1
        datetime.getFullYear()
      ]
      # Create an array with the current hour, minute and second
      time = [
        datetime.getHours()
        datetime.getMinutes()
    #      datetime.getSeconds()
      ]
      # Determine AM or PM suffix based on the hour
      suffix = if time[0] < 12 then 'AM' else 'PM'
      # Convert hour from military time
      time[0] = if time[0] < 12 then time[0] else time[0] - 12
      # If hour is 0, set it to 12
      time[0] = time[0] or 12
      # If seconds and minutes are less than 10, add a zero
      i = 1
      while i < 3
        if time[i] < 10
          time[i] = '0' + time[i]
        i++
      # Return the formatted string
      return date.join('/') + ' ' + time.join(':') + ' ' + suffix

    $scope.$on '$viewContentLoaded', ->
      setTimeout(initMap, 600)
      return

    return
