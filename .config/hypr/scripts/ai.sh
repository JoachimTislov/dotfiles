#!/usr/bin/env bash

declare -A LLMS=(
  ["chatgpt"]="https://chatgpt.com"
  ["gemini"]="https://gemini.google.com"
  ["claude"]="https://claude.ai"
  ["copilot"]="https://copilot.microsoft.com"
  ["perplexity"]="https://perplexity.ai/"
  ["meta"]="https://meta.ai/"
  ["grok"]="https://grok.com/"
  ["deepseek"]="https://chat.deepseek.com/"
  ["sider"]="https://sider.ai/"
  ["runwayml"]="https://runwayml.com/"
  ["mistral"]="https://chat.mistral.ai"
  ["phind"]="https://phind.com/"
  ["you"]="https://you.com/?chatMode=default"
  ["poe"]="https://poe.com/"
  ["together"]="https://chat.together.ai"
  ["firebase"]="https://studio.firebase.google.com/"
)

OPTIONS=("${!LLMS[@]}" "all")
LLM=$(printf '%s\n' "${OPTIONS[@]}" | rofi -dmenu -i)

function initialOpen() {
  active_workspace=$(hyprctl activeworkspace -j | jq '.id')
  if hyprctl clients -j | jq -r ".[] | select(.workspace.id == $active_workspace) | .class" | grep "firefox"; then
    firefox --new-tab $1
  else
    firefox --new-window $1
  fi
}

if [[ $LLM == "" ]]; then
  return 0
elif [[ "$LLM" == "all" ]]; then
  KEYS=("${!LLMS[@]}")
  initialOpen "${LLMS[${KEYS[0]}]}"
  sleep 0.1
  for ((i = 1; i < ${#KEYS[@]}; i++)); do
    firefox --new-tab "${LLMS[${KEYS[$i]}]}"
  done
else
  initialOpen "${LLMS[$LLM]}"
fi

# Others - non-web services
# https://notion.com/
# https://capcut.com/
# comparison platform: https://lmsys.org/
# https://civitai.com/ - Generative image models and training
# https://synthesia.io/ - Text to video
# AgentGPT: https://agentgpt.reworkd.ai/
# Local AI hardware guides: https://apxml.com/
# 27 of the best LLMs: https://www.techtarget.com/WhatIs/feature/12-of-the-best-large-language-models
# Inference Providers: https://huggingface.co/docs/inference-providers/index#getting-started
