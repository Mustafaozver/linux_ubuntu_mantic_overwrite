import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents
import "../code/index.js" as Script

Item {
    id: root

    Layout.fillHeight: true

    property string data: '...'
    property bool updating: false

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    Plasmoid.toolTipTextFormat: Text.RichText
    Plasmoid.backgroundHints: plasmoid.configuration.showBackground ? "StandardBackground" : "NoBackground"

    Plasmoid.compactRepresentation: Item {
        property int textMargin: parent.height
        property int minWidth: textValue.paintedWidth

        Layout.fillWidth: false
        Layout.minimumWidth: minWidth

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                switch(plasmoid.configuration.onClickAction) {
                    case 'nothing':
                        break;

                    case 'refresh':
                    default:
                        updateTimer.restart();
                        break;
                }
            }
        }

        BusyIndicator {
            width: parent.height
            height: parent.height
            anchors.horizontalCenter: textValue.horizontalCenter
            running: updating
            visible: updating
        }

        PlasmaComponents.Label {
            id: textValue
            height: parent.height
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 0

            horizontalAlignment: Text.AlignJustify
            verticalAlignment: Text.AlignJustify

            opacity: root.updating ? 0.2 : mouseArea.containsMouse ? 0.8 : 1.0
            minimumPixelSize: 10
            font.pixelSize: 72
            fontSizeMode: Text.Fit
            text: root.data
        }

        Connections {
            target: plasmoid.configuration

            onXeUrlChanged: {
                updateTimer.restart();
            }
            onRefreshRateChanged: {
                updateTimer.restart();
            }
        }

        Timer {
            id: updateTimer
            interval: plasmoid.configuration.refreshRate * 60 * 1000
            running: true
            repeat: true
            triggeredOnStart: true
            onTriggered: {
                root.updating = true;
                var result = Script.getData(plasmoid.configuration.xeUrl, function(data) {
                    root.data = data;
                    var now = new Date();
                    var time = [('0' + now.getHours()).slice(-2), ('0' + now.getMinutes()).slice(-2), ('0' + now.getSeconds()).slice(-2)].join(':');
                    plasmoid.toolTipSubText = '<b>Loaded at ' + time + '</b>';
                    root.updating = false;
                });
            }
        }
    }

    Component.onCompleted: {
        plasmoid.setAction('refresh', i18n("Refresh"), 'view-refresh')
        plasmoid.setAction('nothing', i18n("Do Nothing"), 'internet-services')
    }
}
