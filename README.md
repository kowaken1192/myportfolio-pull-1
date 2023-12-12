# README
# Explore & Share - Japan  -世界中のみんなでまだ知らない都道府県を探そう-
# サービス概要
Explore & Share - Japanアプリは世界中の人にもっとたくさんの日本の都道府県を知ってもらいたいという思いで作成しました。多くの機能がありますが以下の２つの機能がメイン機能です。  
検索方法(Explore)- 色分けされた日本地図をクリックし、人気投稿や各投稿の詳細を見ることができ、その中で気になったことがあればOpen AIが活用されているチャットボットも使って別に検索可能。  
投稿方法(Share)- 観光地の住所を検索してレビューをするだけの2STEPで投稿完了。　
細かい機能は動画などでまとめております。    
## アプリURL
https://tourism-app-a6dee8649ee4.herokuapp.com/  
レスポンシブ対応されており、スマホでも基本使えますが、小さな都道府県はスマホだとクリックしずらい部分があるのでできればパソコン推奨です。  　　
# アプリを作成した背景、理由
私自身、国際恋愛や外国語大学を大学に選ぶほど異文化交流や英会話が好きなので何か日本と外国が少しでも繋がり合えるようなアプリを作りたいと思いました.  
日本も今、多くのインバウンドが訪れており街で観光している外国人を見ない日はない程ですが、　実態は宿泊者や観光客のほとんどは東京や大阪など都心部を中心に集まっており、地方では全く数字が伸びていない事実を知りました。  
以下その参考url  
(https://honichi.com/news/2023/10/16/inbound-prefecture-ranking/)  
私が大学時代付き合っていたオーストラリア人の彼女やその家族、日本に留学に来ていた大学時代の友人も私の出生地である岡山県のことなどは全く知らず、東京や大阪、京都についてよく知ってました。  
そのため、少しでも外国人の方にまだ知らない日本の都道府県を知ってほしいと思い、日本地図から気になる都道府県をクリックし、人気の投稿などが見れる機能を作れば、簡単にいろいろな都道府県を調べることができると思いこのアプリを作成しました。  
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
### バックエンド　　Rails 6.1.7.6/ruby 3.1.2p20  
コード解析 / フォーマッター: Rubocop  
テストフレームワーク: RSpec  
### フロントエンド　　Html/CSS/Javascript/Ajax
フォーマッター: Beautify  
CSSフレームワーク：　Bulma  
アイコンライブラリ:　FontAwsome  
ホーム画面デザイン:　Canva  
JavaScript 実行環境　：　node.js v16.18.1
### CI/CD GitHub Actions
### インフラ　　Heroku AWS S3　
[erd.pdf](https://github.com/kowaken1192/myportfolio-pull-1/files/13645995/erd.pdf)

##### 見出し5
###### 見出し6
