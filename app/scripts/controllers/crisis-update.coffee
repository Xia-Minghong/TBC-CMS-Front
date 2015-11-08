'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:CrisisUpdateCtrl
 # @description
 # # CrisisUpdateCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
.controller 'CrisisUpdateCtrl', ($scope, $rootScope, $location, $route, $routeParams, $timeout, Upload, Incident)->

  $scope.init = ()->
    console.log("init")
    Incident.getIncidentFromKey $rootScope.userData.token, $routeParams.key, (incident)->
      if incident
        $scope.incident = incident
      else
        $location.path('/public')
        return

    return

  $scope.submitUpdate = ->
    r = $scope.update
    if r and r.severity and r.time and r.description
      console.log $routeParams
      Incident.postIncidentUpdate $rootScope.userData.token, $routeParams.key, r, (success)->
        if success
          $scope.errorMsg = ""
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
          console.log("start upload")
          console.log(file)
          Upload.upload(
#            url: 'https://angular-file-upload-cors-srv.appspot.com/upload'
            url: App.host_addr + '/inci_update_photos/'
            data:
#              username: "121"
              "photo": file
          )
          .progress((evt) ->
            progressPercentage = parseInt(100.0 * evt.loaded / evt.total)
            $scope.log = 'progress: ' + progressPercentage + '% ' + evt.config.data.file.name + '\n' + $scope.log
            return
          )

          .success (data, status, headers, config) ->
            console.log("success upload")
            console.log data
            $scope.update.photo_url = data.photo
            $timeout ->
              $scope.log = 'file: ' + config.data.file.name + ', Response: ' + JSON.stringify(data) + '\n' + $scope.log
              return

          .error (data, status, headers, config) ->
            console.log("fail upload")
            console.log data
          return
        i++
    return


  if !$scope.crisisUpdateInitialized
      crisisUpdateInit()
  $scope.crisisUpdateInitialized = true


  return
