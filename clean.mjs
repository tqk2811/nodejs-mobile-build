#!/usr/bin/node

import CLI from './cli.js'

import fs from 'fs'
import path from 'path'
import { URL } from 'url';
const __filename = new URL('', import.meta.url).pathname;
const __dirname = new URL('.', import.meta.url).pathname;

const source_dir = path.resolve(__dirname, CLI.exec_command(`tar -tzf tmp/node-latest.tar.gz -C . | head -1 | cut -f1 -d"/"`).split('\n')[0]);
const ndk_dir = path.resolve(__dirname, CLI.exec_command("unzip -l tmp/android-ndk-latest.zip | head -n 4").split('\n')[3].match(/(?<=[0-9]+   )(.*)(?=\/)/g)[0])

CLI.exec_command(`rm -rf ${ndk_dir}`, false, true);
CLI.exec_command(`rm -rf ${source_dir}`, false, true);

switch(process.argv[2]) {
  case "arm":
    CLI.exec_command(`rm -rf node-arm`, false, true);
    break;
  case "arm64":
    CLI.exec_command(`rm -rf node-arm64`, false, true);
    break;
  default:
    console.error(new Error(`"${process.argv[2]}" no such architecture.`));
}


//  CLI.exec_command(`rm node-latest.tar.gz`, false, true);
//  CLI.exec_command(`rm index.html`, false, true);

