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
                        '{.tmp,<%= yeoman.app %>}/{,email/,email/*/}*.html',
                        '{.tmp,<%= yeoman.app %>}/elements/{,*/,*/*/,*/*/*/}*.{html,css,scss,js,coffee}',
                        '{.tmp,<%= yeoman.app %>}/{styles,email,email/*}/*.{css,scss}',
                        '{.tmp,<%= yeoman.app %>}/scripts/*.{js,coffee}',
                        '<%= yeoman.app %>/images/{,*/,*/*/,*/*/*/,*/*/*/*/}*.{png,jpg,jpeg,gif,webp}'
                    ]
                },
                js: {
                    files: [
                        '<%= yeoman.app %>/scripts/*.js',
                        '<%= yeoman.app %>/elements/{,*/,*/*/,*/*/*/}*.js'
                    ],
                    tasks: ['jshint', 'copy:scripts']
                },
                coffee: {
                    files: [
                        '<%= yeoman.app %>/scripts/*.coffee',
                        '<%= yeoman.app %>/elements/{,*/,*/*/,*/*/*/}*.coffee'
                    ],
                    tasks: ['coffee:server', 'jshint', 'copy:scripts']
                },
                styles: {
                    files: [
                        '<%= yeoman.app %>/{styles,email,email/*/}/*.css',
                        '<%= yeoman.app %>/elements/{,*/,*/*/,*/*/*/}*.css'
                    ],
                    tasks: ['copy:styles', 'autoprefixer:server']
                },
                sass: {
                    files: [
                        '<%= yeoman.app %>/{styles,email,email/*/}/*.{scss,sass}',
                        '<%= yeoman.app %>/elements/{,*/,*/*/,*/*/*/}*.{scss,sass}'
                    ],
                    tasks: ['sass:server', 'copy:styles', 'autoprefixer:server']
                }
            },
            // Compile coffee scripts to js
            coffee: {
                options: {
                    bare: false,
                    join: true
                },
                dist: {
                    files: [{
                        expand: true,
                        cwd: '<%= yeoman.app %>',
                        src: ['scripts/*.coffee', 'elements/{,*/,*/*/,*/*/*/}*.coffee'],
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
                        src: ['scripts/*.coffee', 'elements/{,*/,*/*/,*/*/*/}*.coffee'],
                        dest: '.tmp',
                        ext: '.js'
                    }]
                }
            },
            // Compiles Sass to CSS and generates necessary files if requested
            sass: {
                options: {
                    loadPath: 'bc'
                },
                dist: {
                    options: {
                        style: 'compressed'
                    },
                    files: [{
                        expand: true,
                        cwd: '<%= yeoman.app %>',
                        src: ['{styles,email,email/*}/*.{scss,sass}', 'elements/{,*/,*/*/,*/*/*/}*.{scss,sass}'],
                        dest: '<%= yeoman.dist %>',
                        ext: '.css'
                    }]
                },
                server: {
                    files: [{
                        expand: true,
                        cwd: '<%= yeoman.app %>',
                        src: ['{styles,email,email/*}/*.{scss,sass}', 'elements/{,*/,*/*/,*/*/*/}*.{scss,sass}'],
                        dest: '.tmp',
                        ext: '.css'
                    }]
                }
            },
            autoprefixer: {
                options: {
                    browsers: ['last 2 versions']
                },

                dist: {
                    files: [{
                        expand: true,
                        cwd: '<%= yeoman.dist %>',
                        src: ['**/*.css', '!bc/**/*.css'],
                        dest: '<%= yeoman.dist %>'
                    }]
                },
                server: {
                    files: [{
                        expand: true,
                        cwd: '.tmp',
                        src: '**/*.css',
                        dest: '.tmp'
                    }]
                }
            },
            connect: {
                options: {
                    port: 10000,
                    // protocol: 'https',
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
                            target: 'http://localhost:<%= connect.options.port %>'
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
                    reporter: require('jshint-stylish'),
                    ignores: [
                        '<%= yeoman.app %>/scripts/jquery.sha256.js',
                        '<%= yeoman.app %>/elements/qr-code/qr.js'
                    ]
                },
                all: [
                    '<%= yeoman.app %>/scripts/*.js',
                    '<%= yeoman.app %>/elements/{,*/,*/*/,*/*/*/}*.js',
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
            filerev: {
                options: {
                    algorithm: 'md5',
                    length: 8
                },
                step1: {
                    files: [{
                        expand: true,
                        cwd: '<%= yeoman.dist %>',
                        src: ['the-app.js', 'scripts/*.js', 'styles/*.css'],
                        dest: '<%= yeoman.dist %>'
                    }]
                },
                step2: {
                    files: [{
                        expand: true,
                        cwd: '<%= yeoman.dist %>',
                        src: ['the-app.html'],
                        dest: '<%= yeoman.dist %>'
                    }]
                }
            },
            usemin: {
                html: ['<%= yeoman.dist %>/{,*/,*/*/,*/*/*/}*.html'],
                css: ['<%= yeoman.dist %>/{styles,email,email/*}/*.css', '<%= yeoman.dist %>/elements{,*/,*/*/,*/*/*/}*.css'],
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
                thirdparty: {
                    options: {
                        strip: true,
                        inline: true,
                        "strip-excludes": false,
                        excludes: {
                            imports: ['.*'],
                            scripts: ['browser.js', 'fake.js', 'runner.js']
                        }

                    },
                    files: [{
                        expand: true,
                        cwd: '<%= yeoman.dist %>/bc',
                        src: ['**/*.html', '!{platform,web-component-tester,web-animations-js}/**/*.html'],
                        dest: '<%= yeoman.dist %>/bc'
                    }]
                },
                theapp: {
                    options: {
                        strip: true,
                        csp: true,
                        inline: true,
                        /*"strip-excludes": false,
                        excludes: {
                            imports: ['bc/.*']
                        }*/

                    },
                    files: {
                        '<%= yeoman.dist %>/the-app.html': [
                            '<%= yeoman.dist %>/elements/the-app.html'
                        ]
                    }
                },
                index: {
                    options: {
                        strip: true,
                        inline: true,
                        excludes: {
                            imports: [".*"],
                            scripts: [".*"]
                        },
                        "strip-excludes": false
                    },
                    files: {
                        '<%= yeoman.dist %>/index.html': [
                            '<%= yeoman.dist %>/index.html'
                        ]
                    }
                },
                email: {
                    options: {
                        strip: true,
                        inline: true
                    },
                    files: [{
                        expand: true,
                        cwd: '<%= yeoman.dist %>/email',
                        src: '{,*/}*.html',
                        dest: '<%= yeoman.dist %>/email'
                    }]
                }
            },
            imagemin: {
                dist: {
                    options: {
                        optimizationLevel: 7,
                    },
                    files: [{
                        expand: true,
                        cwd: '<%= yeoman.app %>/images',
                        src: '{,*/,*/*/,*/*/*/,*/*/*/*/}*.{png,jpg,jpeg}',
                        dest: '<%= yeoman.dist %>/images'
                    }]
                }
            },
            'json-minify': {
                build: {
                    files: '<%= yeoman.dist %>/configs/*.json'
                }
            },
            replace: {
                dist: {
                    options: {
                        usePrefix: false,
                        patterns: [{
                            json: {
                                "/configs/appconfig_": "http://x.bifengzhifu.com/configs/appconfig_"
                            }
                        }]

                    },
                    files: [{
                        expand: true,
                        cwd: '<%= yeoman.dist %>',
                        src: 'the-app*.js',
                        dest: '<%= yeoman.dist %>'
                    }]
                }
            },
            minifyHtml: {
                options: {
                    quotes: true,
                    empty: true
                },
                dist: {
                    files: [{
                        expand: true,
                        cwd: '<%= yeoman.dist %>',
                        src: '{index,404,elements/**/*,email/**/*}.html',
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
                            '*.{ico,txt,md}',
                            '.htaccess',
                            '*.html',
                            '*.json',
                            'CNAME',
                            'bc/**',
                            'elements/**',
                            'styles/*.ttf',
                            'scripts/**',
                            'images/**',
                            'markdown/**',
                            'email/**',
                            'configs/**',
                            'images/**',
                            '!**/*.scss',
                            '!**/*.coffee'
                        ]
                    }]
                },
                styles: {
                    files: [{
                        expand: true,
                        cwd: '<%= yeoman.app %>',
                        dest: '.tmp',
                        src: ['{styles,email,elements}/{,*/,*/*/,*/*/*/}*.css']
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
                        url: "http://x.coinport.com/#/markets",
                        locale: "en_GB",
                        strategy: "mobile",
                        threshold: 95
                    }
                },
                desktop: {
                    options: {
                        url: "http://x.coinport.com/#/markets",
                        locale: "en_GB",
                        strategy: "desktop",
                        threshold: 95
                    }
                }
            },
            'gh-pages': {
                options: {
                    base: 'dist'
                },
                src: ['**', 'bc/**']
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
            'uglify',
            'vulcanize:theapp',
            'vulcanize:email',
            'replace', // serve appconfig_*.json from http://x.bifengzhifu.com instead of https://x.coinport.com
            'filerev:step1',
            'filerev:step2',
            'usemin',
            'vulcanize:index',
            'minifyHtml',
            'json-minify',
            //'vulcanize:thirdparty',
        ]);

        grunt.registerTask('publish', [
            'build',
            'gh-pages',
        ]);

        grunt.registerTask('default', [
            'jshint',
            // 'test'
            'build'
        ]);
    };
