// External upload transport for the signed archive scenario. The server owns
// the URL and object key; entries report progress back through LiveView.
export const FlightArchive = (entries, onViewError) => {
  entries.forEach(entry => {
    const request = new XMLHttpRequest()
    let finished = false
    const fail = () => {
      if (finished) return
      finished = true
      entry.error()
    }

    onViewError(() => {
      if (!finished) request.abort()
    })
    entry.onDone(() => {
      if (!finished) {
        finished = true
        request.abort()
      }
    })
    request.open("PUT", entry.meta.url, true)
    request.setRequestHeader("Content-Type", "application/octet-stream")
    request.upload.addEventListener("progress", event => {
      if (event.lengthComputable && !finished) {
        // 100 means the archive accepted the object, not just that bytes left.
        entry.progress(Math.min(99, Math.round(event.loaded / event.total * 100)))
      }
    })
    request.addEventListener("load", () => {
      if (finished) return
      if (request.status >= 200 && request.status < 300) {
        finished = true
        entry.progress(100)
      } else {
        fail()
      }
    })
    request.addEventListener("error", fail)
    request.addEventListener("timeout", fail)
    request.addEventListener("abort", fail)
    request.timeout = 60000
    request.send(entry.file)
  })
}
