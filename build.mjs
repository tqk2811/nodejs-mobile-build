#!/usr/bin/node
 
import CLI from './cli.js'



//console.log(process.argv);

const exec_command = CLI.exec_command;

import fs from 'fs'
import path from 'path'
import { URL } from 'url';
const __filename = new URL('', import.meta.url).pathname;
const __dirname = new URL('.', import.meta.url).pathname;


const ARCH = process.argv[2];
const ANDROID_APIV = process.argv[3];

exec_command("mkdir -p tmp");

// ANDROID NDK
if (!fs.existsSync("tmp/android-ndk-latest.zip")) {
  exec_command('wget -q https://developer.android.com/ndk/downloads -O tmp/android-ndk.html', false, true);
  const dpage_html = exec_command('cat tmp/android-ndk.html');
  const dpath = dpage_html.toString().match(/(?<=y="ndk_lts_linux64_download(.|\n)*href=")(https:\/\/dl\.google\.com\/android\/repository\/.*.zip)(?="(.|\n)*>Download the Android NDK LTS)/g)[0];
  exec_command(`wget -q ${dpath} -O tmp/android-ndk-latest.zip`, false, true);
}

const ndk_dir = path.resolve(__dirname, exec_command("unzip -l tmp/android-ndk-latest.zip | head -n 4").split('\n')[3].match(/(?<=[0-9]+   )(.*)(?=\/)/g)[0])

if (!fs.existsSync(ndk_dir)) exec_command(`unzip tmp/android-ndk-latest.zip`);

const llvm_bin = `${ndk_dir}/toolchains/llvm/prebuilt/linux-x86_64/bin`;
const llvm_clang = `${llvm_bin}/clang`
const llvm_clang_pp = `${llvm_bin}/clang++`
/*
exec_command(`rm ${llvm_clang} ${llvm_clang_pp}`);
exec_command(`ln -s ./clang-12 clang`, llvm_bin);
exec_command(`ln -s ./clang-12 clang++`, llvm_bin);
*/

let llvm_prefix_clang = `${llvm_bin}/`

let CPU_ARCH = undefined;
switch (ARCH) {
  case "arm":
    llvm_prefix_clang += `armv7a-linux-androideabi${ANDROID_APIV}-clang`
    CPU_ARCH = "armv7a";
    break;
  case "arm64":
    CPU_ARCH = "aarch64";
    break;
  default:
    console.error(new Error(`Invalid architecture ${ARCH} or not yet implemented...`));
}


// NODE.JS
if (!fs.existsSync("tmp/node-latest.tar.gz")) {
  exec_command('wget -q https://nodejs.org/en/download/current/ -O tmp/node.html', false, true);
  const dpage_html = exec_command('cat tmp/node.html');
  const dpath = dpage_html.toString().match(/(?<=<th>Source Code<\/th>\n.*\n.*)(https:\/\/nodejs\.org\/dist\/v17\.3\.1\/node-v.[^>]*\.tar\.gz)/g)[0];
  exec_command(`wget -q ${dpath} -O tmp/node-latest.tar.gz`, false, true);
}


const source_dir = exec_command(`tar -tzf tmp/node-latest.tar.gz -C . | head -1 | cut -f1 -d"/"`).split('\n')[0];

if (!fs.existsSync(source_dir)) {
  exec_command(`tar -xzf tmp/node-latest.tar.gz -C .`, false, true)
}

if (!fs.existsSync("node-"+ARCH)) {
  exec_command(`cp -R ${source_dir} node-${ARCH}`);
}

const full_source_path = path.resolve(__dirname, "node-"+ARCH);
const naconf_path = path.resolve(full_source_path, 'android-configure');

const edit_source_file = (fpath, verify_cb, replacements) => {
  let fcontents = fs.readFileSync(fpath, 'utf8');
  if (verify_cb(fcontents)) {
    for (const repl of replacements) {
      fcontents = fcontents.replace(repl[0], repl[1]);
    }

    fs.writeFileSync(fpath, fcontents);
  }
}


exec_command(`patch -N < ../patches/android-configure.patch`, full_source_path, true);
exec_command(`patch -N -p0 < ../patches/deps_v8_src_trap-handler_trap-handler.h.patch`, full_source_path, true);
exec_command(`patch -N -p0 < ../patches/deps-uv-uv.gyp.patch`, full_source_path, true);
//exec_command(`patch -N -p0 < ../termux-ref/tools-v8_gypfiles-toolchain.gypi.patch`, full_source_path, true);

switch (ARCH) {
  case "arm":

    break;
  case "arm64":

    break;
  default:
    console.error(new Error(`Invalid architecture ${ARCH} or not yet implemented...`));
}

exec_command(`./android-configure ${ndk_dir} ${ARCH} ${ANDROID_APIV}`, full_source_path, true);
exec_command(`make -j16`, full_source_path, true);
exec_command(`DESTDIR="../out/${CPU_ARCH}" make -j16 install`, full_source_path, true);
