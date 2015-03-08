Polymer 'timer-button',
    msgMap:
        'en':
            ticking: "Re-send after %ss"
        'zh':
            ticking: "%s秒后重发"

    oriLabel: ""
    interval: 60

    ready: () ->
        `this.super()`
        @M = @msgMap[window.lang]

    upAction: () ->
        `this.super()`
        @oriLabel = this.innerHTML
        @interval = @disableInterval
        this.disabled = true
        this.async(@updateLabel, this, 1000)

    updateLabel: () ->
        @interval -= 1
        if @interval > 0
            this.innerHTML = @M.ticking.format(@interval)
            this.async(@updateLabel, this, 1000)
        else
            this.innerHTML = @oriLabel
            this.disabled = false
