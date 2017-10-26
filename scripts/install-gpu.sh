# This script is designed to work with ubuntu 16.04 LTS

sudo apt-get update && apt-get --assume-yes upgrade
sudo apt-get --assume-yes install tmux build-essential gcc g++ make binutils
sudo apt-get --assume-yes install software-properties-common

wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1604_9.0.176-1_amd64.deb
sudo apt-get update
sudo apt-get -y install cuda
sudo modprobe nvidia
nvidia-smi

mkdir downloads
cd downloads
wget https://repo.continuum.io/archive/Anaconda2-4.2.0-Linux-x86_64.sh
bash Anaconda2-4.2.0-Linux-x86_64.sh -b
echo "export PATH=\"$HOME/anaconda2/bin:\$PATH\"" >> ~/.bashrc
export PATH="$HOME/anaconda2/bin:$PATH"
conda install -y bcolz
conda upgrade -y --all

pip install theano
echo "[global]
device = gpu
floatX = float32

[cuda]
root = /usr/local/cuda" > ~/.theanorc

chown -R ubuntu /home/ubuntu/.theano
chown -R 775 /home/ubuntu/.theano

pip install keras
mkdir ~/.keras
echo '{
    "image_dim_ordering": "th",
    "epsilon": 1e-07,
    "floatx": "float32",
    "backend": "theano"
}' > ~/.keras/keras.json

wget http://platform.ai/files/cudnn.tgz
tar -zxf cudnn.tgz
cd cuda
sudo cp lib64/* /usr/local/cuda/lib64/
sudo cp include/* /usr/local/cuda/include/

jupyter notebook --generate-config
jupass=`python -c "from notebook.auth import passwd; print(passwd())"`
echo "c.NotebookApp.password = u'"$jupass"'" >> $HOME/.jupyter/jupyter_notebook_config.py
echo "c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False" >> $HOME/.jupyter/jupyter_notebook_config.py
mkdir nbs

# from the setup process
# pip / unzip is not installed by the script. cliff needed for kaggle-cli
sudo apt install python-pip
pip install --upgrade cliff
pip install kaggle-cli
sudo apt-get install unzip

# otherwise jupyter notebook does not work properly
pip install backports.shutil_get_terminal_size

# emacs
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# Setup for Kaggle Competition
cd
cd fast-ai
mkdir data
cd data
mkdir dogs-cats-redux
cd dogs-cats-redux
mkdir models

# tree and some aliases
sudo apt-get install tree
echo >> ~/.bashrc
echo "# some aliases" >> ~/.bashrc
echo "alias ..='cd ..'" >> ~/.bashrc
echo "alias ll='ls -alrtF --color'" >> ~/.bashrc
echo "alias du='du -ch --max-depth=1'" >> ~/.bashrc
echo "alias treeacl='tree -A -C -L 2'" >> ~/.bashrc
