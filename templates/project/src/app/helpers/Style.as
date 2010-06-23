package app.helpers
{   
    import tidy.mvc.view.PackableView;
    /*
    Example of some PackableView style parameters
    */
    public class Style
    {
        public static var DEFAULT : Object = {
            orientation: PackableView.VERTICAL, // elements can be stacked either horizontally or vertically
            paddingLeft: 20, // appended elements will have this much space to the left
            paddingTop: 20, // appended elements will have this much space above
            spacing: 10, // this is the spacing between appended elements 
            columnWidth: 600, // this is the default text field width
            maxWidth: 600, // in a horizontal layout, this is when the elements start to wrap
            maxHeight: 800 // in a vertical layout, this is when the elements flow into a new column
            
        };
    }
}