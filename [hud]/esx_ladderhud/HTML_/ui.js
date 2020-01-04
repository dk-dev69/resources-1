$(document).ready(function(){
    window.addEventListener('message', function(event) {
        var data = event.data;
        $(".container-fluid").css("display",data.show? "none":"block");
        $("#hunger").css("width", data.hunger + "%");
        $("#thirst").css("width", data.thirst + "%");
		$("#hp").css("width", data.thirst + "%");
		$("#armor").css("width", data.thirst + "%");
    });
});