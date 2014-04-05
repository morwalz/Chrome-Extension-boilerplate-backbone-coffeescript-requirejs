/**
 * Created by sumit1311 on 10/11/13.
 */
({
    baseUrl: "dist/scripts/popup",
    mainConfigFile: 'dist/scripts/popup/popup.js',
    out: "dist/scripts/popup/popup.optimized.js",
    include: 'popup',

    optimize: "uglify",

    uglify: {
        toplevel: true,
        ascii_only: true,
        beautify: false,
        max_line_length: 1000
    },


    inlineText: true,
    useStrict: false,

    skipPragmas: false,
    pragmasOnSave: {
        //Just an example
        excludeCoffeeScript: true
    },

    skipModuleInsertion: false,
    stubModules: ['text'],
    optimizeAllPluginResources: false,
    findNestedDependencies: false,
    removeCombined: false,

    fileExclusionRegExp: /^\./,

    preserveLicenseComments: true,

    logLevel: 0
})