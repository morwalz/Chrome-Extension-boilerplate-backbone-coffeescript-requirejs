(function (zepto) {
    console.log('inside jquery');
    window.$ = window.jQuery = zepto;
    return zepto;
})(Zepto);