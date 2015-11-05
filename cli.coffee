#!/usr/bin/env coffee
fs = require('fs')
argv = require('minimist')(process.argv.slice(2))
collect = require __dirname+"/."

usage = () ->
  console.log "Usage: npm-collect <options>"
  console.log "Options:"
  console.log "  --devDependencies    process dev-dependencies instead of dependencies"
  console.log "  --new                include modules which are not found in package.json, but are installed"
  console.log "  --save               write changes to package.json"
  console.log "  -v <number>          verboselevel (0=silent,1=normal,2=debug)"

try 
  json = JSON.parse fs.readFileSync './package.json'
catch err
  console.error "Error: please run this command in a directory with 'package.json'"
  usage()
  process.exit 1

if argv.help?
  usage()
  process.exit 0

opts = {}
opts.new = true if argv.new?
opts.verbose = parseInt argv.v if argv.v?
opts.save = true if argv.save?
opts.deptype = "devDependencies" if argv.devDependencies?
collect json,opts


