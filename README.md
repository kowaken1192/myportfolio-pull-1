# Explore & Share - Japan   
# -世界中のみんなでまだ知らない都道府県を探そう-
![A1FABF70-05A3-449E-A3A4-8A03490BAFF3_1_201_a](https://github.com/kowaken1192/myportfolio-pull-1/assets/125761472/06ada4a5-a5e4-4a75-9af8-cc766cb4bd64)
![CI/CD](https://img.shields.io/badge/CI%2FCD-passing-brightgreen)
![OpenAI](https://img.shields.io/badge/OpenAI-API-green.svg)
![Google Maps API](https://img.shields.io/badge/Google%20Maps-API-blue.svg)
<img src="https://img.shields.io/badge/-Heroku-430098.svg?logo=heroku&style=plastic">
<img src="https://img.shields.io/badge/-Rails%20v6.1.7.6-CC0000.svg?logo=rails&style=plastic">
<img src="https://img.shields.io/badge/-Ruby%20v3.1.2-CC342D.svg?logo=ruby&style=plastic">
<img src="https://img.shields.io/badge/-Node.js%2016.18.1-339933.svg?logo=node.js&style=plastic">
<img src="https://img.shields.io/badge/-ClearDB%20Mysql-4479A1.svg?logo=mysql&style=plastic">
<img src="https://img.shields.io/badge/-AWS%20s3-232F3E.svg?logo=amazon-aws&style=plastic">
![Ajax](https://img.shields.io/badge/Ajax-yellow)
![RSpec](https://img.shields.io/badge/RSpec-brightgreen)
![RuboCop](https://img.shields.io/badge/RuboCop-blueviolet)
<img src="https://img.shields.io/badge/-Canva-00C4CC.svg?logo=canva&style=plastic">

# サービス概要
このアプリは投稿数によって色分けされた日本地図をクリックしてあなたがまだ知らない都道府県の魅力を探していただくインバウンド向けアプリです。  
日本地図をクリックして検索するだけであれば、外国人の方でも簡単に知らなかった都道府県の観光地や魅力を探すことができるのではないかと思い作成しました。  
主に検索機能（Explore)と投稿機能(Share)を中心としています。（細かい操作方法は動画でまとめております)  
インバウンド向けと書いてますが、デフォルトは日本語で全て書かれており、日本人の人でもまだ知らない都道府県の魅力を探せます。
## アプリURL
https://tourism-app-a6dee8649ee4.herokuapp.com/  
レスポンシブ対応されており、スマホでも基本使えますが、小さな都道府県はスマホだとクリックしずらい部分があるのでできればパソコン推奨です。  　　
# アプリを作成した背景、理由
私自身、国際恋愛や外国語大学を大学に選ぶほど異文化交流や英会話が好きなので何か日本と外国が少しでも繋がり合えるようなアプリを作りたいと思いました。  
日本も今、多くのインバウンドが訪れており街で観光している外国人を見ない日はない程ですが、　実態は宿泊者や観光客のほとんどは東京や大阪など都心部を中心に集まっており、地方では全く数字が伸びていない事実を知りました。　以下その参考url  (https://honichi.com/news/2023/10/16/inbound-prefecture-ranking/)  
私のオーストラリア人の元彼女やその家族、日本に留学に来ていた大学時代の友人も私の出生地である岡山県のことなどは全く知らず、東京や大阪、京都についてよく知ってました。  
そのため、少しでも外国人の方にまだ知らない都道府県を知ってほしいと思い、日本地図から気になる都道府県をクリックし、人気の投稿などが見れる機能を作れば、調べる手間も省け、興味をもってもらうのではないかと考えこのアプリを作成しました。
# 検索方法
https://github.com/kowaken1192/myportfolio-pull-1/assets/125761472/8edb17fe-1510-48cf-8d85-882663e3cc46

動画が再生されない方は更新するかこちら(https://youtu.be/t0rLRltL-rQ)
# 投稿方法/その他機能
https://github.com/kowaken1192/myportfolio-pull-1/assets/125761472/8306dc59-f20c-45fa-8e8f-0a505881b8f7

動画が再生されない方は更新するかこちら(https://youtu.be/gPxIWK72QAM)
# 機能一覧
| 機能           | 説明                                                                                                        |
| -------------- | ----------------------------------------------------------------------------------------------------------- |
| 検索機能       | SVG日本地図を引用し、投稿数に応じて色分けされた地図をクリックして検索結果を表示 |
| 住所検索       | Google MapsのジオコーディングAPIを使用して、入力された観光地の住所を検索。次の投稿画面で住所を自動保存。      |
| 投稿機能       | 住所検索機能で検索した住所,行き先、都道府県名、国名は自動で表示。レビューすると投稿完了。 その後おすすめの投稿を表示                                                                 |
| チャットボット | ユーザーの入力をOpenAI GPT-3.5モデルを通し送信し、解答結果をAjaxを通して表示。                             |
| マイページ     | ログインしたユーザーの投稿のみが表示され、プロフィール画像などを変更可能。投稿の削除はこのマイページのみで可能。 |
| 翻訳機能       | Google翻訳ウィジェット使用して多言語翻訳。                                                                   |
| 投稿詳細       | 投稿のレビューだけしたい場合はこのページから可能。投稿をgoogle mapで地図を確認したり、google検索を行うことも可能。 |
| 新規登録・ログイン | deviseを使用して実装。                                                                                       |
| ゲストログイン | ゲストユーザーとして迅速なアクセス提供。                                                                    |
| パスワード変更 | ゲストユーザー以外のパスワードを変更可能。                                                                   |
| 退会機能       | ゲストユーザー以外の退会を可能とする。                                                                       |
| ホーム画面     | 全ての投稿を表示。人気投稿、口コミの多い投稿、最新の投稿などを調べることが可能。                             |
| いいね機能     | 投稿のいいね機能。いいねを押したらいいねした投稿のみがみれる（JavaScriptで実装）。                          |
###### N+1問題はActiveRecordスコープを使用し、左外部結合で投稿のレビュー数、いいね数、平均スコアを集計することで解決しました。
### バックエンド 　Rails 6.1.7.6/ruby 3.1.2p20
  - コード解析 / フォーマッター: Rubocop
  - テストフレームワーク: RSpec
### フロントエンド 　Html/CSS/Javascript/Ajax
  - フォーマッター: Beautify
  - CSSフレームワーク: Bulma
  - アイコンライブラリ: FontAwsome
  - ホーム画面デザイン: Canva
  - JavaScript 実行環境
    - node.js v16.18.1
### CI/CD 　GitHub Actions
### インフラ 　Heroku/AWS S3/ClearDB MySQL
### 外部API 　Google Map API/Open AI

# インフラ構成図
<img width="1440" alt="インフラ" src="https://github.com/kowaken1192/myportfolio-pull-1/assets/125761472/f4f7c276-3fe6-4632-8a08-f234075f2623)">

# ER図
<img width="1440" alt="66EDC69E-205C-4D51-BC2D-FCC5C7EBDC94" src="https://github.com/kowaken1192/myportfolio-pull-1/assets/125761472/7252677d-6c4a-4819-8304-e986053cd2f4">

