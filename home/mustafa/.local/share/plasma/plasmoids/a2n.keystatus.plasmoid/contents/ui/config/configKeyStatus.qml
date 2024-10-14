import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.20 as Kirigami
import org.kde.kquickcontrols 2.0 as KQuickControls

Kirigami.ScrollablePage {

  id: keyStatusConfigPage

  property alias cfg_debugMode: debugModeBox.checked

  property alias cfg_numCommand: numCommandInput.text
  property alias cfg_numSymbol: numSymbolInput.text

  ColumnLayout {

    anchors {
      left: parent.left
      top: parent.top
      right: parent.right
    }

    Kirigami.InlineMessage {
      Layout.fillWidth: true
      text: "This option enable log for each cmd exec by the plugin. (regex: KEYSTATUS)"
      visible: debugModeBox.checked
    }

    Kirigami.FormLayout {
      wideMode: false

      Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: "General"
      }
    }

    Kirigami.FormLayout {

      Controls.CheckBox {
        id: debugModeBox
        Kirigami.FormData.label: "Debug: "
        checked: false
      }

    }

   Kirigami.FormLayout {
      wideMode: false

      Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: "Command"
      }
    }

    Kirigami.FormLayout {
      wideMode: false

      Controls.TextField {
        id: numCommandInput
        Kirigami.FormData.label: "Detect NUM LOCK command: "
      }

      Controls.TextField {
        id: numSymbolInput
        Kirigami.FormData.label: "Symbol for representing numlock state: "
      }

    }



  }

}
