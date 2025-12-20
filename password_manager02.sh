#!/bin/bash

PASSWORD_FILE=passwords02.txt

while true
do

   echo パスワードマネージャーへようこそ！
   echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
   read choice

   if [ "$choice" = "Add Password" ]; then
       echo サービス名を入力してください：
       read service
       echo ユーザー名を入力してください：
       read user
       echo パスワードを入力してください：
       read pass
       echo "$service:$user:$pass" >> "$PASSWORD_FILE"
       echo パスワードの追加は成功しました。

   elif [ "$choice" = "Get Password" ]; then
       echo サービス名を入力してください：
       read service

       # サービス名に一致する行検索
       line=$(grep "^$service:" "$PASSWORD_FILE")
       if [ -n "$line" ]; then
       # if [ -z "$line" ]; then ($line が見つからない)
          # CSVを分解
          service=$(echo "$line" | cut -d':' -f1)
          user=$(echo "$line" | cut -d':' -f2)
          pass=$(echo "$line" | cut -d':' -f3)

          echo "サービス名：$service"
          echo "ユーザー名：$user"
          echo "パスワード：$pass"

       else
          echo そのサービスは登録されていません。
       fi

   elif [ "$choice" = "Exit" ]; then
       echo Thank you！
       break

   else
       echo 入力が間違えています。Add Password/Get Password/Exit から入力してください。
   fi

   echo ""
done
