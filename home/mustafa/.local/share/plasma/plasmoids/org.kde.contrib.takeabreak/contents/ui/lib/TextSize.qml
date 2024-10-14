import  QtQuick     2.0


//  Description:
//      This component (TextSize) obtains the real size (real width and real 
//      height) of a text component (Text, Label, PlasmaComponents.Label, etc).
//  
//      The real size is obtained by using a modern component (TextMetrics)
//      that is available only in QtQuick 2.5 or newer. If the user has an
//      older version (QtQuick 2.0), then a classic component (Text) will be 
//      used instead, so the size obtained will not be so real, but it will 
//      work!
//
//      The adventage of using TextSize is that you will get a size as real
//      as possible, and your program will work in both old and new versions
//      of QtQuick, because they are detected automatically.
//
//  How to use:
//      Just set the "font" and "text" properties, and you will get the real
//      size (well, as real as possible) in the "real_width" and "real_height"
//      properties.
//
//  Example of use:
//  
//      import  QtQuick  2.0  // your program will work in QtQuick 2.0 or newer!
//      import "lib"          // just put "TextSize.qml" into a "lib" subdir
//      
//      Rectangle             // an orange rectangle with the size of the_text
//      {
//          color:  "orange"
//          width:  t_size.real_width
//          height: t_size.real_height
//      
//          Text                        // yellow text into the rectangle
//          {
//              id:     the_text
//              text:   "Some text"
//              color:  "yellow"
//              anchors.centerIn: parent
//          }
//      
//          TextSize                    // calculates the real size of the_text
//          {
//              id:     t_size
//              font:   the_text.font
//              text:   the_text.text
//          }
//      }



Item
{
    id: root

    
    // Public properties
    property variant  font:   undefined         // font parameter from caller
    property string   text:   ''                // text parameter from caller

    property real real_width:       // real width of text (to be read by caller)
        (_text_metrics === null)
        ? fallback_text.width
        : _text_metrics.tightBoundingRect.width
    property real real_height:      // real height of text (to be read by caller)
        (_text_metrics === null)
        ? fallback_text.height
        : _text_metrics.tightBoundingRect.height



    // Private properties
    property variant  _text_metrics:    null    // TextMetrics object (to be created)



    Text        // fallback text (will be used if QtQuick 2.5 is not available)
    {
        id:     fallback_text

        font:   root.font
        text:   root.text

        visible:    false
    }
        

    Binding     // binds TextMetrics font property to caller's font parameter
    {
        target:     root._text_metrics
        property:   "font"
        value:      root.font
        when:       root._text_metrics !== null
    }

    Binding     // binds TextMetrics text property to caller's text parameter
    {
        target:     root._text_metrics
        property:   "text"
        value:      root.text
        when:       root._text_metrics !== null
    }



    function create_text_metrics()      // creates a TextMetrics object (if QtQuick 2.5 is available)
    {
        var t_m = Qt.createQmlObject("import QtQuick 2.5; TextMetrics { }", root);   // returns null if error

        if (t_m !== null )
        {
            root._text_metrics = t_m
        }
    }


    // Create TextMetrics after the TextSize has been created
    Component.onCompleted:  root.create_text_metrics();

}

