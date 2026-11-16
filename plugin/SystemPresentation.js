.pragma library

function bytes(value) {
    if (!Number.isFinite(value) || value < 0)
        return "—"

    const units = ["Б", "КиБ", "МиБ", "ГиБ", "ТиБ", "ПиБ"]
    let unit = 0
    while (value >= 1024 && unit < units.length - 1) {
        value /= 1024
        unit++
    }

    return Number(value.toFixed(unit === 0 ? 0 : 1)).toLocaleString(Qt.locale(), "f", unit === 0 ? 0 : 1) + " " + units[unit]
}

function uptime(seconds) {
    if (!Number.isSafeInteger(seconds) || seconds < 0)
        return "—"

    const days = Math.floor(seconds / 86400)
    const hours = Math.floor(seconds / 3600) % 24
    const minutes = Math.floor(seconds / 60) % 60
    if (days)
        return days + " д " + hours + " ч " + minutes + " мин"
    if (hours)
        return hours + " ч " + minutes + " мин"
    return minutes ? minutes + " мин" : seconds + " с"
}

function latency(milliseconds, error) {
    if (milliseconds < 0)
        return error ? "Нет ответа" : "—"

    return milliseconds === 0 ? "Менее 1 мс" : milliseconds + " мс"
}
