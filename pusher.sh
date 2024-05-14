#!/bin/bash

read -p "[+] path: " path
read -p "[+] Files: " files
read -p "[+] Comment: " comment

(
	cd "$path" || { echo "[+] Error changing directory";exit 1; }
	git add "$files"

	read -p "[+] Need a status check? " status

	while  [[ ! "$status" =~ ^[YyNn]$ ]]; do
		read -p "[+] Please answer in yes or no. Need a status check? " status
	done

	case "$status" in
		[Yy]* ) git status;;
		[Nn]* ) echo "[+] continuing...";;
		* ) echo "[+] Please answer with yes or no" ;;
	esac

	git commit -m "$comment"
	git push

	case "$?" in
		0) echo "[+] Push Successful";;
		*) echo "[+] Push Unsuccessful";;
	esac
)
