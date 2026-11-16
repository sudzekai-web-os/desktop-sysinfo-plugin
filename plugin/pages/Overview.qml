import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import linctrl
import "../api"
import "../components"
import "../SystemPresentation.js" as Display

ColumnLayout {
    id: root

    spacing: 10
    readonly property var snapshot: client.snapshot

    SysinfoClient { id: client }

    Component.onCompleted: client.refresh()

    RowLayout {
        Layout.fillWidth: true

        AppText {
            Layout.fillWidth: true
            text: "Задержка HTTP: " + Display.latency(client.latencyMs, client.pingError)
            Accessible.description: client.pingError
        }
        DefaultButton {
            id: refresh
            implicitWidth: 36
            horizontalPadding: 8
            enabled: !client.busy
            opacity: enabled ? 1 : 0.48
            Accessible.name: "Обновить сведения о сервере"
            ToolTip.text: Accessible.name
            ToolTip.visible: hovered
            ToolTip.delay: 400
            onClicked: client.refresh()

            contentItem: SystemIcon {
                glyph: Qt.resolvedUrl("../icons/arrow-clockwise.svg")
                color: refresh.enabled ? Theme.palette.ink : Theme.palette.muted
            }
        }
    }

    AppText {
        Layout.fillWidth: true
        visible: text !== ""
        text: client.error || (!root.snapshot && client.busy ? "Получение сведений…" : "")
        textFormat: Text.PlainText
        color: client.error ? Theme.palette.accent : Theme.palette.muted
    }

    ScrollView {
        Layout.fillWidth: true
        Layout.fillHeight: true
        visible: root.snapshot !== null
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            width: parent.width
            spacing: 10

            GridLayout {
                Layout.fillWidth: true
                columns: width >= 620 ? 2 : 1
                columnSpacing: 10
                rowSpacing: 10

                InfoCard {
                    Layout.fillWidth: true
                    Layout.preferredWidth: 1
                    Layout.alignment: Qt.AlignTop
                    title: "Сервер"
                    glyph: Qt.resolvedUrl("../icons/server.svg")

                    InfoField { label: "Название"; value: root.snapshot?.hostName }
                    InfoField { label: "Операционная система"; value: root.snapshot?.operatingSystem }
                    InfoField { label: "Архитектура"; value: root.snapshot?.architecture }
                    InfoField { label: "Время работы"; value: Display.uptime(root.snapshot?.uptimeSeconds) }
                }

                InfoCard {
                    Layout.fillWidth: true
                    Layout.preferredWidth: 1
                    Layout.alignment: Qt.AlignTop
                    title: "Процессор и графика"
                    glyph: Qt.resolvedUrl("../icons/cpu.svg")

                    InfoField { label: "Процессор"; value: root.snapshot?.processor?.name }
                    InfoField { label: "Логических процессоров"; value: root.snapshot?.processor?.logicalProcessors }
                    InfoField {
                        visible: !!root.snapshot?.graphicsAdapters?.length
                        label: "Видеопроцессоры"
                        value: Array.from(root.snapshot?.graphicsAdapters || []).join("\n")
                    }
                }
            }

            InfoCard {
                Layout.fillWidth: true
                title: "Оперативная память"
                glyph: Qt.resolvedUrl("../icons/memory.svg")

                CapacityBar {
                    visible: root.snapshot?.memory != null
                    capacity: root.snapshot?.memory
                }
                AppText {
                    visible: root.snapshot?.memory == null
                    text: "Нет сведений об оперативной памяти."
                    color: Theme.palette.muted
                }
            }

            InfoCard {
                Layout.fillWidth: true
                title: "Локальные диски"
                glyph: Qt.resolvedUrl("../icons/device-hdd.svg")

                Repeater {
                    model: root.snapshot?.storage || []
                    delegate: CapacityBar {
                        required property var modelData

                        label: modelData.name
                        capacity: modelData.capacity
                    }
                }
                AppText {
                    visible: !root.snapshot?.storage?.length
                    text: "Локальные диски не обнаружены."
                    color: Theme.palette.muted
                }
            }
        }
    }
}
