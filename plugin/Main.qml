import QtQuick
import QtQuick.Layouts
import linctrl
import "pages"

ColumnLayout {
    anchors.fill: parent
    anchors.margins: 24
    spacing: 12

    SectionHeading {
        Layout.fillWidth: true
        title: "Сведения о сервере"
    }

    AppText {
        visible: !AccountSession.authenticated
        text: "Войдите на сервер, чтобы посмотреть сведения."
    }

    Loader {
        Layout.fillWidth: true
        Layout.fillHeight: true
        active: AccountSession.authenticated
        sourceComponent: Overview {}
    }
}
