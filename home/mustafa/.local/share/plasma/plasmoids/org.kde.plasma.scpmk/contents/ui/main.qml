import QtQuick 2.0
import QtQuick.Controls 2.15
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.1 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

Item {
    id: root

    clip: true

    // PROPERTIES
    property var animationDuration: PlasmaCore.Units.veryShortDuration

    // Main Icon
    property string mainIconName: plasmoid.configuration.mainIconName
    property string mainIconHeight: plasmoid.configuration.mainIconHeight

    // Components
    property bool showCmd1: plasmoid.configuration.showCmd1
    property bool showCmd2: plasmoid.configuration.showCmd2
    property bool showCmd3: plasmoid.configuration.showCmd3
    property bool showCmd4: plasmoid.configuration.showCmd4
    property bool showCmd5: plasmoid.configuration.showCmd5
    property bool showCmd6: plasmoid.configuration.showCmd6
    property bool showCmd7: plasmoid.configuration.showCmd7
    property bool showCmd8: plasmoid.configuration.showCmd8
    property bool showCmd9: plasmoid.configuration.showCmd9
    property bool showCmd10: plasmoid.configuration.showCmd10

    property bool showSep1: plasmoid.configuration.showSep1
    property bool showSep2: plasmoid.configuration.showSep2
    property bool showSep3: plasmoid.configuration.showSep3
    property bool showSep4: plasmoid.configuration.showSep4
    property bool showSep5: plasmoid.configuration.showSep5
    property bool showSep6: plasmoid.configuration.showSep6
    property bool showSep7: plasmoid.configuration.showSep7
    property bool showSep8: plasmoid.configuration.showSep8
    property bool showSep9: plasmoid.configuration.showSep9

    property string cmdRun1: plasmoid.configuration.cmdRun1
    property string cmdTitle1: plasmoid.configuration.cmdTitle1
    property string cmdIcon1: plasmoid.configuration.cmdIcon1

    property string cmdRun2: plasmoid.configuration.cmdRun2
    property string cmdTitle2: plasmoid.configuration.cmdTitle2
    property string cmdIcon2: plasmoid.configuration.cmdIcon2

    property string cmdRun3: plasmoid.configuration.cmdRun3
    property string cmdTitle3: plasmoid.configuration.cmdTitle3
    property string cmdIcon3: plasmoid.configuration.cmdIcon3

    property string cmdRun4: plasmoid.configuration.cmdRun4
    property string cmdTitle4: plasmoid.configuration.cmdTitle4
    property string cmdIcon4: plasmoid.configuration.cmdIcon4

    property string cmdRun5: plasmoid.configuration.cmdRun5
    property string cmdTitle5: plasmoid.configuration.cmdTitle5
    property string cmdIcon5: plasmoid.configuration.cmdIcon5

    property string cmdRun6: plasmoid.configuration.cmdRun6
    property string cmdTitle6: plasmoid.configuration.cmdTitle6
    property string cmdIcon6: plasmoid.configuration.cmdIcon6

    property string cmdRun7: plasmoid.configuration.cmdRun7
    property string cmdTitle7: plasmoid.configuration.cmdTitle7
    property string cmdIcon7: plasmoid.configuration.cmdIcon7

    property string cmdRun8: plasmoid.configuration.cmdRun8
    property string cmdTitle8: plasmoid.configuration.cmdTitle8
    property string cmdIcon8: plasmoid.configuration.cmdIcon8

    property string cmdRun9: plasmoid.configuration.cmdRun9
    property string cmdTitle9: plasmoid.configuration.cmdTitle9
    property string cmdIcon9: plasmoid.configuration.cmdIcon9

    property string cmdRun10: plasmoid.configuration.cmdRun10
    property string cmdTitle10: plasmoid.configuration.cmdTitle10
    property string cmdIcon10: plasmoid.configuration.cmdIcon10

    readonly property bool inPanel: (Plasmoid.location === PlasmaCore.Types.TopEdge
        || Plasmoid.location === PlasmaCore.Types.RightEdge
        || Plasmoid.location === PlasmaCore.Types.BottomEdge
        || Plasmoid.location === PlasmaCore.Types.LeftEdge)

    Plasmoid.preferredRepresentation: plasmoid.compactRepresentation
    Plasmoid.fullRepresentation: FullRepresentation {}
    Plasmoid.compactRepresentation: CompactRepresentation {}
}
