# VSCodeを利用したRailsのデバッグ方法

1. VSCodeに [Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) 拡張をインストールしておく  
1. docker-compose.ymlを編集し、デバッグしたいRailsコンテナの環境変数に `RUBY_DEBUG_OPEN: true` を設定する。
1. コンソールから `docker compose up` を実行する。  
   デバッグが有効になっていると、起動時に
   ```
   DEBUGGER: Debugger can attach via UNIX domain socket (/tmp/ruby-debug-sock-0/ruby-debug-UnknownUser-13)
   ```
   というようなログが流れる。
1. Railsプロジェクトの直下に、以下の内容で `.devcontainer.json` というファイルを作成する
   ```json:.devcontainer.json
   {
       "name": "container app",
       "dockerComposeFile": ["../docker-compose.yml"],
       "service": "app", // docker-compse.ymlで記載している起動対象のサービス名
       "workspaceFolder": "/app", // 起動時に接続するディレクトリ
       "shutdownAction": "none", // 終了時にコンテナを削除しない
       "customizations": {
           "vscode": {
               "extensions": [
                   "KoichiSasada.vscode-rdbg"
               ]
           }
       }
   }
   ```
1. Railsプロジェクト内に、以下の内容で .vscode/launch.json というファイルを作成する
   ```json:.vscode/launch.json
   {
       "version": "0.2.0",
       "configurations": [
           {
               "type": "rdbg",
               "name": "Debug Rails (Attach)",
               "request": "attach"
           }
       ]
   }
   ```
1. VSCodeを起動し、Railsプロジェクトのフォルダを開く。
1. コンテナーで再度開くかを問うダイアログが表示されるので、「コンテナーで再度開く」を選択する。  
ダイアログが表示されなかった場合は、コマンドパレットを開き、「Dev Containers: Open Folder in Container」を選択し、Railsプロジェクトのフォルダを開く。
1. 左メニューから「実行とデバッグ」を選択し、 デバッグの開始ボタン ▶️ を押す。
1. デバッグを開始したい箇所にブレークポイントを設定し、デバッグを開始する。
1. デバッグを終了する場合は、デバッグのツールバーで「切断」を押す。
