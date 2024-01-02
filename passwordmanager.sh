#!/bin/bash
echo "パスワードマネージャーへようこそ！"
while true 
do
 echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
 read answer

 case $answer in
  "Add Password")
   echo "サービス名を入力してください"
   read service
   echo "ユーザー名を入力してください"
   read user
   echo "パスワードを入力してください"
   read password
   echo "$service:$user:$password" >> passwordlist
   echo "パスワードの追加は成功しました。"
   gpg -c passwordlist
   rm passworlist
   continue
   ;;
  "Get Password")
   echo "サービス名を入力してください"
   read service
   gpg -d passwordlist.gpg > /dev/null
   if grep "$service" passwordlist > /dev/null; then
    echo -n "サービス名："
    awk -F":" '$1 == "'$service'" {print $1}' passwordlist
    echo -n "ユーザー名："
    awk -F":" '$1 == "'$service'" {print $2}' passwordlist
    echo -n "パスワード："
    awk -F":" '$1 == "'$service'" {print $3}' passwordlist
   rm passwordlist
   else
    echo "そのサービスは登録されていません" 
   fi
   continue
   ;;   
  "Exit")
   echo "Thank you!"
   break
   ;;
  *)
   echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
   continue
   ;;
 esac
done
