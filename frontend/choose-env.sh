#!/bin/bash
if [ "$NODE_ENV" = "staging" ]; then
  npm run build -- --mode staging
else
  npm run build
fi