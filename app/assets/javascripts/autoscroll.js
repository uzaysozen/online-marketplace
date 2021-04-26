load = (loadEvent) => {
    let scrollDiv = document.getElementById("messages");
    if (scrollDiv !== null) {
        scrollDiv.scrollTop = scrollDiv.scrollHeight;
    }

    let form = document.getElementById("new_conversation_message");
    if (form) {
        form.addEventListener('ajax:success', (e) => {
            form.reset();
        });
    }
}

document.addEventListener('turbolinks:load', load);