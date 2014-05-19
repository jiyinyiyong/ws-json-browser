#!/usr/bin/env coffee
project = 'repo/ws-json-browser'

require 'shelljs/make'
path = require 'path'
mission = require 'mission'

mission.time()

target.folder = ->
  mission.tree
    '.gitignore': ''
    'README.md': ''
    js: {}
    build: {}
    coffee: {'main.coffee': ''}
    css: {'style.css': ''}

target.coffee = ->
  mission.coffee
    find: /\.coffee$/, from: 'coffee/', to: 'js/', extname: '.js'
    options:
      bare: yes

browserify = (callback) ->
  mission.browserify
    file: 'main.js', from: 'js/', to: 'build/', done: callback

target.browserify = -> browserify()

target.compile = ->
  target.coffee yes
  browserify()

target.watch = ->
  station = mission.reload()

  mission.watch
    files: ['coffee/']
    trigger: (filepath, extname) ->
      switch extname
        when '.coffee'
          filepath = path.relative 'coffee/', filepath
          mission.coffee
            file: filepath, from: 'coffee/', to: 'js/', extname: '.js'
            options:
              bare: yes
          browserify ->
            station.reload project

target.patch = ->
  target.compile()
  mission.bump
    file: 'package.json'
    options:
      at: 'patch'
