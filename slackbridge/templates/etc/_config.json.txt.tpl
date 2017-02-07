[
  {
    "nickname": {{ .Values.bot_nickname | quote }},
    "server": {{ .Values.irc_server | quote }},
    "token": {{ .Values.slack_token | quote }},
    "autoSendCommands": [
        ["MODE", "test", "+i"],
        ["AUTH", "test", "password"]
    ],
    "channelMapping": {
      "#{{ .Values.slack_channel }}": "#{{ .Values.irc_channel }}"
    }
  }
]