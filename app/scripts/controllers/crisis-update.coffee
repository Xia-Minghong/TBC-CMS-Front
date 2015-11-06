'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:CrisisUpdateCtrl
 # @description
 # # CrisisUpdateCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
.controller 'CrisisUpdateCtrl', ($scope, $rootScope, $route, $routeParams, $timeout, Upload, Incident)->

  $scope.init = ()->
    console.log("init")
    Incident.getIncidentFromKey $rootScope.userData.token, $routeParams.key, (incident)->
      if incident
        $scope.incident = incident
      else
        return

    return

  $scope.submitUpdate = ->
    r = $scope.update
    if r and r.severity and r.time and r.description
      console.log $routeParams
      Incident.postIncidentUpdate $rootScope.userData.token, $routeParams.key, r, (success)->
        if success
          $scope.errorMsg = $rootScope.userData.token
          $scope.successMsg = "Submit Success"
#          Incident.getIncidents()
          $route.reload();
        else
          $scope.errorMsg = "Submit Error"
    else
      $scope.errorMsg = "Form incomplete!"
    return

  $scope.$watch 'files', ->
    $scope.upload $scope.files
    return
  $scope.$watch 'file', ->
    if $scope.file != null
      $scope.files = [ $scope.file ]
    return
  $scope.log = ''

  $scope.upload = (files) ->
    if files and files.length
      i = 0
      while i < files.length
        file = files[i]
        if !file.$error
          Upload.upload(
            url: 'https://angular-file-upload-cors-srv.appspot.com/upload'
            data:
              username: $scope.username
              file: file).progress((evt) ->
                progressPercentage = parseInt(100.0 * evt.loaded / evt.total)
                $scope.log = 'progress: ' + progressPercentage + '% ' + evt.config.data.file.name + '\n' + $scope.log
                return
              ).success (data, status, headers, config) ->
                console.log data
                $timeout ->
                  $scope.log = 'file: ' + config.data.file.name + ', Response: ' + JSON.stringify(data) + '\n' + $scope.log
                  return
          return
        i++
    return


  if !$scope.crisisUpdateInitialized
      crisisUpdateInit()
  $scope.crisisUpdateInitialized = true


  return
