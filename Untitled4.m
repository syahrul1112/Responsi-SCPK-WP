%penyelesaian kasus menggunakan metode WP 
clc;clear; %untuk membersihkan jendela command windows 
data = xlsread('Real estate valuation data set.xlsx', 'C2:E51');
data1 = xlsread('Real estate valuation data set', 'H2:H51'); %membaca file Real estate valuation data set.xlsx
x = [data data1];
k = [1,0,1,0]; %jenis kriteria 1 untuk keuntungan 0 untuk biaya
w = [3, 5, 4, 1]; %Nilai bobot tiap kriteria 
%tahapan pertama, perbaikan bobot
[m n]=size (x); %inisialisasi ukuran x 
w = w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot

%tahapan kedua, melakukan perhitungan vektor(S) per baris (alternatif) 
for j=1:n, 
    if k(j)==0, 
        w(j)=-1*w(j); 
    end; 
end; 
for i=1:m, 
    S(i)=prod(x(i,:).^w); 
end;

%tahapan ketiga, proses perangkingan 
V= S/sum(S)

B = sort(V, 'descend'); %sorting dari terbesar

opts = detectImportOptions('Real estate valuation data set.xlsx');
opts.SelectedVariableNames = (1);
rekomendasi = readmatrix('Real estate valuation data set.xlsx', opts); %membaca file Real estate valuation data set.xlsx

for i=1:5 %mengambil data peringkat 1 sampai 5
    for j=1:m
        if(B(i) == V(j))
            alternatif(i) = "nomor " + rekomendasi(j);
            break;
        end
    end
end

alternatif