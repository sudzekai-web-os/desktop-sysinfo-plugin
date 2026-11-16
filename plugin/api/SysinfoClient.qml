import QtQuick
import linctrl

QtObject {
    id: root

    property var snapshot: null
    property real latencyMs: -1
    readonly property bool busy: information.busy || ping.busy
    readonly property string error: information.error
    readonly property string pingError: ping.error

    property PluginRequest informationRequest: PluginRequest { id: information }
    property PluginRequest pingRequest: PluginRequest { id: ping }

    function refresh() {
        if (busy)
            return

        latencyMs = -1
        const started = Date.now()
        ping.send("GET", "/sysinfo/ping", {}, () => root.latencyMs = Math.max(0, Date.now() - started))
        information.send("GET", "/sysinfo/info", {}, data => root.snapshot = data)
    }
}
