name: Deploy to Firebase Hosting on PR merge

on:
  push:
    branches:
      - main

jobs:
  build_and_deploy:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository
      uses: actions/checkout@v2

    - name: Install Node.js
      uses: actions/setup-node@v2
      with:
        node-version: '14'

    - name: Install Firebase CLI
      run: npm install -g firebase-tools

    - name: Deploy to Firebase
      env:
        FIREBASE_SERVICE_ACCOUNT_KEY: ${{ secrets.FIREBASE_SERVICE_ACCOUNT_KEY }}
      run: |
        echo $FIREBASE_SERVICE_ACCOUNT_KEY > ${HOME}/gcloud-service-key.json
        firebase deploy --only hosting --token "${{ secrets.FIREBASE_SERVICE_ACCOUNT_KEY }}"
