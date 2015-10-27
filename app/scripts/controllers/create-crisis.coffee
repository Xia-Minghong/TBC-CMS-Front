'use strict'

###*
 # @ngdoc function
 # @name tbcCmsFrontApp.controller:CreateCrisisCtrl
 # @description
 # # CreateCrisisCtrl
 # Controller of the tbcCmsFrontApp
###
angular.module 'tbcCmsFrontApp'
.controller 'CreateCrisisCtrl', ($scope)->
    $('select.select2').select2()

    $('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck
        checkboxClass: 'icheckbox_flat-red'
        radioClass: 'iradio_flat-red'

    $('div#severity div.iradio_flat-red input, div#severity div.iradio_flat-red ins').css({display: 'none'})

    $('div#severity div.iradio_flat-red').click (e) ->
        e.preventDefault()
        e.stopPropagation()

        sev = parseInt($(e.target).find('input[type="radio"]').attr('name').replace('sev', ''))
        $('div#severity div.iradio_flat-red').removeClass('checked')
        i = 1
        while i <= sev
            $('div#severity input[type="radio"][name="sev' + i + '"]').parent().addClass('checked')
            i++
        return
    $('.timepicker').timepicker showInputs: true

    $scope.$on '$viewContentLoaded', ->
        initMap()


    if !$scope.crisisReportInitialized
        createCrisisInit()
        $scope.crisisReportInitialized = true


    return