import QtQuick                      2.0
import QtQuick.Layouts              1.1
import org.kde.plasma.components    2.0     as PlasmaComponents
import org.kde.plasma.core          2.0     as PlasmaCore
import org.kde.plasma.plasmoid      2.0

import "lib"




Item
{
    id: root

    property bool panel_horizontal: 
        (plasmoid.formFactor == PlasmaCore.Types.Horizontal) ? true  :
        (plasmoid.formFactor == PlasmaCore.Types.Vertical)   ? false :
        (root.width > root.height)  // in desktop, the smallest length restricts

    property bool hide:             // hide widget?
        cfg_hs_mode                 // hide&show mode is enabled
        &&
        (
            hs_just_enabled         // hide inmediately (user just enabled hs)
            ||
            ! cfg_hs_show_omo       // don't show widget when mouse is over
            ||
            ( 
               (! mouse_is_over) && (mouse_exit_counter == 0)
            )
        )


    property int no_hs_width:   show_tired 
                                ? img_tired.width + 4
                                : all_text_rect.width + 4
    property int hs_width:      show_tired ? no_hs_width : 1    // 1px in hs
    property int widget_width:  hide ? hs_width : no_hs_width
    
    Layout.preferredWidth:      panel_horizontal ? widget_width : 0
    Layout.maximumWidth:        panel_horizontal ? widget_width : 0

    
    property int no_hs_height:  show_tired 
                                ? img_tired.height
                                : all_text_rect.height
    property int hs_height:     show_tired ? no_hs_height : 1    // 1px in hs
    property int widget_height: hide ? hs_height : no_hs_height
    
    Layout.preferredHeight:     panel_horizontal ? 0 : widget_height
    Layout.maximumHeight:       panel_horizontal ? 0 : widget_height

    property int countdown_minutes: 
        Math.floor((cfg_work_time - work_time_counter - 1) / 60) + 1


    Component.onCompleted:
    {
        idle_src.interval = 1000        // enable idle polling
        timer.start()                   // start timer
    }



    Rectangle
    {
        color: root.bg_color
        opacity: 0.7
        anchors.fill: img_tired
        visible: img_tired.visible
    }


    Image
    {
        id: img_tired
        source: "../../face-yawn.svg"
        sourceSize.height: panel_horizontal ? root.height : 0
        sourceSize.width:  panel_horizontal ? 0           : root.width
        fillMode: Image.PreserveAspectFit
        smooth: true
        anchors.centerIn: parent
        visible: root.show_tired
    }


    Item
    {
        id: all_text_rect        // rectangle with all text 

        property int separ:  2        // separation (pixels) between number and "m"
        property bool cd_vert:        // show countdown in vertical way? ("m" below number)
            (! cfg_auto_position_m || ! cfg_show_m )  // if not auto position or not show "m"
            ? false                     //  -> horizontal way
            : root.panel_horizontal     // else, it depends on panel type (horiz. or vert.)
                ? ( (num_rect.height + m_rect.height + separ) <= root.height ) // horiz. -> enough height?
                : ( (num_rect.width + m_rect.width + separ) > root.width )   // vert. -> not enough width?

        visible: ! root.show_tired && ! hide

        anchors.centerIn: parent
        width:  ! cfg_show_m
                ? num_rect.width     // if not show "m" -> take width from number
                : cd_vert           // else, the width depends on where the "m" is
                    ? Math.max(num_rect.width, m_rect.width)  // "m" is below number -> take max width
                    : num_rect.width + m_rect.width + separ   // "m" is on the right -> sum all widths
        height: ! cfg_show_m
                ? num_rect.height    // if not show "m" -> take height from number
                : cd_vert           // else, the height depends on where the "m" is
                    ? num_rect.height + m_rect.height + separ  // "m" is below number -> sum all heights
                    : Math.max(num_rect.height, m_rect.height) // "m" is on the right -> take max height


        Item
        {
            id:     num_rect        // rectangle with number

            anchors.horizontalCenter: parent.cd_vert
                                      ? parent.horizontalCenter
                                      : undefined
            anchors.verticalCenter:   parent.cd_vert
                                      ? undefined
                                      : parent.verticalCenter
            x: parent.cd_vert ? undefined : 0
            y: parent.cd_vert ? 0         : undefined

            width:  num_max_size.real_width
            height: num_max_size.real_height


            PlasmaComponents.Label
            {
                id: num_label       // number label
                text: countdown_minutes
                anchors.centerIn: parent
            }


            PlasmaComponents.Label
            {
                id: num_max_label    // number label with max size
                text:  (root.countdown_minutes <  10) ?   4 : 
                       (root.countdown_minutes < 100) ?  44 : 
                                                        444     // "4" digit has the longest width
                visible: false
                anchors.centerIn: parent
            }


            TextSize
            {
                id:      num_max_size     // size of number max label
                font:    num_max_label.font
                text:   num_max_label.text
            }


        }   // num_rect
    

        Item
        {
            id:     m_rect      // rectangle with "m"

            anchors.horizontalCenter: parent.cd_vert
                                      ? parent.horizontalCenter
                                      : undefined
            anchors.verticalCenter:   parent.cd_vert
                                      ? undefined
                                      : parent.verticalCenter
            x:  parent.cd_vert
                ? undefined
                : num_rect.width + all_text_rect.separ
            y:  parent.cd_vert
                ? num_rect.height + all_text_rect.separ
                : undefined

            width:      m_size.real_width
            height:     m_size.real_height

            visible:    cfg_show_m


            PlasmaComponents.Label
            {
                id: m_label
                text: "m"
                opacity: 0.3
                anchors.centerIn: parent
            }


            TextSize
            {
                id:     m_size
                font:   m_label.font
                text:   m_label.text
            }

        }   // m_rect

    
    }   // all_text_rect



    MouseArea
    {
        id:             mouse_area
        anchors.fill:   parent
        hoverEnabled:   true                // enable enter and exit events

        onClicked:
        {
            if (mouse.modifiers == Qt.NoModifier)         // just click
                widget_clicked()
            else if (mouse.modifiers & Qt.ControlModifier)
            {
                if (mouse.modifiers & Qt.ShiftModifier)   // control+shift+click
                    widget_control_shift_clicked()
                else                                      // control+click
                    widget_control_clicked()
            }
        }

        onEntered: mouse_entered()          // mouse has entered the area
        onExited:  mouse_exited()           // mouse has left the area
    }


    
    property bool   state_is_work:      true   // true=work, false=ready_to_work
    property bool   show_tired:         false  // show tired icon?
    property string bg_color:           "red"  // background color for icon
    property int    work_time_counter:  0
    property int    mem_idle_t_when_ready   // to memorize idle time when ready

    property bool   mouse_is_over:      mouse_area.containsMouse
    property int    mouse_exit_counter: 0     // time counter after mouse exited
    property bool   hs_just_enabled:    false  // user has just enabled hs mode


    property int  cfg_work_time:        plasmoid.configuration.work_time  * 60
    property int  cfg_brk_time:         plasmoid.configuration.break_time * 60
    property int  cfg_min_idle:         plasmoid.configuration.min_idle

    property bool cfg_hs_mode:          plasmoid.configuration.hide_and_show_mode
    property bool cfg_hs_show_omo:      plasmoid.configuration.hs_show_on_mouse_over
    property int  cfg_hs_show_time:     5 + 1   // time to show the widget after omo

    property bool cfg_show_m:           plasmoid.configuration.show_m
    property bool cfg_auto_position_m:  plasmoid.configuration.auto_position_m



    function add_second()
    {
        work_time_counter += 1
        calculate()
        if (mouse_exit_counter > 0)
            mouse_exit_counter--
    }

    function idle_updated()
    {
        calculate()
    }

    function widget_clicked()
    {
        restart_counter()               // calls calculate()
    }

    function widget_control_clicked()
    {
        plasmoid.configuration.hs_show_on_mouse_over = true
        change_hs_mode()
    }

    function widget_control_shift_clicked()
    {
        plasmoid.configuration.hs_show_on_mouse_over = false
        change_hs_mode()
    }

    function change_hs_mode()
    {
        if (! cfg_hs_mode)              // user has just enabled hs mode
            hs_just_enabled = true      // hide inmediately
        plasmoid.configuration.hide_and_show_mode = 
            ! plasmoid.configuration.hide_and_show_mode     // enable/disable hs
    }

    function mouse_entered()
    {
        mouse_exit_counter = cfg_hs_show_time       // start counter to hide
        hs_just_enabled = false
    }

    function mouse_exited()
    {
        mouse_exit_counter = cfg_hs_show_time       // start counter to hide
        hs_just_enabled = false
    }

    function restart_counter()
    {
        timer.stop()               
        work_time_counter = 0       // restart counter
        timer.start()               // syncronize timer to this moment
        calculate()         // recalculation required (due to counter restart)
    }


    function calculate()
    {
        // Config available?
        if (! (cfg_work_time > 0))
            return          // quit calculate() if config still not available

        // Calculated values
        var c_idle_t = Math.floor(idle_src.data.UserActivity.IdleTime / 1000) // idle time (in seconds)
        var c_work_out  = (work_time_counter >= cfg_work_time) // work time out?
        var c_user_idle = (c_idle_t >= cfg_min_idle)           // user is idle?
        var c_idle_out  = (c_idle_t >= cfg_brk_time)           // idle time out?

        // Changes of state
        if (state_is_work)
        {
            // Idle time out
            if (c_idle_out)
            {
                state_is_work = false             // change to "ready" state
                mem_idle_t_when_ready = c_idle_t  // memorize current idle time
            }
        }
        else        // state is "ready"
        {
            // Has user came back?
            if (c_idle_t < mem_idle_t_when_ready)
            {
                state_is_work = true        // change to "work" state
                restart_counter();          // calls calculate()
                return;                     // quit original calculate()
            }
        }

        // Show tired icon
        show_tired = (c_work_out || c_user_idle)  // work time out or user idle

        // Background color (for tired icon)
        if (show_tired)
        {
            if (! state_is_work)        // idle completed
                bg_color = "green"
            else if (c_user_idle)       // idle not completed
                bg_color = "yellow"
            else                        // not idle
                bg_color = "red"
        }
    }



    Timer
    {
        id: timer

        interval:   1000
        running:    false       // stopped at start
        triggeredOnStart: false
        repeat:     true
        onTriggered: add_second()
    }


    PlasmaCore.DataSource
    {
        id: idle_src

        engine: "powermanagement"
        interval: 0             // no polling (stopped) at start
        connectedSources: ["UserActivity"]
        // Idle with more than 5 minutes of user inactivity

        onNewData: idle_updated()
    }


}

