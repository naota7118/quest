#!/bin/bash
echo "パスワードマネージャーへようこそ！"
while true 
do
 echo "次の選択肢から入力してください(Add Password/Get Password/Exit)："
 read answer

 declare -a array

 case $answer in
  "Add Password")
   echo "サービス名を入力してください"
   read service
   echo "ユーザー名を入力してください"
   read user
   echo "パスワードを入力してください"
   read password
   array+=("$service" "$user" "$password")
   echo "$service $user $password" >> passwordlist
   echo "パスワードの追加は成功しました。"
   continue
   ;;
  "Get Password")
   echo "サービス名を入力してください"
   read service
   if grep "$service" passwordlist > /dev/null; then
    echo "サービス名：$service"
    echo -n "ユーザー名："
    awk '$1 == "'$service'" {print $2}' passwordlist
    echo -n "パスワード："
    awk '$1 == "'$service'" {print $3}' passwordlist
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
