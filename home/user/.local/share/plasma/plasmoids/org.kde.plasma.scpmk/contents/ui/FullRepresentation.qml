import QtQml 2.0
import QtQuick 2.2
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.0

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras

import "components" as Components


Item {
    id: fullRep
    
    // PROPERTIES
    Layout.preferredWidth: plasmoid.configuration.width * PlasmaCore.Units.devicePixelRatio
    Layout.preferredHeight: plasmoid.configuration.height * PlasmaCore.Units.devicePixelRatio
    Layout.minimumWidth: Layout.preferredWidth
    Layout.maximumWidth: Layout.preferredWidth
    Layout.minimumHeight: Layout.preferredHeight
    Layout.maximumHeight: Layout.preferredHeight
    clip: true

    // Main wrapper

    ColumnLayout {
        id: wrapper

        anchors.fill: parent
        spacing: 0

        RowLayout {

            spacing: 0
            Layout.fillWidth: true
            
            // Menu Item Buttons
            ColumnLayout {
            spacing: 0
            // Items
            Components.CommandRun{
                visible: root.showCmd1
                title: root.cmdTitle1
                icon: root.cmdIcon1
                command: root.cmdRun1
            }
            Components.BottomSeparator{
                visible: root.showSep1
            }
            Components.CommandRun{
                visible: root.showCmd2
                title: root.cmdTitle2
                icon: root.cmdIcon2
                command: root.cmdRun2
            }
            Components.BottomSeparator{
                visible: root.showSep2
            }
            Components.CommandRun{
                visible: root.showCmd3
                title: root.cmdTitle3
                icon: root.cmdIcon3
                command: root.cmdRun3
            }
            Components.BottomSeparator{
                visible: root.showSep3
            }
            Components.CommandRun{
                visible: root.showCmd4
                title: root.cmdTitle4
                icon: root.cmdIcon4
                command: root.cmdRun4
            }
            Components.BottomSeparator{
                visible: root.showSep4
            }
            Components.CommandRun{
                visible: root.showCmd5
                title: root.cmdTitle5
                icon: root.cmdIcon5
                command: root.cmdRun5
            }
            Components.BottomSeparator{
                visible: root.showSep5
            }
            Components.CommandRun{
                visible: root.showCmd6
                title: root.cmdTitle6
                icon: root.cmdIcon6
                command: root.cmdRun6
            }
            Components.BottomSeparator{
                visible: root.showSep6
            }
            Components.CommandRun{
                visible: root.showCmd7
                title: root.cmdTitle7
                icon: root.cmdIcon7
                command: root.cmdRun7
            }
            Components.BottomSeparator{
                visible: root.showSep7
            }
            Components.CommandRun{
                visible: root.showCmd8
                title: root.cmdTitle8
                icon: root.cmdIcon8
                command: root.cmdRun8
            }
            Components.BottomSeparator{
                visible: root.showSep8
            }
            Components.CommandRun{
                visible: root.showCmd9
                title: root.cmdTitle9
                icon: root.cmdIcon9
                command: root.cmdRun9
            }
            Components.BottomSeparator{
                visible: root.showSep9
            }
            Components.CommandRun{
                visible: root.showCmd10
                title: root.cmdTitle10
                icon: root.cmdIcon10
                command: root.cmdRun10
            }
            }
        }
        Item {
            Layout.fillHeight: true
        }
    }
}
