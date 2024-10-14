import QtQml 2.0
import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.kquickcontrolsaddons 2.0 as KQuickAddons
import "../components" as Components

ColumnLayout {
    property alias cfg_mainIconName: mainIconName.icon.name

    property alias cfg_width: widthSpinBox.value
    property alias cfg_height: heightSpinBox.value

    property alias cfg_showCmd1: showCmd1.checked
    property alias cfg_showCmd2: showCmd2.checked
    property alias cfg_showCmd3: showCmd3.checked
    property alias cfg_showCmd4: showCmd4.checked
    property alias cfg_showCmd5: showCmd5.checked
    property alias cfg_showCmd6: showCmd6.checked
    property alias cfg_showCmd7: showCmd7.checked
    property alias cfg_showCmd8: showCmd8.checked
    property alias cfg_showCmd9: showCmd9.checked
    property alias cfg_showCmd10: showCmd10.checked

    property alias cfg_showSep1: showSep1.checked
    property alias cfg_showSep2: showSep2.checked
    property alias cfg_showSep3: showSep3.checked
    property alias cfg_showSep4: showSep4.checked
    property alias cfg_showSep5: showSep5.checked
    property alias cfg_showSep6: showSep6.checked
    property alias cfg_showSep7: showSep7.checked
    property alias cfg_showSep8: showSep8.checked
    property alias cfg_showSep9: showSep9.checked

    property alias cfg_cmdIcon1: cmdIcon1.icon.name
    property alias cfg_cmdRun1: cmdRun1.text
    property alias cfg_cmdTitle1: cmdTitle1.text

    property alias cfg_cmdIcon2: cmdIcon2.icon.name
    property alias cfg_cmdRun2: cmdRun2.text
    property alias cfg_cmdTitle2: cmdTitle2.text

    property alias cfg_cmdIcon3: cmdIcon3.icon.name
    property alias cfg_cmdRun3: cmdRun3.text
    property alias cfg_cmdTitle3: cmdTitle3.text

    property alias cfg_cmdIcon4: cmdIcon4.icon.name
    property alias cfg_cmdRun4: cmdRun4.text
    property alias cfg_cmdTitle4: cmdTitle4.text

    property alias cfg_cmdIcon5: cmdIcon5.icon.name
    property alias cfg_cmdRun5: cmdRun5.text
    property alias cfg_cmdTitle5: cmdTitle5.text

    property alias cfg_cmdIcon6: cmdIcon6.icon.name
    property alias cfg_cmdRun6: cmdRun6.text
    property alias cfg_cmdTitle6: cmdTitle6.text

    property alias cfg_cmdIcon7: cmdIcon7.icon.name
    property alias cfg_cmdRun7: cmdRun7.text
    property alias cfg_cmdTitle7: cmdTitle7.text

    property alias cfg_cmdIcon8: cmdIcon8.icon.name
    property alias cfg_cmdRun8: cmdRun8.text
    property alias cfg_cmdTitle8: cmdTitle8.text

    property alias cfg_cmdIcon9: cmdIcon9.icon.name
    property alias cfg_cmdRun9: cmdRun9.text
    property alias cfg_cmdTitle9: cmdTitle9.text

    property alias cfg_cmdIcon10: cmdIcon10.icon.name
    property alias cfg_cmdRun10: cmdRun10.text
    property alias cfg_cmdTitle10: cmdTitle10.text

    // Used to select icons
    KQuickAddons.IconDialog {
        id: iconDialog
        property var iconObj

        onIconNameChanged: iconObj.name = iconName

    }
    RowLayout {
            Label {
                text: i18n("Main Icon :")
            }
            Button {
                id: mainIconName
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= mainIconName.icon
                }
            }
        }
    RowLayout {
            Label {
                text: i18n("Widget Size px: W: ")
            }
            SpinBox {
                id: widthSpinBox
                from: 0
                to: 2147483647 // 2^31-1
            }
            Label {
                text: i18n(" H: ")
            }
            SpinBox {
                id: heightSpinBox
                from: 0
                to: 2147483647 // 2^31-1
            }
        }
    Components.BottomSeparator{
                visible: true
            }
    RowLayout {
        Label {
            text: i18n("Show Menu Item 1")
            color: showCmd1.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showCmd1
        }
        Label {
            text: i18n("Show Bottom Separator")
            color: showSep1.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showSep1
        }
    }
    ColumnLayout {
        Layout.leftMargin: PlasmaCore.Units.largeSpacing
        visible: showCmd1.checked
        RowLayout {
            Label {
                text: i18n("Icon :")
            }
            Button {
                id: cmdIcon1
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= cmdIcon1.icon
                }
            }
        }
        RowLayout {
            Label {
                text: i18n("Item :")
            }
            TextField {
                id: cmdTitle1
                placeholderText: i18n("System Settings")
                Layout.fillWidth: true
            }
        }
        RowLayout {
            Label {
                text: i18n("Command :")
            }
            TextField {
                id: cmdRun1
                placeholderText: i18n("systemsettings")
                Layout.fillWidth: true
            }
        }
    }
    Components.BottomSeparator{
                visible: true
            }
    RowLayout {
        Label {
            text: i18n("Show Menu Item 2")
            color: showCmd2.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showCmd2
        }
        Label {
            text: i18n("Show Bottom Separator")
            color: showSep2.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showSep2
        }
    }
    ColumnLayout {
        Layout.leftMargin: PlasmaCore.Units.largeSpacing
        visible: showCmd2.checked
        RowLayout {
            Label {
                text: i18n("Icon :")
            }
            Button {
                id: cmdIcon2
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= cmdIcon2.icon
                }
            }
        }
        RowLayout {
            Label {
                text: i18n("Item :")
            }
            TextField {
                id: cmdTitle2
                placeholderText: i18n("Discover")
                Layout.fillWidth: true
            }
        }
        RowLayout {
            Label {
                text: i18n("Command :")
            }
            TextField {
                id: cmdRun2
                placeholderText: i18n("plasma-discover")
                Layout.fillWidth: true
            }
        }
    }
    Components.BottomSeparator{
                visible: true
            }
    RowLayout {
        Label {
            text: i18n("Show Menu Item 3")
            color: showCmd3.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showCmd3
        }
        Label {
            text: i18n("Show Bottom Separator")
            color: showSep3.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showSep3
        }
    }
    ColumnLayout {
        Layout.leftMargin: PlasmaCore.Units.largeSpacing
        visible: showCmd3.checked
        RowLayout {
            Label {
                text: i18n("Icon :")
            }
            Button {
                id: cmdIcon3
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= cmdIcon3.icon
                }
            }
        }
        RowLayout {
            Label {
                text: i18n("Item :")
            }
            TextField {
                id: cmdTitle3
                placeholderText: i18n("Lock Screen")
                Layout.fillWidth: true
            }
        }
        RowLayout {
            Label {
                text: i18n("Command :")
            }
            TextField {
                id: cmdRun3
                placeholderText: i18n("qdbus org.freedesktop.ScreenSaver /ScreenSaver Lock")
                Layout.fillWidth: true
            }
        }
    }
    Components.BottomSeparator{
                visible: true
            }
    RowLayout {
        Label {
            text: i18n("Show Menu Item 4")
            color: showCmd4.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showCmd4
        }
        Label {
            text: i18n("Show Bottom Separator")
            color: showSep4.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showSep4
        }
    }
    ColumnLayout {
        Layout.leftMargin: PlasmaCore.Units.largeSpacing
        visible: showCmd4.checked
        RowLayout {
            Label {
                text: i18n("Icon :")
            }
            Button {
                id: cmdIcon4
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= cmdIcon4.icon
                }
            }
        }
        RowLayout {
            Label {
                text: i18n("Item :")
            }
            TextField {
                id: cmdTitle4
                placeholderText: i18n("Log Out")
                Layout.fillWidth: true
            }
        }
        RowLayout {
            Label {
                text: i18n("Command :")
            }
            TextField {
                id: cmdRun4
                placeholderText: i18n("qdbus org.kde.ksmserver /KSMServer logout 0 0 0")
                Layout.fillWidth: true
            }
        }
    }
    Components.BottomSeparator{
                visible: true
            }
    RowLayout {
        Label {
            text: i18n("Show Menu Item 5")
            color: showCmd5.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showCmd5
        }
        Label {
            text: i18n("Show Bottom Separator")
            color: showSep5.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showSep5
        }
    }
    ColumnLayout {
        Layout.leftMargin: PlasmaCore.Units.largeSpacing
        visible: showCmd5.checked
        RowLayout {
            Label {
                text: i18n("Icon :")
            }
            Button {
                id: cmdIcon5
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= cmdIcon5.icon
                }
            }
        }
        RowLayout {
            Label {
                text: i18n("Item :")
            }
            TextField {
                id: cmdTitle5
                placeholderText: i18n("Sleep")
                Layout.fillWidth: true
            }
        }
        RowLayout {
            Label {
                text: i18n("Command :")
            }
            TextField {
                id: cmdRun5
                placeholderText: i18n("systemctl suspend")
                Layout.fillWidth: true
            }
        }
    }
    Components.BottomSeparator{
                visible: true
            }
    RowLayout {
        Label {
            text: i18n("Show Menu Item 6")
            color: showCmd6.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showCmd6
        }
        Label {
            text: i18n("Show Bottom Separator")
            color: showSep6.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showSep6
        }
    }
    ColumnLayout {
        Layout.leftMargin: PlasmaCore.Units.largeSpacing
        visible: showCmd6.checked
        RowLayout {
            Label {
                text: i18n("Icon :")
            }
            Button {
                id: cmdIcon6
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= cmdIcon6.icon
                }
            }
        }
        RowLayout {
            Label {
                text: i18n("Item :")
            }
            TextField {
                id: cmdTitle6
                placeholderText: i18n("Restart")
                Layout.fillWidth: true
            }
        }
        RowLayout {
            Label {
                text: i18n("Command :")
            }
            TextField {
                id: cmdRun6
                placeholderText: i18n("/sbin/reboot")
                Layout.fillWidth: true
            }
        }
    }
    Components.BottomSeparator{
                visible: true
            }
    RowLayout {
        Label {
            text: i18n("Show Menu Item 7")
            color: showCmd7.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showCmd7
        }
        Label {
            text: i18n("Show Bottom Separator")
            color: showSep7.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showSep7
        }
    }
    ColumnLayout {
        Layout.leftMargin: PlasmaCore.Units.largeSpacing
        visible: showCmd7.checked
        RowLayout {
            Label {
                text: i18n("Icon :")
            }
            Button {
                id: cmdIcon7
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= cmdIcon7.icon
                }
            }
        }
        RowLayout {
            Label {
                text: i18n("Item :")
            }
            TextField {
                id: cmdTitle7
                placeholderText: i18n("Shut Down")
                Layout.fillWidth: true
            }
        }
        RowLayout {
            Label {
                text: i18n("Command :")
            }
            TextField {
                id: cmdRun7
                placeholderText: i18n("/sbin/shutdown now")
                Layout.fillWidth: true
            }
        }
    }
    Components.BottomSeparator{
                visible: true
            }
    RowLayout {
        Label {
            text: i18n("Show Menu Item 8")
            color: showCmd8.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showCmd8
        }
        Label {
            text: i18n("Show Bottom Separator")
            color: showSep8.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showSep8
        }
    }
    ColumnLayout {
        Layout.leftMargin: PlasmaCore.Units.largeSpacing
        visible: showCmd8.checked
        RowLayout {
            Label {
                text: i18n("Icon :")
            }
            Button {
                id: cmdIcon8
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= cmdIcon8.icon
                }
            }
        }
        RowLayout {
            Label {
                text: i18n("Item :")
            }
            TextField {
                id: cmdTitle8
                placeholderText: i18n("Custom Item")
                Layout.fillWidth: true
            }
        }
        RowLayout {
            Label {
                text: i18n("Command :")
            }
            TextField {
                id: cmdRun8
                placeholderText: i18n("Custom Command")
                Layout.fillWidth: true
            }
        }
    }
    Components.BottomSeparator{
                visible: true
            }
    RowLayout {
        Label {
            text: i18n("Show Menu Item 9")
            color: showCmd9.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showCmd9
        }
        Label {
            text: i18n("Show Bottom Separator")
            color: showSep9.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showSep9
        }
    }
    ColumnLayout {
        Layout.leftMargin: PlasmaCore.Units.largeSpacing
        visible: showCmd9.checked
        RowLayout {
            Label {
                text: i18n("Icon :")
            }
            Button {
                id: cmdIcon9
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= cmdIcon9.icon
                }
            }
        }
        RowLayout {
            Label {
                text: i18n("Item :")
            }
            TextField {
                id: cmdTitle9
                placeholderText: i18n("Custom Item")
                Layout.fillWidth: true
            }
        }
        RowLayout {
            Label {
                text: i18n("Command :")
            }
            TextField {
                id: cmdRun9
                placeholderText: i18n("Custom Command")
                Layout.fillWidth: true
            }
        }
    }
    Components.BottomSeparator{
                visible: true
            }
    RowLayout {
        Label {
            text: i18n("Show Menu Item 10")
            color: showCmd10.enabled ? PlasmaCore.Theme.textColor : PlasmaCore.Theme.disabledTextColor
        }
        CheckBox {
            id: showCmd10
        }
    }
    ColumnLayout {
        Layout.leftMargin: PlasmaCore.Units.largeSpacing
        visible: showCmd10.checked
        RowLayout {
            Label {
                text: i18n("Icon :")
            }
            Button {
                id: cmdIcon10
                onClicked: {
                    iconDialog.open()
                    iconDialog.iconObj= cmdIcon10.icon
                }
            }
        }
        RowLayout {
            Label {
                text: i18n("Item :")
            }
            TextField {
                id: cmdTitle10
                placeholderText: i18n("Custom Item")
                Layout.fillWidth: true
            }
        }
        RowLayout {
            Label {
                text: i18n("Command :")
            }
            TextField {
                id: cmdRun10
                placeholderText: i18n("Custom Command")
                Layout.fillWidth: true
            }
        }
    }
    Item {
        Layout.fillHeight: true
    }
}

