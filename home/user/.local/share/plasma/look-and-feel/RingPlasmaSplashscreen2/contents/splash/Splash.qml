import QtQuick 2.5
import QtGraphicalEffects 1.15

import QtQuick.Window 2.2
import org.kde.plasma.core 2.0 as PlasmaCore


Rectangle {
    id: root
    color: "#141414"

     property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true
        }
      }


    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }
    
        Image {
            id: busyIndicator
            
            property real size: units.gridUnit * 8
            anchors.centerIn: parent

            source: "images/animation01.png"
            sourceSize.height: units.gridUnit * 9
            sourceSize.width: units.gridUnit * 9
            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 2300
                loops: Animation.Infinite
            }
        }

    }

    OpacityAnimator {
        id: introAnimation
        running: true
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }

    Row {
            spacing: PlasmaCore.Units.smallSpacing*2
            anchors {
                bottom: parent.bottom
                right: parent.right
                margins: PlasmaCore.Units.gridUnit
            }
            Text {
                color: "#eff0f1"
                // Work around Qt bug where NativeRendering breaks for non-integer scale factors
                // https://bugreports.qt.io/browse/QTBUG-67007
                renderType: Screen.devicePixelRatio % 1 !== 0 ? Text.QtRendering : Text.NativeRendering
                anchors.verticalCenter: parent.verticalCenter
                text: i18ndc("plasma_lookandfeel_org.kde.lookandfeel", "This is the first text the user sees while starting in the splash screen, should be translated as something short, is a form that can be seen on a product. Plasma is the project name so shouldn't be translated.", "Plasma made by KDE")
            }
            Image {
                source: "images/kde.svgz"
                sourceSize.height: PlasmaCore.Units.gridUnit * 1
                sourceSize.width: PlasmaCore.Units.gridUnit * 1
            }
        }

       
    
}
