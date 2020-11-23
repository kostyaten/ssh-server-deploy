# SSH Server Deploy

![GitHub](https://img.shields.io/github/license/kostya-ten/ssh-server-deploy)


### Usage

Simple example using username and password

```
name: SSH Server Deploy
on: [push]
jobs:
  build:
    name: Build
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: SSH Server Deploy
        uses: kostya-ten/ssh-server-deploy@v4
        with:
          host: ${{ secrets.SERVER_HOST }}
          port: ${{ secrets.SERVER_PORT }}
          username: ${{ secrets.SERVER_USERNAME }}
          password: ${{ secrets.SERVER_PASSWORD }}
          scp_source: README.md
          scp_target: ~/
          before_script: |
            df -h
          after_script: |
            whoami
```

Simple example using ssh private key

```
name: SSH Server Deploy
on: [push]
jobs:
  build:
    name: Build
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2
      - name: SSH Server Deploy
        uses: kostya-ten/ssh-server-deploy@v4
        with:
          host: ${{ secrets.SERVER_HOST }}
          port: ${{ secrets.SERVER_PORT }}
          username: ${{ secrets.SERVER_USERNAME }}
          private_key: ${{ secrets.PRIVATE_KEY }}
          scp_source: README.md
          scp_target: ~/
          before_script: |
            df -h
          after_script: |
            whoami
```

