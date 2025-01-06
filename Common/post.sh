#!/usr/bin/env bash

# Copyright 2024

tgp() {
    curl -sX POST https://api.telegram.org/bot"$TOKEN"/sendPhoto -d photo=$PHOTO -d chat_id="$CHAT_TOPIC" -d message_thread_id="$TOPIC_ID" -d parse_mode=Markdown -d disable_web_page_preview=true -d text="$1" &>/dev/null -d caption="#AltsProject #MI8953
$KERNELNAME $DEVICENAME || Kernel 4.9
Author: @RennAlt

🔹[Changelog]($CHANGELOG)
🔹[Download]($DOWNLOAD)
🔹[Support Group](@MI8953)

Notes: 
• Initial Unified Vince & Ysl Kernel

Know Isu :
• Audio Vince Not Work
• No Camera Temporary for ysl & vince
• ysl panel isu when the screen is left off for a long time 

Credits :
• Thanks to @InneiAlt @exy3zed OxCAFEBABE for the help and reference
• @@XShiner for vince tester"
}

# Send Build Info
sendinfo() {
    tgp 
}

sendinfo
