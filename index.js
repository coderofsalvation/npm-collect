// Generated by CoffeeScript 1.10.0
(function() {
  var fs;

  fs = require('fs');

  module.exports = (function() {
    this.collect = function(json, opts) {
      var deps, ref;
      opts = opts || {};
      opts.deptype = opts.deptype || "dependencies";
      opts.save = opts.save || false;
      opts.verbose = opts.verbose || 1;
      if ((ref = opts.deptype) !== "dependencies" && ref !== "devDependencies" && ref !== "optionalDependencies") {
        throw "unknown type" + opts.deptype;
      }
      if (json[opts.deptype] == null) {
        json[opts.deptype] = {};
      }
      deps = json[opts.deptype];
      if (opts.verbose > 1) {
        console.log(JSON.stringify(deps, null, 2));
      }
      return fs.readdir(process.cwd() + '/node_modules', function(err, dirs) {
        if (err) {
          console.log(err);
          return;
        }
        return dirs.forEach(function(dir) {
          var packageJsonFile;
          if (dir.indexOf('.') !== 0) {
            packageJsonFile = process.cwd() + '/node_modules/' + dir + '/package.json';
            if (fs.existsSync(packageJsonFile)) {
              return fs.readFile(packageJsonFile, function(err, data) {
                var found, mod, save;
                if (err) {
                  return console.log(err);
                } else {
                  mod = JSON.parse(data);
                  save = false;
                  found = (deps[mod.name] != null ? true : false);
                  if (found && deps[mod.name].replace(/^\^/, '') !== mod.version) {
                    if (opts.verbose > 0) {
                      console.log(mod.name + "@" + deps[mod.name] + " -> " + mod.version);
                    }
                    deps[mod.name] = "^" + mod.version;
                    if (opts.save) {
                      save = true;
                    }
                  } else {
                    if (!found && !opts["new"]) {
                      if (opts.verbose > 0) {
                        console.log(mod.name + "@(unsaved) -> " + mod.version);
                      }
                      deps[mod.name] = "^" + mod.version;
                      if (opts.save) {
                        save = true;
                      }
                    }
                  }
                  if (save) {
                    return fs.writeFileSync("./package.json", JSON.stringify(json, null, 2));
                  }
                }
              });
            }
          }
        });
      });
    };
    return this.collect;
  }).apply({});

}).call(this);
