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
        uses: kostya-ten/ssh-server-deploy@v1
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
        uses: kostya-ten/ssh-server-deploy@v1
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


| Param         | Value         |
| ------------- |:-------------:|
| host          | Host          |
| port          | Port          |
| username      | Username      |
| password      | Password      |
| scp_source    | List the files and directories that you want to upload to the server      |
| scp_target    | Directory where uploaded files will be |
| before_script | Executes commands before uploading |
| after_script  | Executes commands after upload |
