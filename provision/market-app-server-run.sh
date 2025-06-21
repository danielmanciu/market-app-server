#!/bin/bash

# Start server through
docker run --detach --restart=always --name market_app_server --publish 2024:2024 danielmanciu/market-app-server:0.1.0
