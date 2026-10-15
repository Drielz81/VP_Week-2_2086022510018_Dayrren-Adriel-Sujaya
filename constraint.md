| Screenshot | Constraint Violated | Fix |
|---|---|---|
|![alt text](error1.png)|Row memberi anak non-flex lebar tak terbatas, jadi teks tidak tahu harus membungkus|Expanded(child: Text(...))|
|![alt text](error2.png)|Column tidak bisa lebih tinggi dari ruang yang diberikan induknya dan tidak menggulir|hapus tinggi tetap|
|![alt text](error3.png)|“parent sets position”. Row sebagai parent yang menentukan posisi anak di sumbu silang (vertikal), dan CrossAxisAlignment.baseline hanya bermakna untuk anak yang punya garis dasar teks|CrossAxisAlignment.stretch|