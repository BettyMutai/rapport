$(document).ready(function() {
    // the "href" attribute of the modal trigger must specify the modal ID that wants to be triggered
    $('.modal').modal();
    // Initialize collapse button
    $(".button-collapse").sideNav();
    $('.fixed-action-btn').openFAB();
    $('.fixed-action-btn').closeFAB();
});