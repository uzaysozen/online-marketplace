// This function let's us create a new FileList from an array of files which is not yet directly supported.
function FileListItems (files) {
    let b = new ClipboardEvent("").clipboardData || new DataTransfer();
    for (let i = 0, len = files.length; i < len; i++) b.items.add(files[i]);
    return b.files;
}

addImagePreview = (file, imageNumber) => {
    // Ensure the image container exists.
    let container = document.getElementById('images-preview');
    if(container) {
        // Get the preview container for the next image.
        let preview = document.getElementById('preview_' + imageNumber);
        preview.setAttribute('data-file-name', file.name);
        let image_container = document.getElementById('image_' + imageNumber);

        // Add the image as a background image to the container we got above.
        let image = document.createElement('img');
        image.src = URL.createObjectURL(file);
        image_container.style.backgroundImage = "url(" + image.src + ")";
        image_icon = image_container.children[0];
        image_icon.remove();

        // Create a delete button to remove the image preview.
        let delete_button = document.createElement('span');
        delete_button.classList.add('delete-btn');
        delete_button.setAttribute('del-btn-name', file.name);
        delete_button.addEventListener('click', e => removeImagePreview(file.name));
        preview.append(delete_button);
    }
}

removeImagePreview = (fileName) => {
    // Remove preview of image
    let el = document.querySelector(`[data-file-name="${fileName}"]`);
    el.remove();
    fileStore = fileStore.filter(f => f.name !== fileName);

    // Create default image square
    let preview = document.createElement('div');
    preview.className = 'col-4 preview';
    let image_container = document.createElement('div');
    image_container.className = 'image-container';
    image_container.id = 'image_8';
    let image_icon = document.createElement('div');
    image_icon.className = 'far fa-image placeholder';
    image_container.append(image_icon);
    preview.append(image_container);

    // Add to container
    let container = document.getElementById('images-preview');
    container.append(preview);

    // Change id
    let counter = 1
    for (let child of container.children) {
        // Find current id number
        current_id = child.id.split("_").pop();
        // Update id number
        child.id = 'preview_' + counter;
        image = document.getElementById('image_' + current_id);
        if (image) image.id = 'image_' + counter;
        counter++;
    }
}


load = (loadEvent) => {
    // Create array for storing files and ensure our images container exists.
    fileStore = [];
    let el = document.getElementById('listing_images');
    if (el) {
        el.addEventListener('input', (e) => {
            for (let file of el.files) {
                len = fileStore.length
                // Check for max images
                if (len < 8) {
                    // Ensure the user is not adding the same file again.
                    if (!fileStore.map(f => f.name).includes(file.name)) {
                        // Add the file to the end of the array and add the preview to DOM.
                        fileStore.unshift(file);
                        addImagePreview(file, len + 1);
                    }
                }
                else {
                    // This creates a custom bootstrap notice of our own using the function in notifications.coffee
                    window.notice('Maximum of 8 images per listing');
                    // Break the loop since we've already reached the limit
                    break;
                }
            }
        })
    }

    // Ensure the form exists.
    let form = document.getElementById('new_listing');
    if (form) {
        // On form submit we need to update the files in the pseudo input from our file array.
        form.addEventListener('submit', e => {
            console.log(el.files.length);
            el.files = new FileListItems(fileStore);
        })
    }
}

// Declare fileStore array here so it can be easily accessed.
let fileStore = [];

document.addEventListener('turbolinks:load', load);
document.addEventListener('ready', load);
