/**
 * Created by qikunxiang on 5/11/15.
 */
function initIncidentModalIncident($scope) {
    console.log($scope)
    var timeStr = $scope.incident.time;
    var mmt = moment(timeStr, "YYYY-MM-DDThh:mm:ssZ");
    $scope.incident.time = mmt.format("DD/MM/YYYY hh:mm");

    setTimeout(function() {
        var ichecks = $('div#event-severity-check input[type="checkbox"].flat-yellow, input[type="radio"].flat-yellow');
        ichecks.iCheck({
            checkboxClass: 'icheckbox_flat-yellow',
            radioClass: 'iradio_flat-yellow',
            disabledClass: 'non-clickable'
        });

    }, 200);

    var archiveButton = $('div.to-do-list-incident button#archive-incident');
    var archiveConfirmButton = $('div.to-do-list-incident button#archive-incident-confirm').hide();
    var archiveCancelButton = $('div.to-do-list-incident button#archive-incident-cancel').hide();
    var approveButton = $('div.to-do-list-incident button#approve-incident');
    var approveConfirmButton = $('div.to-do-list-incident button#approve-incident-confirm').hide();
    var approveCancelButton = $('div.to-do-list-incident button#approve-incident-cancel').hide();
    var rejectButton = $('div.to-do-list-incident button#reject-incident');
    var rejectConfirmButton = $('div.to-do-list-incident button#reject-incident-confirm').hide();
    var rejectCancelButton = $('div.to-do-list-incident button#reject-incident-cancel').hide();
    var speed = 150;

    archiveButton.click(function(event) {
        archiveButton.find("span").fadeOut(speed);
        archiveButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed, function () {
            archiveConfirmButton.find("span").fadeIn(speed);
            archiveConfirmButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed);
            archiveCancelButton.find("span").fadeIn(speed);
            archiveCancelButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed);
        });
    });

    archiveCancelButton.click(function(event) {
        archiveConfirmButton.find("span").fadeOut(speed);
        archiveConfirmButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed, function () {
            archiveButton.find("span").fadeIn(speed);
            archiveButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed);
        });
        archiveCancelButton.find("span").fadeOut(speed);
        archiveCancelButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed);
    });

    approveButton.click(function(event) {
        rejectButton.find("span").fadeOut(speed);
        rejectButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed);
        approveButton.find("span").fadeOut(speed);
        approveButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed, function () {
            approveConfirmButton.find("span").fadeIn(speed);
            approveConfirmButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed);
            approveCancelButton.find("span").fadeIn(speed);
            approveCancelButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed);
        });
    });

    approveCancelButton.click(function(event) {
        approveConfirmButton.find("span").fadeOut(speed);
        approveConfirmButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed, function () {
            approveButton.find("span").fadeIn(speed);
            approveButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed);
            rejectButton.find("span").fadeIn(speed);
            rejectButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed);
        });
        approveCancelButton.find("span").fadeOut(speed);
        approveCancelButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed);
    });


    rejectButton.click(function(event) {
        approveButton.find("span").fadeOut(speed);
        approveButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed);
        rejectButton.find("span").fadeOut(speed);
        rejectButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed, function () {
            rejectConfirmButton.find("span").fadeIn(speed);
            rejectConfirmButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed);
            rejectCancelButton.find("span").fadeIn(speed);
            rejectCancelButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed);
        });
    });

    rejectCancelButton.click(function(event) {
        rejectConfirmButton.find("span").fadeOut(speed);
        rejectConfirmButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed, function () {
            approveButton.find("span").fadeIn(speed);
            approveButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed);
            rejectButton.find("span").fadeIn(speed);
            rejectButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed);
        });
        rejectCancelButton.find("span").fadeOut(speed);
        rejectCancelButton.animate({width: "toggle", "padding-left": "toggle", "padding-right": "toggle"}, speed);
    });
}

function initIncidentModalUpdate($scope) {

}

function initIncidentModalDispatch($scope) {

}