import QtQuick 2.0
import QtQuick.Layouts 1.15

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

PlasmaCore.FrameSvgItem {
    id: button

    imagePath: "widgets/viewitem"
    prefix: mouseArea.containsMouse ? (mouseArea.pressed ? "selected+hover" : "hover") : "normal"
    signal clicked
    default property alias content: icon.data
    property alias title: title.text

    GridLayout {
        anchors.fill: parent

        Item {
            id: icon
            Layout.preferredHeight: 30
            Layout.preferredWidth: Layout.preferredHeight
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
        }
        PlasmaComponents.Label {
            id: title
            Layout.fillHeight: true
            Layout.fillWidth: true
            font.weight: Font.Normal
            horizontalAlignment: parent.small ? Qt.AlignHCenter : Qt.AlignLeft
            verticalAlignment: Qt.AlignVCenter
            wrapMode: Text.WordWrap
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            button.clicked()
        }
    }
}
