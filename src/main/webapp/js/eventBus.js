
var events = {};

$.EventBus = function(id) {
    var callbacks;
    var event = id && events[id];
    if (!event) {
        callbacks = $.Callbacks();
        event = {
            publish: callbacks.fire,
            subscribe: callbacks.add,
            unsubscribe: callbacks.remove
        };
        if (id) {
            events[id] = event;
        }
    }
    return event;
};
