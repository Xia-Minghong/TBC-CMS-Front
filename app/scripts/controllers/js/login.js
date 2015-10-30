/**
 * Created by qikunxiang on 30/10/15.
 */
function initLogin($scope) {
    setTimeout(function() {
        $('input#rmbme').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
        });
    }, 500);
}