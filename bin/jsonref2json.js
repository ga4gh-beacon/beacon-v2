//   Script to dereference JSON $ref in Beacon v2 Models schemas
//
//   Last Modified: Jul/21/2022
//
//   Version 2.0.0
//
//   Copyright (C) 2022 Manuel Rueda (manuel.rueda@crg.eu)
//
//   This program is free software; you can redistribute it and/or modify
//   it under the terms of the GNU General Public License as published by
//   the Free Software Foundation; either version 3 of the License, or
//   (at your option) any later version.
//
//   This program is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//   GNU General Public License for more details.
//
//   You should have received a copy of the GNU General Public License
//   along with this program; if not, see <https://www.gnu.org/licenses/>.
//
//   If this program helps you in your research, please cite.

// load json-schema-ref-parser
const $RefParser = require("@apidevtools/json-schema-ref-parser");

// Force console.log to dump full objects
require("util").inspect.defaultOptions.depth = null;

// Array of arguments
const args = process.argv.slice(2);

// Input file
var schema = args[0];

// We create an object for the parser
let parser = new $RefParser();

// To print to STDOUT, we need to do a trick to deal with (async function)
let createOrder = async function () { 
  let response = await parser.dereference(schema);
  return response 
};

createOrder().then((result)=> {
  //the promise is resolved here
  console.log(JSON.stringify(result,null,4))
}).catch(console.error.bind(console))
