# config valid only for current version of Capistrano
lock '3.6.0'
# デプロイするアプリケーション名
set :application, 'job_matching'
# cloneするgitのレポジトリ
# （xxxxxxxx：ユーザ名、yyyyyyyy：アプリケーション名）
set :repo_url, 'https://github.com/shumatsuura/job_matching'
# deployするブランチ。デフォルトはmasterなのでなくても可。
set :branch, ENV['BRANCH'] || 'master'
# deploy先のディレクトリ。
set :deploy_to, '/var/www/job_matching'
# シンボリックリンクをはるフォルダ・ファイル
set :linked_files, %w{.env config/secrets.yml}
set :default_env, {
  rbenv_root: "/usr/local/rbenv",
  path: "/usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH",
  AWS_ACCESS_KEY_ID: ENV["AWS_ACCESS_KEY_ID"],
  AWS_SECRET_ACCESS_KEY: ENV["AWS_SECRET_ACCESS_KEY"],
  BASIC_AUTH_NAME: ENV["BASIC_AUTH_NAME"],
  BASIC_AUTH_PASSWORD: ENV["BASIC_AUTH_PASSWORD"],

  FACEBOOK_ID: ENV["FACEBOOK_ID"],
  FACEBOOK_SECRET_KEY: ENV["FACEBOOK_SECRET_KEY"]
}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/uploads}
# 保持するバージョンの個数(※後述)
set :keep_releases, 5
# Rubyのバージョン
set :rbenv_ruby, '2.6.5'
set :rbenv_type, :system
# 出力するログのレベル。エラーログを詳細に見たい場合は :debug に設定する。
# 本番環境用のものであれば、 :info程度が普通。
# ただし挙動をしっかり確認したいのであれば :debug に設定する。
set :log_level, :debug
namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end
  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end
  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end
  after :publishing, :restart
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end