#!/bin/bash
FILE=`readlink -e $0`
rootdir=`dirname $FILE`
data_path=$rootdir/database_final

wget 'https://gmpsdb.cn/api/download/all/10/download/' -O $data_path/bacteria.tar.gz
wget 'https://gmpsdb.cn/api/download/all/11/download/' -O $data_path/phage.tar.gz
wget 'https://gmpsdb.cn/api/download/all/12/download/' -O $data_path/prophage.tar.gz

cd $data_path

tar -xvf $data_path/phage.tar.gz
mv new_phage_tar_gz phage
cd $data_path/phage
for target in `ls *.tar.gz`;do
    tar -xvf $target
    rm $target
done

tar -xvf $data_path/prophage.tar.gz
cd $data_path/prophage
for target in `ls *.tar.gz`;do
    tar -xvf $target
    rm $target
done

rm -rf $data_path/Bacteria/Bifidobacterium_adolescentis
for m in {1..8};do
    cd $data_path
    if [ ! -s "$data_path/bacteria_$m.tar.gz" ];then
        continue
    fi
    tar -xvf $data_path/bacteria_$m.tar.gz
    for target in `ls $data_path/bacteria_$m/*.tar.gz`;do
        cd $data_path/Bacteria
	tar -xvf $target
	rm $target
    done
done

if [ -s "$data_path/bacteria.tar.gz" ];then
    cd $data_path
    tar -xvf $data_path/bacteria.tar.gz
    for target in `ls $data_path/bacteria_tar_gz/*.tar.gz`;do
        cd $data_path/Bacteria
	tar -xvf $target
	rm $target
    done
fi
