import QtQuick 2.2
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item
{

    property alias cfg_work_time:               work_time.value
    property alias cfg_break_time:              break_time.value
    property alias cfg_min_idle:                min_idle.value
    property alias cfg_hide_and_show_mode:      hs_mode.checked
    property alias cfg_hs_show_on_mouse_over:   show_on_over.checked
    property alias cfg_show_m:                  show_m.checked
    property alias cfg_auto_position_m:         auto_position_m.checked



    Column
    {

        GridLayout
        {
            columns: 2
            
            Label
            {
                text: "Work time"
            }

            SpinBox
            {
                id:             work_time
                minimumValue:   1
                maximumValue:   999
                suffix:         " m"
            }

            Label
            {
                text: "Break time"
            }

            SpinBox
            {
                id:             break_time
                minimumValue:   1
                maximumValue:   999
                suffix:         " m"
                
                onValueChanged: min_idle.value = (value == 1)
                                                 ? 50 
                                                 : (value - 1) * 60
            }

        }       // GridLayout

        Rectangle               // separator space
        {
            width: 5
            height: 20
            opacity: 0
        }

        Button
        {
            id: advanced_button
            text: checked ? " Advanced  < " : " Advanced  > "
            checkable:  true
        }

        Rectangle               // separator space
        {
            width: 5
            height: 20
            opacity: 0
        }


        Column          // advanced
        {
            visible: advanced_button.checked

            Row
            {
                Label
                {
                    text: "Yellow background when idle for "
                    anchors.verticalCenter: parent.verticalCenter
                }

                SpinBox
                {
                    id:             min_idle
                    minimumValue:   1
                    maximumValue:   9999
                    suffix:         " s"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }

            CheckBox
            {
                id:         hs_mode
                text:       "Hide the countdown"
            }
                
            CheckBox
            {
                id:         show_on_over
                text:       "Show on mouse hover"
                x:          30
                enabled:    hs_mode.checked
            }

            CheckBox
            {
                id:         show_m
                text:       "Show 'm'"
                enabled:    ! hs_mode.checked || show_on_over.checked
            }

            CheckBox
            {
                id:         auto_position_m
                text:       "Automatic position"
                x:          30
                enabled:    show_m.checked && show_m.enabled
            }
        }       // Column (advanced)

    }       // Column

    
}
