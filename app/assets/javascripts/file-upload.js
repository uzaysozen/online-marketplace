function FileListItems (files) {
    let b = new ClipboardEvent("").clipboardData || new DataTransfer();
    for (let i = 0, len = files.length; i < len; i++) b.items.add(files[i]);
    return b.files;
}

addImagePreview = (file, imageNumber) => {
    let container = document.getElementById('images-preview');
    if(container) {
        let preview = document.getElementById('preview_' + imageNumber);
        preview.setAttribute('data-file-name', file.name);
        let image_container = document.getElementById('image_' + imageNumber);
        

        let image = document.createElement('img');
        image.src = URL.createObjectURL(file);
        image_container.style.backgroundImage = "url(" + image.src + ")";
        image_icon = image_container.children[0];
        image_icon.remove();

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
    fileStore = [];
    let el = document.getElementById('listing_images');
    if (el) {
        el.addEventListener('input', (e) => {
            for (let file of el.files) {
                len = fileStore.length
                // Check for max images
                if (len < 8) {
                    if (!fileStore.map(f => f.name).includes(file.name)) {
                        fileStore.unshift(file);
                        addImagePreview(file, len + 1);
                    }
                }
                else {
                    window.notice('Maximum of 8 images per listing');
                    break;
                }
            }
        })
    }

    let form = document.getElementById('new_listing');
    if (form) {
        form.addEventListener('submit', e => {
            console.log(el.files.length);
            el.files = new FileListItems(fileStore);
        })
    }
}

let fileStore = [];

document.addEventListener('turbolinks:load', load);
document.addEventListener('ready', load);
