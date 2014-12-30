'use strict';
var LIVERELOAD_PORT = 35729;
var lrSnippet = require('connect-livereload')({
    port: LIVERELOAD_PORT
});
var mountFolder = function(connect, dir) {
    return connect.static(require('path').resolve(dir));
};

// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/{,*/}*.js'
// use this if you want to match all subfolders:
// 'test/spec/**/*.js'

module.exports = function(grunt) {
    // show elapsed time at the end
    require('time-grunt')(grunt);
    // load all grunt tasks
    require('load-grunt-tasks')(grunt);

    // configurable paths
    var yeomanConfig = {
        app: 'app',
        dist: 'dist'
    };

    grunt.initConfig({
        yeoman: yeomanConfig,
        watch: {
            options: {
                nospawn: true,
                livereload: {
                    liveCSS: false
                }
            },
            livereload: {
                options: {
                    livereload: true
                },
                files: [
                    '<%= yeoman.app %>/*.html',
                    '<%= yeoman.app %>/elements/{,*/,*/*/,*/*/*/}*.html',
                    '{.tmp,<%= yeoman.app %>}/elements/{,*/,*/*/,*/*/*/}*.css',
                    '{.tmp,<%= yeoman.app %>}/elements/{,*/,*/*/,*/*/*/}*.js',
                    '{.tmp,<%= yeoman.app %>}/styles/{,*/,*/*/,*/*/*/}*.css',
                    '{.tmp,<%= yeoman.app %>}/scripts/{,*/,*/*/,*/*/*/}*.js',
                    '<%= yeoman.app %>/images/{,*/,*/*/,*/*/*/}*.{png,jpg,jpeg,gif,webp}'
                ]
            },
            js: {
                files: ['<%= yeoman.app %>/scripts/{,*/,*/*/,*/*/*/}*.js'],
                tasks: ['copy:scripts', 'jshint']
            },
            coffee: {
                files: [
                    '<%= yeoman.app %>/scripts/{,*/,*/*/,*/*/*/}*.coffee',
                    '<%= yeoman.app %>/elements/{,*/,*/*/,*/*/*/}*.coffee'
                ],
                tasks: ['coffee:server', 'copy:scripts', 'jshint']
            },
            styles: {
                files: [
                    '<%= yeoman.app %>/styles/{,*/,*/*/,*/*/*/}*.css',
                    '<%= yeoman.app %>/elements/{,*/,*/*/,*/*/*/}*.css'
                ],
                tasks: ['copy:styles', 'autoprefixer:server']
            },
            sass: {
                files: [
                    '<%= yeoman.app %>/styles/{,*/,*/*/,*/*/*/}*.{scss,sass}',
                    '<%= yeoman.app %>/elements/{,*/,*/*/,*/*/*/}*.{scss,sass}'
                ],
                tasks: ['sass:server', 'autoprefixer:server']
            }
        },
        // Compile coffee scripts to js
        coffee: {
            options: {
                bare: false,
                join: false
            },
            dist: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>',
                    src: ['scripts/{,*/,*/*/,*/*/*/}*.coffee', 'elements/{,*/,*/*/,*/*/*/}*.coffee'],
                    dest: '<%= yeoman.dist %>',
                    ext: '.js'
                }]
            },
            server: {
                options: {
                    sourceMap: true
                },
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>',
                    src: ['scripts/{,*/,*/*/,*/*/*/}*.coffee', 'elements/{,*/,*/*/,*/*/*/}*.coffee'],
                    dest: '.tmp',
                    ext: '.js'
                }]
            }
        },
        // Compiles Sass to CSS and generates necessary files if requested
        sass: {
            options: {
                loadPath: 'bower_components'
            },
            dist: {
                options: {
                    style: 'compressed'
                },
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>',
                    src: ['styles/{,*/,*/*/,*/*/*/}*.{scss,sass}', 'elements/{,*/,*/*/,*/*/*/}*.{scss,sass}'],
                    dest: '<%= yeoman.dist %>',
                    ext: '.css'
                }]
            },
            server: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>',
                    src: ['styles/{,*/,*/*/,*/*/*/}*.{scss,sass}', 'elements/{,*/,*/*/,*/*/*/}*.{scss,sass}'],
                    dest: '.tmp',
                    ext: '.css'
                }]
            }
        },
        autoprefixer: {
            options: {
                browsers: ['last 2 versions']
            },
            server: {
                files: [{
                    expand: true,
                    cwd: '.tmp',
                    src: '**/*.css',
                    dest: '.tmp'
                }]
            },
            dist: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.dist %>',
                    src: ['**/*.css', '!bower_components/**/*.css'],
                    dest: '<%= yeoman.dist %>'
                }]
            }
        },
        connect: {
            options: {
                port: 9000,
                // change this to '0.0.0.0' to access the server from outside
                hostname: '0.0.0.0'
            },
            livereload: {
                options: {
                    middleware: function(connect) {
                        return [
                            lrSnippet,
                            mountFolder(connect, '.tmp'),
                            mountFolder(connect, yeomanConfig.app)
                        ];
                    }
                }
            },
            test: {
                options: {
                    open: {
                        target: 'http://localhost:<%= connect.options.port %>/test'
                    },
                    middleware: function(connect) {
                        return [
                            mountFolder(connect, yeomanConfig.app)
                        ];
                    },
                    keepalive: true
                }
            },
            dist: {
                options: {
                    middleware: function(connect) {
                        return [
                            mountFolder(connect, yeomanConfig.dist)
                        ];
                    }
                }
            }
        },
        open: {
            server: {
                path: 'http://localhost:<%= connect.options.port %>'
            }
        },
        clean: {
            dist: ['.tmp', '<%= yeoman.dist %>/*'],
            server: '.tmp'
        },
        jshint: {
            options: {
                jshintrc: '.jshintrc',
                reporter: require('jshint-stylish')
            },
            all: [
                '<%= yeoman.app %>/scripts/{,*/,*/*/,*/*/*/}*.js',
                '!<%= yeoman.app %>/scripts/vendor/*',
                'test/spec/{,*/}*.js'
            ]
        },
        useminPrepare: {
            html: '<%= yeoman.app %>/index.html',
            options: {
                dest: '<%= yeoman.dist %>'
            }
        },
        usemin: {
            html: ['<%= yeoman.dist %>/{,*/,*/*/,*/*/*/}*.html'],
            css: ['<%= yeoman.dist %>/styles/{,*/,*/*/,*/*/*/}*.css'],
            options: {
                dirs: ['<%= yeoman.dist %>'],
                blockReplacements: {
                    vulcanized: function(block) {
                        return '<link rel="import" href="' + block.dest + '">';
                    }
                }
            }
        },
        vulcanize: {
            default: {
                options: {
                    strip: true,
                    inline: true
                },
                files: {
                    '<%= yeoman.dist %>/vulcanized.html': [
                        '<%= yeoman.dist %>/elements/the-app.html'
                    ]
                }
            }
        },
        imagemin: {
            dist: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>/images',
                    src: '{,*/,*/*/,*/*/*/}*.{png,jpg,jpeg}',
                    dest: '<%= yeoman.dist %>/images'
                }]
            }
        },
        minifyHtml: {
            options: {
                comments: false,
                conditionals: true,
                spare: true,
                quotes: true,
                loose: true,
                empty: true
            },
            dist: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.dist %>',
                    src: '*.html',
                    dest: '<%= yeoman.dist %>'
                }]
            }
        },
        copy: {
            dist: {
                files: [{
                    expand: true,
                    dot: true,
                    cwd: '<%= yeoman.app %>',
                    dest: '<%= yeoman.dist %>',
                    src: [
                        '*.{ico,txt}',
                        '.htaccess',
                        '*.html',
                        '*.json',
                        'CNAME',
                        'markdown/**',
                        'elements/**',
                        'styles/*.ttf',
                        'scripts/**',
                        '!elements/**/*.scss',
                        '!elements/**/*.coffee',
                        'images/{,*/}*.{webp,gif}',
                        'bower_components/**'
                    ]
                }]
            },
            styles: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>',
                    dest: '.tmp',
                    src: ['{styles,elements}/{,*/,*/*/,*/*/*/}*.css']
                }]
            },
            scripts: {
                files: [{
                    expand: true,
                    cwd: '<%= yeoman.app %>',
                    dest: '.tmp',
                    src: ['{scripts,elements}/{,*/,*/*/,*/*/*/}*.js']
                }]
            }
        },
        // See this tutorial if you'd like to run PageSpeed
        // against localhost: http://www.jamescryer.com/2014/06/12/grunt-pagespeed-and-ngrok-locally-testing/
        pagespeed: {
            options: {
                // By default, we use the PageSpeed Insights
                // free (no API key) tier. You can use a Google
                // Developer API key if you have one. See
                // http://goo.gl/RkN0vE for info
                nokey: true
            },
            // Update `url` below to the public URL for your site
            mobile: {
                options: {
                    url: "https://developers.google.com/web/fundamentals/",
                    locale: "en_GB",
                    strategy: "mobile",
                    threshold: 80
                }
            }
        },
        'gh-pages': {
            options: {
                base: 'dist'
            },
            src: ['*', 'styles/*']
        }
    });

    grunt.registerTask('server', function(target) {
        grunt.log.warn('The `server` task has been deprecated. Use `grunt serve` to start a server.');
        grunt.task.run(['serve:' + target]);
    });

    grunt.registerTask('serve', function(target) {
        if (target === 'dist') {
            return grunt.task.run(['build', 'open', 'connect:dist:keepalive']);
        }

        grunt.task.run([
            'clean:server',
            'coffee:server',
            'sass:server',
            'copy:styles',
            'copy:scripts',
            'autoprefixer:server',
            'connect:livereload',
            'open',
            'watch'
        ]);
    });

    grunt.registerTask('test', [
        'clean:server',
        'connect:test'
    ]);

    grunt.registerTask('build', [
        'clean:dist',
        'coffee',
        'sass',
        'copy',
        'useminPrepare',
        'imagemin',
        'concat',
        'autoprefixer',
        'vulcanize',
        'uglify',
        'usemin',
        'minifyHtml'
    ]);

    grunt.registerTask('default', [
        'jshint',
        // 'test'
        'build'
    ]);
};
