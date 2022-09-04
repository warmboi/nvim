rm -rf node_debug
git clone https://github.com/Microsoft/vscode-node-debug2.git external/node_debug
cd external/node_debug
npm install
npm run build --no-experimental-fetch
cd ..
cd ..
