function getData(xeUrl, callback) {
    if (typeof xeUrl === 'undefined')
        xeUrl = 'https://nasserver.herokuapp.com/RichTextViewerPlasmoid/Hello';
    if (xeUrl === null)
        return false;

    var xhr                = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        callback(xhr.responseText);
    };
    xhr.open('GET', xeUrl, true);
    xhr.send();

    return true;
}

