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

    // Click swap button if swap toast is present
    let flash = document.getElementsByClassName("toast");
    if (flash.length > 0) {
        for (let i = 0; i < flash.length; i++) {
            if (flash[i].innerHTML.includes('Swap')) {
                flash[i].remove();
                let swap_button = document.getElementById("swap-button");
                swap_button.click();
            }
        } 
    }
}

document.addEventListener('turbolinks:load', load);
