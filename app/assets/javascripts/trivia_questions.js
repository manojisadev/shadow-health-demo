$(function() {
    $("#item-button").click( function() {
        $(".list-group-item").removeClass("active");
        $(this).addClass("active");
    });
});