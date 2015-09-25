#!/usr/bin/env node

// http://pdp-11.trailing-edge.com/rsts11/rsts-11-013/ANIMAL.BAS

'use strict';

var readline = require('readline');
var msg = require('./text.json');

var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

var start, traverse;

traverse = function (parent, path) {
    var node = parent[path];
    if (typeof node === 'string') {
        rl.question(msg.isItA + node + ' ? ', function (answer) {
            if (answer.match('y')) { // yes
                console.log(msg.again);
                start();
            } else {
                rl.question(msg.itWas, function(itWas) {
                    rl.question(
                        msg.differ + itWas + msg.fromA + node + ': ',
                        function (differ) {
                            parent[path] = [differ, itWas, node];
                            console.log(msg.again);
                            start();
                        }
                    );
                });
            }
        });
    } else {
        rl.question(node[0] + ' ? ', function(answer) {
            if (answer.match('y')) { // yes
                traverse(node, 1);
            } else {
                traverse(node, 2);
            }
        });
    }
};

start = function () {
    rl.question(msg.mood, function(answer) {
        if (answer.match('l')) { // list
            console.log(msg.known + JSON.stringify(msg.data, null, 4));
            start();
        } else {
            if (answer.match('y')) { // yes
                traverse(msg, 'data');
            } else {
                console.log(msg.exit);
                rl.close();
            }
        }
    });
};

console.log(msg.start);
start();
