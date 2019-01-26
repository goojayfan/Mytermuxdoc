#myfreess收集

#zeronet
#install
function zeronet_install()
{
apt install clang python2 python2-dev libevent libcrypt-dev libcrypt
pip2 install msgpack gevent
cd $PREFIX/share
git clone https://github.com/HelloZeroNet/ZeroNet.git
mv ZeroNet zeronet
cd $PREFIX/bin
ln -s $PREFIX/share/zeronet/zeronet.py zeronet
termux-fix-shebang zeronet
cd ~
}





#Metasploit-framework
#Install
function msf_install()
{
#目前暂无
#See also:https://github.com/myfreess/Mytermuxdoc/wiki/metasploit
}






#Python-scrapy
#install
function scrapy_install()
{
pkg install python python-dev clang libffi-dev libxml2-dev libxslt-dev openssl openssl-dev openssl-tool -y
ln -s $PREFIX/include/libxml2/libxml $PREFIX/include/libxml
pip3 install scrapy
}




#Mariadb
#安装/Install：
function mariadb_install()
{
apt install mariadb -y
mkdir $PREFIX/etc/my.cnf.d
mysql_install_db
}



#caddy(with filemanager)
#install
function filemanager_install()
{
cd ~
curl https://getcaddy.com | \
bash -s personal http.filemanager
#编写配置文件
#Caddyfile
cat > ~/Caddyfile <<EOF
:8080 {
filemanager / /sdcard
timeouts none
gzip
}
EOF
}



#Python-pynacl
#install
function pynacl_install()
{
apt install clang python python-dev libsodium libsodium-dev
export SODIUM_INSTALL=system
pip install pynacl
}




#Python-pillow
#install
function pillow_install()
{
apt install python python-dev ndk-sysroot clang make libjpeg-turbo-dev -y
pip install pillow
}



#Python-jupyter
#Jupyter notebook（http://jupyter.org/） 是一种 Web 应用，能让用户将说明文本、数学方程、代码和可视化内容全部组合到一个易于共享的文档中。
#install
function jupyter_install()
{
apt install clang python python-dev fftw libzmq libzmq-dev -y
LDFLAGS="-lm -lcompiler_rt" pip install jupyter
}






#ruby-nokogiri
#install
function nokogiri_install()
{
apt install libxml2-dev libxslt-dev ruby ruby-dev -y
gem install nokogiri -- --use-system-libraries
}



#codiad
#一个webIDE
#install
function codiad_install()
{
wget https://gist.githubusercontent.com/rnauber/9f579d1480db4cc5a9a3c97c00c52fb9/raw/75b25c246c29505a91d9c5b9264ea8ab70ee1ca5/install_codiad.sh -O- | bash
}


#jekyll
function jekyll_install()
{
pkg in ruby-dev libffi-dev clang make    
gem install jekyll
}


function pylxml_install()
{
apt install libxml2 libxml2-dev libxslt libxslt-dev openssl libffi libffi-dev openssl-tool openssl-dev fftw fftw-dev libzmq libzmq-dev freetype freetype-dev pkg-config scrypt -y&&pkg install libcrypt libcrypt-dev ccrypt libgcrypt libgcrypt-dev libpng libpng-dev
apt-get install clang
pip install lxml	
}



#end?no!
#realend