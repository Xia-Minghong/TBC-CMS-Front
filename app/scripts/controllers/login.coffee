'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
.controller 'UserLoginCtrl', ($scope, $rootScope, User)->

  $scope.loginData = {}
  $rootScope.userData = {}

  $scope.doLogin = ()->
    if !($scope.loginData.username and $scope.loginData.password)
      $scope.errorMsg = "Form Incomplete"
      return

    User.login $scope.loginData, (data) ->
      if data.hasOwnProperty('access_token')
        $rootScope.userData.token = data.token_type + ' ' + data.access_token
        $scope.successMsg = "Login Success"
#        User.getProfile $scope.userData.token, "0", "students", (data) ->
#          token = $scope.userData.token
#          $scope.userData = data
#          $scope.userData.token = token
#          $state.go('app.events')
        return
      else
        $scope.errorMsg = "Invalid Credentials"
      return


  if !$scope.loginInitialized
    initLogin($scope)
    $scope.loginInitialized = true
  return
