手順

※MacOs の場合異なる可能性あり
※MacOs の場合、.devcontainer\flutter\Dockerfile を編集する必要あり
参照：https://qiita.com/kurun_pan/items/47614dec03575036675d#host-os%E3%81%8Cmacos%E3%81%AE%E5%A0%B4%E5%90%88

1. 環境変数の設定

   - `env | grep DISPLAY` の結果を .devcontainer\flutter\.flutter.env にコピペ

2. 移動

   - `cd .devcontainer`

3. docker image 　の作成

   - `docker compose build`

4. コンテナ作成＆起動

   - `docker compose up -d`

5. コンテナに入り方＆アプリを起動

   - `docker exec -it devcontainer-flutter-1 bash`
   - `fvm flutter run`

補足. Android Studio 起動（初回のみ設定必要）

- `studio.sh`
