/* FUNCTION DECLARATIONS */

function draw_lines(start_column, goal_column, direction, paper){
/*Function to draw the lines between two columns*/
/*Direction can be "ltr" (left to right) or "rtl" (right to left)*/
    start_column.children().each(function(){
       start_element = $(this);
       start_element_pos = start_element.position();
       start_element_x_pos = start_element_pos.left;
       start_element_y_pos = start_element_pos.top + 15;
       
/*       Limit to the visible elements in column 1*/
       if ( (start_element_y_pos < -10) || (start_element_y_pos > container_height +30 )) {
           return
       };
       
       start_element_width = start_element.width();
       
       if ( direction === "rtl" ) {
            start_element_x_pos = start_element_x_pos + start_element_width; // to start at the end of the element   
       };
       
       verse_number = start_element.children(".align_nr").text();
       
       goal_element = goal_column.find(".align_nr").filter(function() {
            return $(this).text() === verse_number;
            }).parent();
       goal_element_pos = goal_element.position();
       
       if ( goal_element.is('div.tei-line') ) {
            goal_element_x_pos = goal_element_pos.left;
            goal_element_y_pos = goal_element_pos.top + 15;
            goal_element_width = goal_element.width();      
            if ( direction === "rtl" ) {
                goal_element_x_pos = goal_element_x_pos + goal_element_width;    
            };
            if ( direction === "ltr" ) {
                var curve = paper.path("m "+ start_element_x_pos + " " + start_element_y_pos + " l "+ start_element_width +" 0 L "+ goal_element_x_pos + " " + goal_element_y_pos + " l " + goal_element_width + " 0");    
            }else if ( direction === "rtl"){
                var curve = paper.path("m "+ start_element_x_pos + " " + start_element_y_pos + " l -"+ start_element_width +" 0 L "+ goal_element_x_pos + " " + goal_element_y_pos + " l -" + goal_element_width + " 0");
            };
             
            curve.attr({stroke: 'green', 'stroke-width': 20, 'stroke-opacity': 0.2})    
       };
    });  
};

function create_align(){
    container_width = $("#synoptic_container").width();
    container_height = $("#synoptic_container").children().first().height(); 
    var paper = new Raphael(document.getElementById('canvas_container'), container_width, container_height);
    
    first_column = $("#synoptic_container").children().first();
    second_column = $("#synoptic_container").children().eq(1);
    
/*    Create the lines from each column to the other. Could theoretically add more columns*/
    draw_lines(first_column, second_column, "ltr", paper);
    draw_lines(second_column, first_column, "rtl", paper);

};

function joint_scroll(scrolled_column){
    col_index = scrolled_column.index();
    if ( scrolled[col_index] === 0) {
        scrolled[col_index] = 1
        
        other_col_index = Math.abs(col_index - 1);
        var new_y = scrolled_column.scrollTop();
        var mov = new_y - scroll_master[col_index]
        scroll_master[col_index] = new_y
        if ( $("input[name='joint_scrolling']").is(':checked') ){
            $(".column").eq(other_col_index).scrollTop(scroll_master[other_col_index] + mov);
            scroll_master[other_col_index] = scroll_master[other_col_index] + mov;
        };
        
        $.each(scroll_master,function(index,value) { /* Can't go below 0 to the basic position */
               if (value < 0){
                   scroll_master[index] = 0;
               };  
        });
        scrolled[other_col_index] = 1;
    } else {
      scrolled = [0,0];  
    };
};


/* VARIABLES */

var scroll_master = [0,0] /* Stores the current scroll position of each column (from the top) */
var scrolled = [0,0] /* To prevent redundant scrolling. Each time a column is scrolled the counter goes to 1. Wenn all are one should reset. */

/* ACTIVATION */

$(document).ready(function() {
    create_align();
   
    $('.column').scroll(function(){
        
        joint_scroll( $(this) );
        
        $("svg").remove();
        create_align();
    });  
});

$( window ).resize(function() {
    $("svg").remove();
    create_align();
    
});


    



