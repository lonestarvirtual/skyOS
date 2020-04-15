window.addEventListener('load', function() {
    window.cookieconsent.initialise({
        'palette': {
            'popup': {
                'background': '#000'
            },
            'button': {
                'background': '#f1d600'
            }
        },
        law: {
            regionalLaw: false,
        },
        location: true,
    });
});
