#!/bin/bash

PASSWORD_FILE="passwords03.txt"
ENCRYPTED_FILE="passwords03.txt.dat"

echo マスターパスワードを入力してください：
read -s KEY
echo ""

# 暗号化
encrypt_file() {
      openssl enc -aes256 -pbkdf2 -md sha-256 -in "$PASSWORD_FILE" -out "$ENCRYPTED_FILE" -k "$KEY"
      rm "$PASSWORD_FILE"
}

# 複合化
decrypt_file() {
      if [ -f "$ENCRYPTED_FILE" ]; then
          openssl enc -d -aes256 -pbkdf2 -md sha-256 -in "$ENCRYPTED_FILE" -out "$PASSWORD_FILE" -k "$KEY"
      else
          touch "$PASSWORD_FILE"
      fi
}


while true
do

   echo パスワードマネージャーへようこそ！
   echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
   read choice

   if [ "$choice" = "Add Password" ]; then
       decrypt_file

       echo サービス名を入力してください：
       read service
       echo ユーザー名を入力してください：
       read user
       echo パスワードを入力してください：
       read pass
       echo "$service:$user:$pass" >> "$PASSWORD_FILE"

       encrypt_file
       echo パスワードの追加は成功しました。

   elif [ "$choice" = "Get Password" ]; then
       decrypt_file

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

       encrypt_file

   elif [ "$choice" = "Exit" ]; then
       echo Thank you！
       break

   else
       echo 入力が間違えています。Add Password/Get Password/Exit から入力してください。
   fi

   echo ""
done
