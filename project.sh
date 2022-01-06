#!/bin/bash
menuawal()
{
ans=$(zenity  --list  --text "Pilih Menu" --column  "Opsi" Daftar Cek Exit);
if [ -z $ans ];
then
peringatan;
fi
case $ans in
"Daftar") daftar;;
"Cek") cek;;
"Exit") keluar;;
"") menuawal;;
esac
}
daftar()
{
	jawabv=$(zenity --list --text "Pilih Vaksin ke-" --radiolist --column "Pilih" --column "Vaksin" 1 Pertama 2 Kedua);
	if [ "$?" == 1 ];
	then
	menuawal;
	fi
	if [ -z $jawabv ];
	then
	peringatan;
	fi
	case $jawabv in
	"Pertama") tanggal;;
	"Kedua") tanggal;;
	"") daftar;;
	esac
}
cek()
{
	if ( test -z $lokasi1 )
	then
	peringatancek;
	menuawal;
	else
	hasil;
	kumpulandata;
	fi
}
peringatancek()
{
	(zenity --warning --title "Error" --text "Daftar Vaksin Dahulu")
}
keluar()
{
	clear;
	(zenity --info --title "Terimakasih!!" --text "Jangan Lupa Tanggal Vaksin ^_^" --width 430)
	exit 0;
}
keluar2()
{
	clear;
	exit 0;
}
peringatanlokasi()
{
	zenity --warning --title "Error" --text "Pilih Puskesmas Terlebih Dahulu"
}
lokasi()
{
	lokasi1=$(zenity --list --text "Pilih Lokasi" --width 300 --height 250 --column "Opsi" "Puskesmas Asemworo (Surabaya Barat)" "Puskesmas Benowo (Surabaya Barat)" "Puskesmas Balongsari (Surabaya Barat)" "Puskesmas Gading (Surabaya Timur)" "Puskesmas Kalijudan (Surabaya Timur)" "Puskesmas Tenggilis (Surabaya Timur)" "Puskesmas Kenjeran (Surabaya Utara)" "Puskesmas Dupak (Surabaya Utara)" "Puskesmas Sidotopo (Surabaya Utara)" "Puskesmas Jagir (Surabaya Selatan)" "Puskesmas Pakis (Surabaya Selatan)" "Puskesmas Jemursari (Surabaya Selatan)")
	if [ "$?" == 1 ];
	then
	tanggal;
	fi
	if [ -z $lokasi1 ];
	then
	peringatanlokasi;
	fi
	case $lokasi1 in
	"Puskesmas Asemworo (Surabaya Barat)") menuawal;;
	"Puskesmas Benowo (Surabaya Barat)") menuawal;;
	"Puskesmas Balongsari (Surabaya Barat)") menuawal;;
	"Puskesmas Gading (Surabaya Timur)") menuawal;;
	"Puskesmas Kalijudan (Surabaya Timur)") menuawal;;
	"Puskesmas Tenggilis (Surabaya Timur)") menuawal;;
	"Puskesmas Kenjeran (Surabaya Utara)") menuawal;;
	"Puskesmas Dupak (Surabaya Utara)" ) menuawal;;
	"Puskesmas Sidotopo (Surabaya Utara)") menuawal;;
	"Puskesmas Jagir (Surabaya Selatan)") menuawal;;
	"Puskesmas Pakis (Surabaya Selatan)") menuawal;;
	"Puskesmas Jemursari (Surabaya Selatan)") menuawal;;
	"") lokasi;;
	esac
}
peringatantanggal()
{
    zenity --warning --title "Error" --text "Pilih tanggal terlebih dahulu"
}
tanggal()
{
	tanggal1=$(zenity --calendar --text "Pilih Tanggal Pendaftaran Vaksin" --title "Tanggal Pendaftaran Vaksin")
	if [ "$?" == 1 ];
	then
	peringatantanggal;
	tanggal;
	fi
	lokasi;
}
peringatan()
{
	zenity --warning --title "Error" --text "Pilih menu terlebih dahulu"
}
hasil()
{
	echo "Nama: $nama\nVaksin: $jawabv\nLokasi: $lokasi1 \nTanggal Pendaftaran: $tanggal1\n" >> data;
}
kumpulandata()
{
data=data
cetak1=$(sed -n /$nama/p $data)
kumpulandata1=$(zenity \
--text="$cetak1" \
--info \
--width=500 \
--height=200 \ )
menuawal;
}
clear
zenity --title "Pendaftaran Vaksin dan Cek Vaksin"
while [ -z $nama ];
do
nama=$(zenity --entry --text "Masukkan Nama Anda: " --title "Nama Untuk Daftar Vaksin" --width 500);
if [ "$?" == 1 ];then
(zenity --info --title "Keluar" --text "Terima kasih !!")
keluar2;
elif [ -z $nama ]; then
zenity --warning --title "Error" --text "Isi Nama Terlebih Dahulu"
fi
done
(zenity --info --title "Selamat Datang!" --text "Halo $nama Selamat Datang!" --width 430)
clear
menuawal;
