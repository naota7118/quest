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
   echo ${array[0]}:${array[1]}:${array[2]} >> passwordlist
   echo "パスワードの追加は成功しました。"
   continue
   ;;
  "Get Password")
   echo "サービス名を入力してください"
   read service
   if grep "$service" passwordlist > /dev/null; then
    echo -n "サービス名："
    #$serviceを含む配列を取得
    echo ${array[0]="$service"}
   else
    echo "そのサービスは登録されていません。"
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
