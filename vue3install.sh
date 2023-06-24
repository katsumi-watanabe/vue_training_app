#!/bin/bash

FILE_DIR="/Applications/MAMP/htdocs"
PROJECT_NAME=""

echo "Vue3をインストールしますか？[y/n]:"
read ANSWER

case $ANSWER in
  "" | [Yy]* )
    # ここに「Yes」の時の処理を書く
    echo "インストールを開始します！"
    npm init vite@latest
    ;;
  * )
    # ここに「No」の時の処理を書く
    echo "インストールを中止します！"
    exit
    ;;
esac


# コマンド実行後に少し待機
sleep 1
# ファイルの中身を表示
cd "${FILE_DIR}"

# ディレクトリ内のファイルを作成日時の降順で検索し、最初のファイルを取得
PROJECT_NAME=$(find . -type f -printf '%T@ %p\n' | sort -nr | head -n 1 | awk '{print $2}')

# npm init vite@latestの実行時に入力されたプロジェクト名を取得
# PROJECT_NAME=$ngrep -oP '(?<="name": ")[^"]*' package.json)
echo "FILE_DIR: ${FILE_DIR}"
echo "PROJECT_NAME: ${PROJECT_NAME}"

# プロジェクトディレクトリ
PROJECT_DIR="${FILE_DIR}/${PROJECT_NAME}"

echo "PROJECT_DIR: ${PROJECT_DIR}"
cd "${PROJECT_DIR}"

# プロジェクトの移動
mv "${FILE_DIR}/${PROJECT_NAME}" "${FILE_DIR}"


# プロジェクトディレクトリに移動
cd "${FILE_DIR}${PROJECT_NAME}"

# vscodeでプロジェクトを開く
code .

# npm run dev, npm installを実行
npm install
npm run dev

# supabaseのインストール必要か確認
echo "supabaseをインストールしますか？[y/n]:"
read DATABASEANSWER

case $DATABASEANSWER in
  "" | [Yy]* )
    # ここに「Yes」の時の処理を書く
    npm install @supabase/supabase-js
    ;;
  * )
    # ここに「No」の時の処理を書く
    echo "インストールを中止します！"
    exit
    ;;
esac

# supabaseの初期設定を行う
# src/supabase.jsファイルを作成し、supabaseの設定を記述する
touch src/supabase.js

# supabase.jsファイルに記述する内容を変数に格納
SUPABASEJS="import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

export const supabase = createClient(supabaseUrl, supabaseAnonKey)"

# supabase.jsファイルに記述する内容を書き込む
echo "${SUPABASEJS}" > src/supabase.js

#.envファイルを作成し、supabaseの設定を記述する
touch .env

#.envファイルに記述する内容を変数に格納
ENV="VITE_SUPABASE_URL=\nVITE_SUPABASE_ANON_KEY=\n"

# .envファイルを開く
echo "${ENV}" > .env
code .env

echo "supabaseでテーブルを作成してください！"