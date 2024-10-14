import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.12
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

RowLayout {
    id: root

    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation
    Plasmoid.backgroundHints: PlasmaCore.Types.ConfigurableBackground

    FontLoader {
    id: acheB
    source: "../fonts/AcherusGrotesque-Bold.ttf"
    }
    FontLoader {
    id: acheEB
    source: "../fonts/couture-bld.otf"
    }

    Layout.minimumHeight: 80
    Layout.minimumWidth: 80
    Layout.preferredWidth: Layout.minimumWidth
    Layout.preferredHeight: Layout.minimumHeight

   	property string porcent: ".2"
    property string porcentreal: ((((porcntRam.text).substring(0, 2)).replace(/\.{1}/g, ""))/100)*.83
    property string command: 'bash $HOME/.local/share/plasma/plasmoids/hermes.observer.ram/contents/ui/lib/get_ram_usage.sh'
   Label {
    id: porcntRam
    visible: false

	text: porcent

	PlasmaCore.DataSource {
		id: executable
		engine: "executable"
		connectedSources: []
		onNewData: {
			var exitCode = data["exit code"]
			var exitStatus = data["exit status"]
			var stdout = data["stdout"]
			var stderr = data["stderr"]
			exited(exitCode, exitStatus, stdout, stderr)
			disconnectSource(sourceName) // cmd finished
		}
		function exec(cmd) {
			connectSource(cmd)
		}
		signal exited(int exitCode, int exitStatus, string stdout, string stderr)
	}

	Connections {
		target: executable
		onExited: {
			porcent = stdout
		}
	}

	Component.onCompleted: {
		var cmd = command
		executable.exec(cmd)
	}
   }

   Item {
       width: parent.height < parent.width ? parent.height : parent.width
       height: parent.height < parent.width ? parent.height : parent.width
       anchors.centerIn: parent

       Rectangle{
           id: mask
           color: "transparent"
           width: parent.height
           height: width
           radius: width/2
           visible: false
           Rectangle {
               id: intofCicle
               anchors.centerIn: parent
               width: parent.width*.65
               height: parent.height*.65
               color: "black"
               radius: width/2
        }
          Rectangle {
               id: rectangleOsMask
               width: parent.width/2
               height: parent.height/3
               color: "black"
               anchors.right: parent.right
               anchors.bottom: parent.bottom
        }
    }
       Rectangle{
           id: mask2
           color: "transparent"
           width: parent.height
           height: width
           radius: width/2
           visible: false
           Rectangle {
               id: intofCicle2
               anchors.centerIn: parent
               width: parent.width*.65
               height: parent.height*.65
               color: "black"
               radius: width/2
        }
    }
       Rectangle {
           id: cicleBse
           anchors.centerIn: parent
           width: parent.height
           height: width
           color: "white"
           opacity: 0.6
           radius: width/2
           layer.enabled: true
             layer.effect: OpacityMask {
             maskSource: mask
             invert: true
             }
    }
Canvas {
        id: progressCanvas
        anchors.centerIn: parent
        width: parent.height
        height: width
        rotation: 180
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            // Dibuja el progreso
            ctx.fillStyle = cicleBse.color;
            ctx.beginPath();
            ctx.moveTo(progressCanvas.width / 2, progressCanvas.height / 2);
            ctx.arc(progressCanvas.width / 2, progressCanvas.height / 2, progressCanvas.width / 2, -Math.PI / 2, (-Math.PI / 2) + (2 * Math.PI * porcentreal));
            ctx.fill();
        }
        layer.enabled: true
             layer.effect: OpacityMask {
             maskSource: mask2
             invert: true
             }
    }
        Column {
            width: parent.width/2
            height: parent.height/3.6
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            spacing: - one.font.pixelSize*.4
            Text {
                anchors.left: parent.left
                anchors.leftMargin: parent.height*.1
                id: one
                color: cicleBse.color
                text: i18n("RAM")
                font.family: acheEB.name
                font.pixelSize: cicleBse.height*.17
                verticalAlignment: Text.AlignBottom
            }
            Text {
                anchors.left: parent.left
                anchors.leftMargin: parent.height*.1
                id: two
                color: cicleBse.color
                text: ((porcntRam.text).substring(0, 2)).replace(/\.{1}/g, "") + "%"
                font.family: acheB.name
                font.pixelSize: one.font.pixelSize*.8
                verticalAlignment: Text.AlignTop
            }

        }
}
   Timer {
		id: timer
		interval: 1000
		running: true
		repeat: true
		onTriggered: {
            var cmd = command
		executable.exec(cmd)
        progressCanvas.requestPaint()
        }
		Component.onCompleted: {
			// Run right away in case the interval is very long.
			triggered()
		}
	}
}
