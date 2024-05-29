import QtQuick 2.15
import QtQuick.Window 2.0
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.workspace.components 2.0 as WorkspaceComponents

Item {
  id: row

  property bool debug: false
  property string numStatus: "*"

  function checkKey() {
    cmd.exec("xset -q | sed -n 's/^.*Num Lock:\\s*\\(\\S*\\).*$/\\1/p'")
  }

  Timer {
    id: timer
    interval: 500 // milisecond
    running: true
    repeat: true
    triggeredOnStart: true // trigger on start for a first checkind
    onTriggered: checkKey()
  }

  // map the cmd signal with the widget
  Connections {
    target: cmd

    function onConnected(source) {
      if (debug) console.log('KEYSTATUS - cmd connected: ', source)
    }

    function onExited(cmd, exitCode, exitStatus, stdout, stderr) {
      if (debug) console.log('KEYSTATUS - cmd exited: ', JSON.stringify({cmd, exitCode, exitStatus, stdout, stderr}))
      numStatus = stdout
    }
  }

 Item {
  id: container
  height: row.itemSize
  width: height

  anchors.centerIn: parent

  Label {
    id: label
    text: "#"
    opacity: numStatus === "on\n" ? 1 : .3
    anchors.centerIn: parent
    font.pixelSize: 20
  }
 }

}
