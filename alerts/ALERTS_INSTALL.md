### Telegram alerts for your SORA Node status
 
If you install SORA node via our main guide, you can simply install this scripts in few steps

1. Pull updates from github
```sh
cd ${HOME}/sora-tips/; git pull
```

2. Create your telegram bot via @botfather, start it and put correct telegram_bot_token="xxx" and telegram_chat_id="xxx" in:
```
${HOME}/sora-tips/alerts/Send_msg_toTelBot.sh
```

3. Run script to add cronjobs
```sh
cd ${HOME}/sora-tips/alerts/scripts
./add_to_cron.sh
```

###
If you find this helpful, stake with us: https://lux8.net/sora

