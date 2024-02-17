手順

※MacOs の場合異なる可能性あり

1. 環境変数の設定

   - `env | grep DISPLAY` の結果を .devcontainer\flutter\.flutter.env にコピペ

2. docker image 　の作成

   - `docker compose build`

3. コンテナ作成＆起動

   - `docker compose up -d`

4. コンテナに入り方＆アプリを起動方法
   - `docker compose exec -it devcontainer-flutter-1 bash`
   - `cd rakuraku_reserve_front && fvm flutter run`
