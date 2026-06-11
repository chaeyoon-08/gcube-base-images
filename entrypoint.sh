#!/usr/bin/env bash
set -e

if [ -n "$GIT_USER_NAME" ]; then
  git config --global user.name "$GIT_USER_NAME"
fi
if [ -n "$GIT_USER_EMAIL" ]; then
  git config --global user.email "$GIT_USER_EMAIL"
fi

if [ -n "$GIT_TOKEN" ]; then
  HOST="${GIT_HOST:-github.com}"
  git config --global credential.helper store
  echo "https://git:${GIT_TOKEN}@${HOST}" > ~/.git-credentials
  chmod 600 ~/.git-credentials
fi

if [ -n "$GIT_CLONE_REPO" ]; then
  DEST="/workspace/$(basename "$GIT_CLONE_REPO" .git)"
  if [ ! -d "$DEST" ]; then
    git clone "$GIT_CLONE_REPO" "$DEST" || echo "[entrypoint] WARN: clone 실패 — 건너뜀"
  fi
fi

exec "$@"