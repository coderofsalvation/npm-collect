#!/usr/bin/env coffee
fs = require('fs')
argv = require('minimist')(process.argv.slice(2))
collect = require __dirname+"/."

usage = () ->
  console.log "Usage: npm-collect <options>"
  console.log "Options:"
  console.log "  --devDependencies       process devDependencies instead of dependencies"
  console.log "  --optionalDependencies  process optional dependencies instead of dependencies"
  console.log "  --nonew                 ignore modules which are not found in package.json, but are installed"
  console.log "  --save                  write changes to package.json"
  console.log "  -v <number>             verboselevel (0=silent,1=normal,2=debug)"

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
opts.new = false if argv.nonew?
opts.verbose = parseInt argv.v if argv.v?
opts.save = true if argv.save?
opts.deptype = "devDependencies" if argv.devDependencies?
opts.deptype = "optionalDependencies" if argv.optionalDependencies?
collect json,opts


