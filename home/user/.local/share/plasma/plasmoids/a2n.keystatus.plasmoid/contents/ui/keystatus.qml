import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import org.kde.plasma.plasmoid 2.0

import "../service" as Sv

Item {
    id: keystatus

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
    Plasmoid.compactRepresentation: Compact {}

    Sv.Cmd { id: cmd }

    Component.onCompleted: {
      console.log("KEYSTATUS -- LAUNCH")
    }
}
