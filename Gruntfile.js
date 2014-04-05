/*jshint camelcase: false*/

'use strict';
var mountFolder = function (connect, dir) {
    return connect.static(require('path').resolve(dir));
};

// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/{,*/}*.js'
// use this if you want to recursively match all subfolders:
// 'test/spec/**/*.js'

module.exports = function (grunt) {
    // show elapsed time at the end
    require('time-grunt')(grunt);
    // load all grunt tasks
    require('load-grunt-tasks')(grunt);

    // configurable paths
    var yeomanConfig = {
        app: 'app',
        dist: 'dist',
        env: 'dev',
        compress_src :  [
            '*.{ico,png,jpg,gif,json}',
            'images/{,*/}*.{png,jpg,gif,ico}',
            '_locales/{,*/}*.json',
            'styles/**',
            'sounds/**',
            'lib/css/bootstrap/bootstrap.custom.css',
            'lib/js/requirejs/require.min.js',
            'scripts/background/background.optimized.js',
            'scripts/popup/popup.optimized.js',
            'scripts/contentscript.js',
            'scripts/extendedscript.js',
            'scripts/options.js',
            'background.html',
            'options.html',
            'popup.html'
        ]
    };

    grunt.initConfig({
        yeoman: yeomanConfig,
        watch: {
            options: {
                spawn: false
            },
            coffee: {
                files: ['<%= yeoman.app %>/scripts/**/*.coffee'],
                tasks: ['coffee:dist']
            },
            coffeeTest: {
                files: ['test/spec/{,*/}*.coffee'],
                tasks: ['coffee:test']
            },
            compass: {
                files: ['<%= yeoman.app %>/styles/{,*/}*.{scss,sass}'],
                tasks: ['compass:server']
            }
        },
        connect: {
            options: {
                port: 9000,
                // change this to '0.0.0.0' to access the server from outside
                hostname: 'localhost'
            },
            test: {
                options: {
                    middleware: function (connect) {
                        return [
                            mountFolder(connect, '.tmp/app'),
                            mountFolder(connect, 'test')
                        ];
                    }
                }
            }
        },
        clean: {
            dist: {
                files: [{
                    dot: true,
                    src: [
                        '.tmp/app',
                        '<%= yeoman.dist %>/*',
                        '!<%= yeoman.dist %>/.git*'
                    ]
                }]
            },
            server: '.tmp/app'
        },
        jshint: {
            options: {
                jshintrc: '.jshintrc'
            },
            all: [
                '<%= yeoman.app %>/scripts/{,*/}*.js',
                'test/spec/{,*/}*.js'
            ]
        },
        mocha: {
            all: {
                options: {
                    run: true,
                    urls: ['http://localhost:<%= connect.options.port %>/index.html']
                }
            }
        },
        coffee: {
            dist: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>/scripts',
                    src: '**/*.coffee',
                    dest: '.tmp/app/scripts',
                    ext: '.js'
                }]
            },
            test: {
                files: [{
                    expand: true,
                    cwd: 'test/spec',
                    src: '**/*.coffee',
                    dest: '.tmp/app/spec',
                    ext: '.js'
                }]
            }
        },
        compass: {
            options: {
                sassDir: '<%= yeoman.app %>/styles',
                cssDir: '.tmp/app/styles',
                generatedImagesDir: '.tmp/app/images/generated',
                imagesDir: '<%= yeoman.app %>/images',
                javascriptsDir: '<%= yeoman.app %>/scripts',
                fontsDir: '<%= yeoman.app %>/styles/fonts',
                importPath: '<%= yeoman.app %>/bower_components',
                httpImagesPath: '/images',
                httpGeneratedImagesPath: '/images/generated',
                relativeAssets: false
            },
            dist: {},
            server: {
                options: {
                    debugInfo: true
                }
            }
        },
        // not used since Uglify task does concat,
        // but still available if needed
        /*concat: {
         dist: {}
         },*/
        // not enabled since usemin task does concat and uglify
        // check index.html to edit your build targets
        // enable this task if you prefer defining your build targets here
        /*uglify: {
         dist: {}
         },*/
        useminPrepare: {
            options: {
                dest: '<%= yeoman.dist %>'
            },
            html: [
                '<%= yeoman.app %>/popup.html',
                '<%= yeoman.app %>/options.html'
            ]
        },
        usemin: {
            options: {
                dirs: ['<%= yeoman.dist %>']
            },
            html: ['<%= yeoman.dist %>/{,*/}*.html'],
            css: ['<%= yeoman.dist %>/styles/{,*/}*.css']
        },
        imagemin: {
            dist: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>/images',
                    src: '{,*/}*.{png,jpg,jpeg}',
                    dest: '<%= yeoman.dist %>/images'
                }]
            }
        },
        svgmin: {
            dist: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>/images',
                    src: '{,*/}*.svg',
                    dest: '<%= yeoman.dist %>/images'
                }]
            }
        },
        cssmin: {
            dist: {
                files: {
                    '<%= yeoman.dist %>/styles/main.css': [
                        '.tmp/app/styles/{,*/}*.css',
                        '<%= yeoman.app %>/styles/{,*/}*.css'
                    ]
                }
            }
        },
        bower: {
            install: {
                options: {
                    targetDir: 'app/lib',
                    layout: 'byType',
                    install: true,
                    verbose: true,
                    cleanTargetDir: false,
                    cleanBowerDir: false,
                    bowerOptions: {}
                }
            }
        },
        htmlmin: {
            dist: {
                options: {
                    /*removeCommentsFromCDATA: true,
                     // https://github.com/yeoman/grunt-usemin/issues/44
                     //collapseWhitespace: true,
                     collapseBooleanAttributes: true,
                     removeAttributeQuotes: true,
                     removeRedundantAttributes: true,
                     useShortDoctype: true,
                     removeEmptyAttributes: true,
                     removeOptionalTags: true*/
                },
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>',
                    src: '*.html',
                    dest: '<%= yeoman.dist %>'
                }]
            }
        },
        // Put files not handled in other tasks here
        copy: {
            dist: {
                files: [{
                    expand: true,
                    dot: true,
                    cwd: '<%= yeoman.app %>',
                    dest: '<%= yeoman.dist %>',
                    src: [
                        '*.{ico,png,jpg,txt}',
                        'images/{,*//*}*.{webp,gif}',
                        '_locales/{,*//*}*.json',
                        'lib*//**',
                        'sounds/**',
                        'scripts/tmpl*//**',
                        'manifest.json'
                    ]
                },
                    {
                    expand: true,
                    dot: true,
                    cwd: '.tmp/app',
                    dest: '<%= yeoman.dist %>',
                    src: '**'
                },
                     {
                        expand: true,
                        dot: true,
                        cwd: '.tmp/app/scripts/config/<%= yeoman.env %>',
                        dest: '<%= yeoman.dist %>/scripts',
                        src: '**'
                 },
                    {
                        expand: true,
                        dot: true,
                        cwd: 'app/manifest/<%= yeoman.env %>',
                        dest: '<%= yeoman.dist %>',
                        src: '**'
                 }]
            },

            build:{
                files: [{
                    expand: true,
                    dot: true,
                    cwd: '<%= yeoman.dist %>',
                    dest: '<%= yeoman.env %>',
                    src: '<%= yeoman.compress_src %>'
                }]
            }

        },
        concurrent: {
            server: [
                'coffee:dist',
                'compass:server'
            ],
            test: [
                'coffee',
                'compass'
            ],
            dist: [
                'coffee',
                'compass:dist',
                'imagemin',
                'svgmin',
                'htmlmin'
            ]
        },
        chromeManifest: {
            dist: {
                options: {
                    buildnumber: true
                },
                src: '<%= yeoman.app %>/manifest/<%= yeoman.env %>',
                dest: '<%= yeoman.app %>/manifest/<%= yeoman.env %>'
            }
        },
        compress: {
            dist: {
                options: {
                    archive: 'package/HelloWorld-<%= yeoman.env %>.zip'
                },
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.env %>/',
                    src: '**',
                    dest: ''
                }]
            }
        },
        crx: {
            myHostedPackage: {
                src: '<%= yeoman.env %>',
                dest: 'package/HelloWorld-<%= yeoman.env %>.crx',
                privateKey: 'key.pem',
                options: {
                    maxBuffer: 3000 * 1024 //build extension with a weight up to 3MB
                }
            }
        }
    });

    grunt.registerTask('config', 'Upload code to specified target.', function(n) {
        var target = grunt.option('target');
        console.log('Target env : ' + target);
        if(target)
        {
            yeomanConfig.env = target;
            console.log('Configuring build env --> ' + yeomanConfig.env)
        }

    });

    grunt.registerTask('test', [
        'clean:server',
        'concurrent:test',
        'connect:test',
        'mocha'
    ]);

    grunt.registerTask('build', [
        'clean:dist',
        'useminPrepare',
        'concurrent:dist',
        'cssmin',
        'concat',
        'uglify',
        'copy:dist',
        'usemin'
    ]);

    grunt.registerTask('default', [
        'jshint',
        'test',
        'build'
    ]);

    grunt.registerTask('update-build-version', [
        'config',
        'chromeManifest'
    ]);

    grunt.registerTask('publish', [
        'config',
        'copy:build',
        'compress',
        'crx'
    ]);

    grunt.registerTask('prepare', [
        'config',
        'build'
    ]);
};
