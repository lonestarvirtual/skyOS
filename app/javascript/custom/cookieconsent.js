window.addEventListener('load', function() {
    window.cookieconsent.initialise({
        'content': {
            link: 'Privacy Policy',
            href: '/policy/privacy'
        },
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
        location: false,
    });
});
