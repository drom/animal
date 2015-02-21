#!/usr/bin/env node

// http://pdp-11.trailing-edge.com/rsts11/rsts-11-013/ANIMAL.BAS

'use strict';

var readline = require('readline');
var msg = require('./text.json');

var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

var data = msg.data;

var start, traverse;

traverse = function (node, parent, index) {
    if (typeof node === 'string') {
        rl.question(msg.isItA + node + '? ', function (answer) {
            if (answer.match('y')) { // yes
                console.log(msg.again);
                start();
            } else {
                rl.question(msg.right, function(a) {
                    rl.question(
                        msg.distinguish + a + msg.fromA + node + ': ',
                        function (q) {
                            parent[index] = [q, a, node];
                            console.log(msg.again);
                            start();
                        }
                    );
                });
            }
        });
    } else {
        rl.question(node[0] + '? ', function(answer) {
            if (answer.match('y')) { // yes
                traverse(node[1], node, 1);
            } else {
                traverse(node[2], node, 2);
            }
        });
    }
};

start = function () {
    rl.question(msg.mood, function(answer) {
        if (answer.match('l')) { // list
            console.log(msg.known + JSON.stringify(data, null, 4));
            start();
        } else {
            if (answer.match('y')) { // yes
                traverse(data);
            } else {
                console.log(msg.exit);
                rl.close();
            }
        }
    });
};

console.log(msg.start);
start();
