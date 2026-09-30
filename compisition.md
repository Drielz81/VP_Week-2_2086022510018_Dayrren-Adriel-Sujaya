credit : CLAUDE.AI

Extracted widgets :
- SeriesCard -> Reuse.	
    what it owns : Tata letak satu series: judul, genre, badge, progres. Tanpa state.	
    what it reports upward : onTap
- SeriesSearchField	-> Readability.	
    what it owns : Tampilan kolom pencarian dan tombol hapus	
    what it reports upward : onChanged(String)
- FilterChipRow	-> Reuse. 	
    what it owns : Tata letak deretan chip	
    what it reports upward : onSelected(nilai)
- WatchProgressBar -> Readability.	
    what it owns :Tampilan bar dan teks "ditonton / total"
    what it reports upward : Tidak ada
- EmptyState -> Reuse.	
    what it owns : Ikon dan pesan
    what it reports upward : onReset (opsional, untuk membersihkan filter)