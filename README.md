# efficientree

## ローカルで開発するための手順
1. `git clone git@github.com:NUTMEG-hackathon/issue_trees.git`
2. `docker-compose build`
3. `docker-compose run --rm api bundle install`
4. `docker-compose run --rm view npm install`
5. `docker-compose run --rm api rails db:create`
6. `docker-compose run --rm api rails db:migrate` \
これらのコマンドを実行する

## 環境構築できているか確認する
`docker-ccompose up`をターミナル上で実行して、\
Webブラウザから`localhost:3000`でRailsの画面、`localhost:8080`でVueの画面が表示されればOK
