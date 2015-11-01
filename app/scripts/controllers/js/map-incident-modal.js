function initMapIncidentModal($scope) {
    var timeStr = $scope.incident.time;
    var mmt = moment(timeStr, "YYYY-MM-DDThh:mm:ssZ");
    $scope.incident.time = mmt.format("DD/MM/YYYY hh:mm");

    setTimeout(function() {
        var ichecks = $('div#event-severity-check input[type="checkbox"].flat-red, input[type="radio"].flat-red');
        ichecks.iCheck({
            checkboxClass: 'icheckbox_flat-red',
            radioClass: 'iradio_flat-red',
            disabledClass: 'non-clickable'
        });

    }, 200);
}