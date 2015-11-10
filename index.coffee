#!/usr/bin/env coffee
fs = require 'fs'
module.exports = ( () ->

  @.collect = (json,opts) ->
    opts = opts || {}
    opts.deptype = opts.deptype || "dependencies"
    opts.save  = opts.save  || false
    opts.verbose = opts.verbose || 1
    throw "unknown type"+opts.deptype if opts.deptype not in ["dependencies","devDependencies","optionalDependencies"]

    json[ opts.deptype ] = {} if not json[ opts.deptype ]?
    deps = json[ opts.deptype ]
    console.log JSON.stringify deps,null,2 if opts.verbose > 1

    fs.readdir process.cwd()+'/node_modules', (err, dirs) ->
      if err
        console.log err
        return
      dirs.forEach (dir) ->
        if dir.indexOf('.') != 0
          packageJsonFile = process.cwd()+'/node_modules/' + dir + '/package.json'
          if fs.existsSync(packageJsonFile)
            fs.readFile packageJsonFile, (err, data) ->
              if err
                console.log err
              else
                mod = JSON.parse(data)
                save = false
                found = ( if deps[mod.name]? then true else false )
                if found and deps[mod.name].replace(/^\^/,'') != mod.version
                  console.log mod.name+"@"+deps[mod.name]+" -> "+mod.version if opts.verbose > 0
                  deps[mod.name] = "^"+mod.version
                  save = true if opts.save
                else 
                  if not found and not opts.new
                    console.log mod.name+"@(unsaved) -> "+mod.version if opts.verbose > 0
                    deps[mod.name] = "^"+mod.version
                    save = true if opts.save
                if save 
                  fs.writeFileSync "./package.json", JSON.stringify json,null,2 
  
  @.collect

).apply({})
