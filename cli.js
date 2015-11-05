#!/usr/bin/env node
var argv, collect, err, fs, json, opts, usage;

fs = require('fs');

argv = require('minimist')(process.argv.slice(2));

collect = require(__dirname + "/.");

usage = function() {
  console.log("Usage: npm-collect <options>");
  console.log("Options:");
  console.log("  --devDependencies    process dev-dependencies instead of dependencies");
  console.log("  --new                include modules which are not found in package.json, but are installed");
  console.log("  --save               write changes to package.json");
  return console.log("  -v <number>          verboselevel (0=silent,1=normal,2=debug)");
};

try {
  json = JSON.parse(fs.readFileSync('./package.json'));
} catch (_error) {
  err = _error;
  console.error("Error: please run this command in a directory with 'package.json'");
  usage();
  process.exit(1);
}

if (argv.help != null) {
  usage();
  process.exit(0);
}

opts = {};

if (argv["new"] != null) {
  opts["new"] = true;
}

if (argv.v != null) {
  opts.verbose = parseInt(argv.v);
}

if (argv.save != null) {
  opts.save = true;
}

if (argv.devDependencies != null) {
  opts.deptype = "devDependencies";
}

collect(json, opts);

