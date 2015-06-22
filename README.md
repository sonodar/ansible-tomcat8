ansible-tomcat
===============

Oracle JDK 8 と Tomcat 8.0 をインストールするためのPlaybookです。
Tomcatの標準ロギングAPI(java.util.logging)は見づらいのでlogbackに置き換えています。

JMXの有効化、ConcurrentMarkSweepGC、GCロギング、メモリチューニング等を含みます。(TODO)
See: roles/tomcat8/templates/tomcat/bin/setenv.sh

Manager API経由でのデプロイを可能とするため外部にポートを公開しています。
そのためのroleとuserも追加してあります。
See: roles/tomcat8/templates/tomcat/conf/tomcat-users.xml

公開したくない場合はfirewalld関係のtaskを削除してください。
See: roles/tomcat8/tasks/main.yml

Requirements
------------

対象サーバ: CentOS 7 限定 (Redhatの7系なら動くと思います)
理由: systemd, firewalld, alternatives に依存しているため。

実行サーバ: ansibleが動作する環境

Building
--------

### ansibleインストール

```shell
sudo yum install -y epel-release
sudo yum install -y --enablerepo=epel python-pip python-paramiko
sudo pip install ansible
```

### clone

```shell
git clone https://github.com/sonodar/ansible-tomcat8.git
```

### hosts設定

/etc/hosts に下記を追記。

Tomcat構築対象サーバのIPアドレス tomcat-server

例:

```
192.168.56.10 tomcat-server
```

### SSH公開鍵を対象ホストに設定

あらかじめ対象サーバに対してrootでSSHログイン可能にしておく必要があります。

```shell
sudo sed -i -e 's/^#?PermitRootLogin.*$/PermitRootLogin yes/' /etc/ssh/sshd_config
sudo service sshd restart
```

公開鍵ペアを生成して対象サーバに登録します。

```shell
ssh-keygen -t rsa
ssh-copy-id -i .ssh/id_rsa.pub root@tomcat-server
```

### ansible-playbook 実施

```shell
cd ansible-tomcat; ./ansible-build.sh
```

http://tomcat-server:8080/ にアクセスしてTomcatの画面が出れば成功。
