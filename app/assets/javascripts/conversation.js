load = (loadEvent) => {
    // On page load we want to scroll to the bottom of the messages div.
    let scrollDiv = document.getElementById("messages");
    if (scrollDiv !== null) {
        scrollDiv.scrollTop = scrollDiv.scrollHeight;
    }

    // When we send a new conversation message, we want to clear the input.
    let form = document.getElementById("new_conversation_message");
    if (form) {
        form.addEventListener('ajax:success', (e) => {
            form.reset();
        });
    }
}

document.addEventListener('turbolinks:load', load);