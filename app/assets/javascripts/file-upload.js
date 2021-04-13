function FileListItems (files) {
    let b = new ClipboardEvent("").clipboardData || new DataTransfer();
    for (let i = 0, len = files.length; i < len; i++) b.items.add(files[i]);
    return b.files;
}

addImagePreview = (file) => {
    let container = document.getElementById('images-preview');
    if(container) {
        let preview = document.createElement('div');
        preview.classList.add('col-4');
        preview.classList.add('preview');
        preview.setAttribute('data-file-name', file.name);

        let image_container = document.createElement('div');
        image_container.classList.add('image-container');
        preview.append(image_container);

        let image = document.createElement('img');
        image.src = URL.createObjectURL(file);
        image_container.append(image);

        let delete_button = document.createElement('span');
        delete_button.classList.add('delete-btn');
        delete_button.addEventListener('click', e => removeImagePreview(file.name));
        preview.append(delete_button)

        container.append(preview)
    }
}

removeImagePreview = (fileName) => {
    let el = document.querySelector(`[data-file-name="${fileName}"]`);
    el.remove();
    fileStore = fileStore.filter(f => f.name !== fileName);
}


load = (loadEvent) => {
    fileStore = [];
    let el = document.getElementById('listing_images');
    if (el) {
        el.addEventListener('input', (e) => {
            for (let file of el.files) {
                if (!fileStore.map(f => f.name).includes(file.name)) {
                    fileStore.unshift(file);
                    addImagePreview(file);
                }
            }
        })
    }

    let form = document.getElementById('new_listing');
    if (form) {
        form.addEventListener('submit', e => {
            el.files = new FileListItems(fileStore);
        })
    }
}

let fileStore = [];

document.addEventListener('turbolinks:load', load);
document.addEventListener('ready', load);
