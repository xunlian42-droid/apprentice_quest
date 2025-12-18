echo パスワードマネージャーへようこそ！
echo サービス名を入力してください：
read service
echo ユーザー名を入力してください：
read user
echo パスワードを入力してください：
read pass

echo Thank you!

echo "$service:$user:$pass" >> password01.txt
