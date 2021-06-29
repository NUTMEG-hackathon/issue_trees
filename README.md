# issue_trees

## ローカルで開発するための手順
1. `git clone `
2. `docker-compose build`
3. `docker-compose run --rm api rails db:create`
4. `docker-compose run --rm api rails db:migrate` \
これらのコマンドを実行する

## 環境構築できているか確認する
`docker-ccompose up`をターミナル上で実行して、\
Webブラウザから`localhost:3000`と`localhost:8080`にログインし、Railsの画面とVueの画面が表示されればOK
