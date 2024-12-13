Install `Mysql` with specific version. Only supported on `Ubuntu`. It expects a full url to the bundle file from the [archive](https://downloads.mysql.com/archives/community/), eg: [url](https://downloads.mysql.com/archives/get/p/23/file/mysql-server_5.7.12-1ubuntu15.10_amd64.deb-bundle.tar) and the `root` password.

When installing older versions of Mysql, you also need to run the compatible version of `Ubuntu`, this is because `Mysql` depends on specific packages versions. You can see which version of `Ubuntu` works with witch version of `Mysql` on the archive website. You may also need to change the `Python` module `python3-mysqldb` to `python-mysqldb` on older `Ubuntu` versions that don't support `Python 3`.

## TODO
Create a map that maps the `Mysql` versions to `Ubuntu` versions and then:
- before the install check that the `Mysql` version is supported on the OS version
- install the appropriate `Python mysqldb` packages based on the `Python` version installed
