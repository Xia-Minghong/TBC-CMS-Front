'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
.controller 'UserLoginCtrl', ($scope, $rootScope, $location, User, localStorageService)->

  $scope.loginData = {}

  $scope.doLogin = ()->
    if !($scope.loginData.username and $scope.loginData.password)
      $scope.errorMsg = "Form Incomplete"
      return

    User.login $scope.loginData, (data) ->
      if data.hasOwnProperty('access_token')
#        $rootScope.userData.token = data.token_type + ' ' + data.access_token
        # use local storage instead
        token = data.token_type + ' ' + data.access_token
        localStorageService.set("token", token)
        $scope.errorMsg = ""
        $scope.successMsg = "Login Success"

        User.getProfile token, (data) ->
          $rootScope.userData = data
          $rootScope.userData.token = token
          if($rootScope.userData)
            switch $rootScope.userData.concreteuser.type
              when "crisis_manager"
                $location.path("/")
              when "kdm"
                $location.path("/kdm")
              when "operator"
                $location.path("/create-crisis")
              else
                $location.path("/public")
          else
            $location.path("/login")
        return
      else
        $scope.errorMsg = "Invalid Credentials"
      return


  if !$scope.loginInitialized
    initLogin($scope)
    $scope.loginInitialized = true
  return
