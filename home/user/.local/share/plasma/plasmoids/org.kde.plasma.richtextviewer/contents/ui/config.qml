import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import org.kde.plasma.components 2.0 as PlasmaComponents
import "../code/index.js" as Script

Item {
    id: config
    Layout.fillWidth: true
    property alias cfg_xeUrl: xeUrl.text

    property string cfg_onClickAction: plasmoid.configuration.onClickAction
    property alias cfg_refreshRate: refreshRate.value

    property alias cfg_showBackground: showBackground.checked


    GridLayout {
        columns: 2

        Label {
            text: i18n("URL:")
        }

        TextField {
            id: xeUrl
            Layout.minimumWidth: theme.mSize(theme.defaultFont).width * 30
        }

        Label {
            text: i18n("Refresh rate:")
        }

        SpinBox {
            id: refreshRate
            suffix: i18n(" minutes")
            minimumValue: 1
        }

        Label {
            text: ""
        }

        CheckBox {
            id: showBackground
            text: i18n("Show background")
        }

        Label {
            text: i18n("On click:")
        }

        ExclusiveGroup {
            id: clickGroup
        }

        RadioButton {
            Layout.row: 10
            Layout.column: 1
            exclusiveGroup: clickGroup
            checked: cfg_onClickAction == 'refresh'
            text: i18n("Refresh")
            onClicked: {
                cfg_onClickAction = 'refresh'
            }
        }

        RadioButton {
            Layout.row: 11
            Layout.column: 1
            exclusiveGroup: clickGroup
            checked: cfg_onClickAction == 'nothing'
            text: i18n("Do Nothing")
            onClicked: {
                cfg_onClickAction = 'nothing'
            }
        }
    }
}
