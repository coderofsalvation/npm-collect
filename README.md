# Useful when

* updating/developing several npm modules in parallel (especially using `npm link`)
* creating an package.json file after installing modules

# Usage

    npm install -g npm-collect

then:
  
    $ npm-collect --help
    Usage: npm-collect <options>
    Options:
      --devDependencies    process dev-dependencies instead of dependencies
      --new                include modules which are not found in package.json, but are installed
      --save               write changes to package.json
      -v <number>          verboselevel (0=silent,1=normal,2=debug)

# Examples

Just see differences without writing to package.json

    $ npm-collect
    querystring@0.1.9 -> 0.2.0
    modulefoo@0.2.9 -> 0.3.0

update your package.json
    
    $ npm-collect --save
    querystring@0.1.9 -> 0.2.0
    modulefoo@0.2.9 -> 0.3.0

update package.json with newly discovered modules in node_modules

    $ npm-collect --new --save
    querystring@(unsaved) -> 0.2.0
    ohmypgrah@(unsaved)   -> 0.2.0
