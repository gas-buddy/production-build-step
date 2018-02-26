#!/bin/sh
echo "BUILD_ID=$WERCKER_BUILD_ID" > BUILD_INFO
echo "BUILD_URL=$WERCKER_BUILD_URL" >> BUILD_INFO
echo "HASH=$WERCKER_GIT_COMMIT" >> BUILD_INFO
echo "$WERCKER_BUILD_ID" > WERCKER_BUILD_ID

export NODE_ENV=production
VALIDATE="require('shush')('./config/production.json')"

if [ -f ./config/production.json ] && ! node -e "${VALIDATE}"; then
  echo "ERROR: Your production.json did not validate." >&2
  exit 1
fi

npm run build
