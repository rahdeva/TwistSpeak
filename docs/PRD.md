# Product Requirements Document

## TwistSpeak: Tongue Twister

| Informasi | Detail |
|---|---|
| **Document Version** | 1.0 |
| **Document Status** | Product Definition Draft |
| **Date** | 18 July 2026 |
| **Product Name** | TwistSpeak |
| **Full Product Name** | TwistSpeak: Tongue Twister |
| **Product Type** | Gamified Educational Application |
| **Platform** | iPhone and iPad |
| **Operating System** | iOS and iPadOS |
| **Primary Framework** | Speech |
| **Secondary Framework** | AVFoundation |
| **Primary Audience** | Students aged 9–14 |
| **Product Category** | Education & Growth |
| **Tagline** | Twist Your Words. Train Your Voice. |
| **Core Phrase** | Listen. Twist. Speak. Master. |

---

## 1. Executive Summary

**TwistSpeak** adalah aplikasi latihan pronunciation dan speaking fluency bahasa Inggris berbasis gamifikasi yang menggunakan tongue twister sebagai metode latihan utama.

Pengguna mendengarkan contoh pengucapan, mempelajari kata atau bunyi yang sulit, merekam suara mereka, lalu menerima hasil evaluasi berdasarkan kecocokan ucapan dengan teks target. Aplikasi menampilkan kata yang dikenali dengan benar, salah, tertukar, tambahan, atau terlewat, sekaligus mengukur durasi berbicara dan perkembangan performa pengguna.

TwistSpeak memanfaatkan:

- **AVFoundation** untuk mengatur audio session, memutar contoh pronunciation, dan merekam suara pengguna.
- **Speech** untuk mengenali serta mentranskripsikan ucapan pengguna.
- Sistem perbandingan teks untuk mengevaluasi word accuracy, completion, dan speaking speed.
- Gamifikasi berupa Stars, Twist Points, badges, levels, streaks, dan personal records.

Prinsip utama produk adalah:

> **Clear speech before fast speech.**

Pengguna harus mampu mengucapkan seluruh kata dengan jelas dan lengkap sebelum memperoleh skor tinggi dari kecepatan.

---

## 2. Problem Statement

Pelajar yang mempelajari bahasa Inggris sering mengetahui cara membaca sebuah kata, tetapi masih mengalami kesulitan ketika harus mengucapkannya secara jelas dan lancar.

Latihan pronunciation konvensional memiliki beberapa kendala:

1. Pengguna tidak selalu memiliki guru atau pendamping yang dapat memberikan koreksi langsung.
2. Latihan pengucapan sering terasa repetitif dan kurang menarik.
3. Pengguna sulit mengetahui kata mana yang salah, terlewat, atau tidak terdengar jelas.
4. Pengguna tidak memiliki ukuran perkembangan yang mudah dipahami.
5. Banyak aplikasi hanya menyediakan audio untuk ditirukan tanpa memberikan evaluasi interaktif.
6. Pengguna sering mengejar kecepatan tanpa memperhatikan ketepatan pengucapan.

Tongue twister dapat membantu pengguna berlatih artikulasi, ritme, konsentrasi, dan kelancaran berbicara. Namun, tanpa sistem evaluasi dan motivasi yang tepat, latihan ini dapat terasa membingungkan atau membuat frustrasi.

---

## 3. Product Vision

Membantu pelajar meningkatkan kejelasan pengucapan dan kelancaran berbicara bahasa Inggris melalui latihan tongue twister yang singkat, interaktif, terukur, dan menyenangkan.

TwistSpeak harus memberikan pengalaman seperti memiliki pronunciation practice partner yang:

- Mendemonstrasikan pengucapan.
- Mendengarkan pengguna berbicara.
- Menunjukkan bagian yang berhasil dan perlu diperbaiki.
- Mendorong pengguna mencoba kembali.
- Memvisualisasikan perkembangan belajar.
- Mengubah latihan berulang menjadi tantangan permainan.

---

## 4. Product Mission

TwistSpeak bertujuan untuk mengubah latihan pronunciation yang repetitif menjadi aktivitas speaking yang:

- Mudah dimulai.
- Singkat untuk diselesaikan.
- Aman untuk melakukan kesalahan.
- Jelas hasil evaluasinya.
- Mendorong perbaikan bertahap.
- Menyenangkan untuk dilakukan secara konsisten.

---

## 5. Challenge Statement

My Priority Framework is **Speech** because **speech recognition is the primary capability required to recognize, transcribe, and evaluate users’ spoken tongue twisters during English pronunciation and speaking-fluency practice.**

---

## 6. Refined Challenge Statement

Utilize **Speech** and **AVFoundation** to **play clear tongue-twister pronunciation examples, record and recognize users’ spoken attempts, identify correct, incorrect, additional, or missing words, measure speaking duration, and deliver interactive audio-visual feedback** for **students aged 9–14** when **practicing English pronunciation, articulation, rhythm, and speaking fluency**.

---

## 7. Challenge Response

### English

**Gamified English pronunciation and speaking-fluency application** that utilizes **Speech** and **AVFoundation** to **play tongue-twister pronunciation examples, record and transcribe users’ spoken attempts, compare their speech with target sentences, identify inaccurate or missing words, measure speaking duration, and provide immediate audio-visual feedback** for **students aged 9–14** when **practicing English pronunciation, articulation, rhythm, fluency, and speaking confidence**.

### Indonesian

**Aplikasi latihan pronunciation dan kelancaran berbicara bahasa Inggris berbasis gamifikasi** yang memanfaatkan **Speech** dan **AVFoundation** untuk **memutar contoh pelafalan tongue twister, merekam dan mentranskripsikan ucapan pengguna, membandingkan hasil pengenalan suara dengan kalimat target, mengidentifikasi kata yang benar, salah, tertukar, tambahan, atau terlewat, mengukur durasi berbicara, serta memberikan umpan balik audio dan visual secara langsung** kepada **pelajar usia 9–14 tahun** ketika **berlatih pelafalan, artikulasi, ritme, kelancaran, dan kepercayaan diri berbicara dalam bahasa Inggris**.

---

## 8. Product Goals

### 8.1 Primary Goals

1. Membantu pengguna meningkatkan ketepatan mengucapkan rangkaian kata bahasa Inggris.
2. Membantu pengguna meningkatkan speaking fluency melalui latihan berulang.
3. Memberikan evaluasi langsung setelah pengguna selesai berbicara.
4. Menunjukkan kata yang benar, salah, tambahan, atau terlewat.
5. Membantu pengguna meningkatkan kecepatan tanpa mengorbankan kejelasan.
6. Mendorong kebiasaan belajar melalui Daily Twist dan learning streak.
7. Membuat latihan pronunciation terasa seperti permainan, bukan tes.
8. Menampilkan perkembangan belajar yang mudah dipahami pengguna.

### 8.2 Business and Product Goals

1. Menciptakan aplikasi edukasi yang memiliki penggunaan berulang.
2. Mendorong pengguna menyelesaikan setidaknya satu latihan per sesi.
3. Membangun fondasi produk yang dapat diperluas ke pronunciation practice yang lebih luas.
4. Menghasilkan pengalaman inti yang stabil pada iPhone dan iPad.
5. Membangun diferensiasi melalui kombinasi tongue twister, speech recognition, dan gamifikasi.

---

## 9. Non-Goals

Versi pertama TwistSpeak tidak ditujukan untuk:

1. Memberikan diagnosis gangguan bicara atau terapi klinis.
2. Menggantikan guru, speech therapist, atau pronunciation coach.
3. Menilai aksen pengguna sebagai benar atau salah.
4. Memberikan evaluasi fonem atau posisi lidah secara klinis.
5. Menyelenggarakan percakapan bebas berbasis AI.
6. Menyediakan kompetisi publik secara real-time.
7. Menyediakan social feed atau pesan antarpengguna.
8. Memberikan sertifikasi kemampuan bahasa Inggris.
9. Mendukung seluruh bahasa pada rilis awal.
10. Memberikan skor pronunciation yang mengklaim presisi fonetik apabila sistem hanya menggunakan hasil transkripsi.

---

## 10. Important Product Limitation

Pada MVP, hasil evaluasi utama berasal dari teks yang dikenali oleh speech recognition.

Artinya, aplikasi dapat menilai:

- Apakah kata berhasil dikenali.
- Apakah kata sesuai dengan kalimat target.
- Apakah terdapat kata yang terlewat atau ditambahkan.
- Berapa lama pengguna menyelesaikan kalimat.
- Seberapa konsisten pengguna mencoba kembali.

Namun, transkripsi saja tidak selalu dapat membedakan:

- Pengucapan fonem yang sedikit kurang tepat.
- Posisi artikulasi pengguna.
- Kualitas aksen.
- Intonasi secara detail.
- Perbedaan bunyi yang masih dapat dikenali sebagai kata yang benar.

Karena itu, istilah yang digunakan pada MVP sebaiknya berupa:

- **Word Accuracy**
- **Speech Match**
- **Completion**
- **Speaking Speed**

Aplikasi tidak boleh mengklaim memberikan penilaian fonetik tingkat ahli tanpa sistem analisis pronunciation tambahan.

---

## 11. Target Users

### 11.1 Primary User

Pelajar usia **9–14 tahun** yang:

- Sedang mempelajari bahasa Inggris.
- Sudah dapat membaca kalimat pendek dalam bahasa Inggris.
- Ingin meningkatkan pronunciation dan fluency.
- Membutuhkan latihan yang singkat dan menarik.
- Menyukai tantangan, skor, level, dan reward.
- Berlatih secara mandiri atau bersama guru.

### 11.2 Secondary Users

#### Parents

Orang tua yang ingin memberikan aktivitas speaking bahasa Inggris yang edukatif dan terukur.

#### Teachers

Guru yang ingin menggunakan tongue twister sebagai aktivitas pronunciation atau speaking singkat di kelas.

#### Older Learners

Pengguna di luar rentang usia utama yang ingin berlatih artikulasi dan speaking speed secara kasual.

---

## 12. User Persona

### Persona 1: The Hesitant Speaker

**Name:** Naya  
**Age:** 10  
**Context:** Memahami kosakata dasar bahasa Inggris, tetapi malu berbicara karena takut salah.

#### Needs

- Feedback yang tidak menghakimi.
- Latihan singkat.
- Contoh audio yang dapat diputar ulang.
- Kesempatan mencoba berkali-kali.
- Reward setelah berhasil.

#### Pain Points

- Takut ditertawakan ketika salah.
- Tidak tahu bagian mana yang harus diperbaiki.
- Cepat bosan dengan latihan dari buku.

### Persona 2: The Speed Challenger

**Name:** Rafi  
**Age:** 13  
**Context:** Suka game dan tantangan waktu, tetapi sering berbicara terlalu cepat sehingga melewatkan kata.

#### Needs

- Timer dan personal best.
- Target kecepatan.
- Aturan bahwa akurasi harus tetap tinggi.
- Badge dan level baru.
- Hasil yang dapat dibandingkan dengan percobaan sebelumnya.

#### Pain Points

- Terlalu fokus pada kecepatan.
- Tidak menyadari kata yang hilang.
- Membutuhkan tantangan yang terus meningkat.

### Persona 3: The Classroom Teacher

**Name:** Ms. Hana  
**Role:** English teacher  
**Context:** Membutuhkan aktivitas speaking selama tiga sampai lima menit di kelas.

#### Needs

- Daftar latihan berdasarkan tingkat kesulitan.
- Instruksi sederhana.
- Audio pronunciation.
- Hasil latihan yang cepat.
- Konten berdasarkan kelompok bunyi.

---

## 13. Jobs to Be Done

### Primary Job

Ketika saya ingin meningkatkan pronunciation dan kelancaran berbicara bahasa Inggris, saya ingin mendengarkan sebuah tongue twister, mencoba mengucapkannya, dan langsung mengetahui kata mana yang benar atau perlu diperbaiki agar saya dapat berbicara dengan lebih jelas dan percaya diri.

### Supporting Jobs

1. Ketika sebuah tongue twister terasa sulit, saya ingin mendengarkannya lebih lambat.
2. Ketika saya salah mengucapkan kata tertentu, saya ingin melatih kata tersebut secara terpisah.
3. Ketika saya sudah menguasai sebuah kalimat, saya ingin mencoba mengucapkannya lebih cepat.
4. Ketika saya menyelesaikan latihan, saya ingin mendapatkan skor dan reward.
5. Ketika saya kembali menggunakan aplikasi, saya ingin mengetahui perkembangan saya.
6. Ketika saya sering salah pada bunyi tertentu, saya ingin mendapatkan rekomendasi latihan yang relevan.

---

## 14. Product Principles

### 14.1 Clear Before Fast

Ketepatan dan kelengkapan harus memiliki bobot lebih tinggi daripada kecepatan.

### 14.2 Encourage, Do Not Punish

Bahasa feedback harus mendukung proses belajar.

Gunakan:

- “Almost there.”
- “Try this word again.”
- “You improved.”
- “One more clear attempt.”

Hindari:

- “You failed.”
- “Bad pronunciation.”
- “Wrong again.”

### 14.3 Show Specific Feedback

Aplikasi harus menunjukkan kata tertentu yang perlu diperbaiki, bukan hanya memberikan skor umum.

### 14.4 Short Practice Sessions

Satu sesi idealnya dapat diselesaikan dalam waktu dua hingga lima menit.

### 14.5 Visible Improvement

Pengguna harus dapat melihat perbandingan dengan percobaan atau personal best sebelumnya.

### 14.6 Age-Appropriate Interaction

Instruksi harus singkat, tombol cukup besar, teks mudah dibaca, dan animasi tidak berlebihan.

### 14.7 Privacy by Design

Aplikasi harus meminimalkan penyimpanan rekaman suara dan data pribadi pengguna.

---

## 15. Core User Journey

### 15.1 First-Time User Journey

1. Pengguna membuka TwistSpeak.
2. Pengguna melihat penjelasan singkat tentang fungsi aplikasi.
3. Pengguna memilih bahasa antarmuka.
4. Pengguna melihat alasan aplikasi membutuhkan akses mikrofon dan speech recognition.
5. Pengguna memberikan permission.
6. Pengguna memilih tingkat awal atau mengikuti latihan pengenalan.
7. Pengguna mendengarkan tongue twister pertama.
8. Pengguna merekam suara.
9. Aplikasi menampilkan hasil.
10. Pengguna memperoleh Stars dan Twist Points.
11. Pengguna diarahkan untuk mencoba tantangan berikutnya.

### 15.2 Returning User Journey

1. Pengguna membuka aplikasi.
2. Home menampilkan Daily Twist, streak, level, dan latihan yang direkomendasikan.
3. Pengguna memilih tantangan.
4. Pengguna mendengarkan audio.
5. Pengguna merekam suara.
6. Sistem mentranskripsikan dan mengevaluasi respons.
7. Pengguna melihat feedback.
8. Pengguna memilih retry atau next challenge.
9. Progress dan reward diperbarui.

---

## 16. Information Architecture

### 16.1 Main Navigation

#### Home

Menampilkan:

- Daily Twist
- Current level
- Learning streak
- Continue Practice
- Recommended challenge
- Recent personal best

#### Practice

Menampilkan:

- Difficulty levels
- Accuracy Challenge
- Speed Challenge
- Trouble Sounds
- Mistake Review

#### Progress

Menampilkan:

- Average word accuracy
- Completed tongue twisters
- Mastered tongue twisters
- Speaking duration
- Personal bests
- Difficult words
- Learning streak

#### Profile

Menampilkan:

- Username atau profile name
- Current level
- Stars
- Twist Points
- Badges
- Unlocked themes
- Settings

---

## 17. Core Feature Requirements

### 17.1 Onboarding

#### Description

Onboarding memperkenalkan manfaat TwistSpeak dan mempersiapkan permission yang dibutuhkan.

#### Functional Requirements

**FR-ONB-01**  
Sistem harus menampilkan maksimal empat onboarding screens.

**FR-ONB-02**  
Onboarding harus menjelaskan:

- Listen to the example.
- Record your voice.
- See words to improve.
- Earn rewards and build a streak.

**FR-ONB-03**  
Sistem harus menjelaskan alasan akses mikrofon sebelum memunculkan system permission.

**FR-ONB-04**  
Sistem harus menjelaskan alasan penggunaan speech recognition.

**FR-ONB-05**  
Pengguna harus dapat melanjutkan apabila permission diberikan.

**FR-ONB-06**  
Apabila permission ditolak, sistem harus memberikan instruksi untuk mengaktifkannya melalui Settings.

#### Acceptance Criteria

- Pengguna memahami fungsi utama sebelum latihan pertama.
- Permission tidak diminta tanpa konteks.
- Pengguna yang menolak permission tidak mengalami crash.
- Terdapat tombol menuju Settings ketika akses ditolak.

### 17.2 Tongue Twister Library

#### Description

Kumpulan tongue twister yang dapat dipilih berdasarkan tingkat kesulitan dan kelompok bunyi.

#### Functional Requirements

**FR-LIB-01**  
Setiap tongue twister harus memiliki:

- Unique ID
- Title
- Target text
- Difficulty level
- Audio file atau audio source
- Target sound category
- Estimated duration
- Target completion time
- Reward value
- Optional vocabulary explanation

**FR-LIB-02**  
Konten harus dikelompokkan berdasarkan tingkat:

- Starter
- Mover
- Speaker
- Master
- Legend

**FR-LIB-03**  
Untuk MVP, konten dapat difokuskan pada:

- Starter
- Mover
- Speaker

**FR-LIB-04**  
Sistem harus dapat memfilter konten berdasarkan difficulty dan target sound.

**FR-LIB-05**  
Sistem harus menyimpan status:

- Not started
- Practicing
- Completed
- Mastered

#### Proposed MVP Content Scope

- 60 tongue twisters.
- 20 Starter.
- 20 Mover.
- 20 Speaker.
- Minimal enam kelompok bunyi.

### 17.3 Listen and Repeat

#### Description

Pengguna mendengarkan contoh pengucapan sebelum merekam suara.

#### Functional Requirements

**FR-AUD-01**  
Pengguna harus dapat memutar pronunciation audio.

**FR-AUD-02**  
Pengguna harus dapat melakukan pause dan replay.

**FR-AUD-03**  
Sistem harus menyediakan normal playback.

**FR-AUD-04**  
Sistem harus menyediakan slow playback.

**FR-AUD-05**  
Teks target harus tetap terlihat ketika audio diputar.

**FR-AUD-06**  
Kata dapat diberi visual highlight mengikuti audio apabila timing data tersedia.

**FR-AUD-07**  
Pemutaran audio harus berhenti ketika perekaman dimulai.

#### Acceptance Criteria

- Audio dapat diputar tanpa delay yang mengganggu.
- Replay dapat dilakukan tanpa batas.
- Audio tidak bercampur dengan perekaman.
- Mode lambat tetap mudah dipahami.

### 17.4 Voice Recording

#### Description

Pengguna merekam percobaan pengucapan melalui mikrofon.

#### Functional Requirements

**FR-REC-01**  
Pengguna harus menekan tombol record untuk memulai perekaman.

**FR-REC-02**  
Sistem harus menampilkan status recording secara jelas.

**FR-REC-03**  
Sistem harus menampilkan durasi perekaman.

**FR-REC-04**  
Pengguna harus dapat menghentikan perekaman secara manual.

**FR-REC-05**  
Sistem dapat menghentikan perekaman otomatis setelah batas waktu.

**FR-REC-06**  
Sistem harus mencegah perekaman apabila permission tidak tersedia.

**FR-REC-07**  
Sistem harus menangani interruption, seperti panggilan atau perubahan audio route.

**FR-REC-08**  
Rekaman sementara harus dihapus setelah evaluasi kecuali pengguna secara eksplisit menyimpannya pada fitur mendatang.

#### Suggested Maximum Duration

- Starter: 15 seconds
- Mover: 25 seconds
- Speaker: 40 seconds
- Master and Legend: ditentukan setelah pengujian konten

### 17.5 Speech Recognition

#### Description

Sistem mengubah ucapan pengguna menjadi teks.

#### Functional Requirements

**FR-SPR-01**  
Sistem harus mengirim audio perekaman ke speech recognition.

**FR-SPR-02**  
Recognition locale utama harus menggunakan English.

**FR-SPR-03**  
Sistem harus menampilkan processing state setelah perekaman.

**FR-SPR-04**  
Sistem harus menyimpan recognized transcription untuk sesi tersebut.

**FR-SPR-05**  
Sistem harus menangani recognition failure.

**FR-SPR-06**  
Sistem harus menangani ucapan yang terlalu pendek atau tidak terdeteksi.

**FR-SPR-07**  
Apabila confidence terlalu rendah, aplikasi harus meminta pengguna mencoba kembali tanpa memberikan penalti besar.

**FR-SPR-08**  
Sistem harus menampilkan pesan ketika layanan recognition tidak tersedia.

#### Error Messages

- “We couldn’t hear that clearly.”
- “Try again in a quieter place.”
- “Speech recognition is unavailable right now.”
- “Move a little closer to the microphone.”

### 17.6 Text Comparison Engine

#### Description

Sistem membandingkan hasil transkripsi dengan teks tongue twister target.

#### Processing Requirements

Sebelum perbandingan, sistem harus melakukan normalisasi:

- Mengubah teks menjadi lowercase.
- Menghapus punctuation yang tidak diperlukan.
- Menormalisasi apostrophe.
- Menormalisasi multiple spaces.
- Memisahkan teks menjadi token kata.
- Mengabaikan perbedaan kapitalisasi.

#### Word Status

Setiap kata target dapat memiliki status:

- Correct
- Incorrect
- Missing
- Replaced
- Additional
- Uncertain

#### Functional Requirements

**FR-CMP-01**  
Sistem harus membandingkan urutan kata target dan hasil transkripsi.

**FR-CMP-02**  
Sistem harus mendeteksi kata yang cocok.

**FR-CMP-03**  
Sistem harus mendeteksi kata yang hilang.

**FR-CMP-04**  
Sistem harus mendeteksi kata pengganti.

**FR-CMP-05**  
Sistem harus mendeteksi kata tambahan.

**FR-CMP-06**  
Sistem harus menghasilkan word accuracy percentage.

**FR-CMP-07**  
Sistem harus menghasilkan completion percentage.

**FR-CMP-08**  
Sistem harus mempertahankan urutan teks target ketika menampilkan feedback.

### 17.7 Instant Feedback

#### Description

Aplikasi menampilkan evaluasi segera setelah proses speech recognition selesai.

#### Feedback Components

- Recognized transcription
- Highlighted target sentence
- Word accuracy
- Completion
- Speaking duration
- Words per minute
- Overall score
- Earned Stars
- Earned Twist Points
- Personal best status
- Suggested next action

#### Visual Status

- **Green:** correct word
- **Yellow:** uncertain or needs practice
- **Red:** incorrect or missing
- **Gold:** new personal best

#### Functional Requirements

**FR-FDB-01**  
Feedback harus muncul dalam satu result screen.

**FR-FDB-02**  
Pengguna harus dapat melihat kata yang perlu diperbaiki.

**FR-FDB-03**  
Pengguna harus dapat memutar kembali pronunciation audio.

**FR-FDB-04**  
Pengguna harus dapat memilih Retry.

**FR-FDB-05**  
Pengguna harus dapat memilih Next Challenge.

**FR-FDB-06**  
Feedback harus menggunakan bahasa yang suportif.

#### Acceptance Criteria

- Pengguna dapat memahami hasil tanpa membuka halaman tambahan.
- Kata yang salah terlihat jelas.
- Retry dapat dimulai maksimal dua interaksi dari result screen.
- Result screen tidak hanya menampilkan skor numerik.

### 17.8 Accuracy Challenge

#### Description

Mode latihan yang memprioritaskan ketepatan dan kelengkapan kata.

#### Functional Requirements

**FR-ACC-01**  
Speed tidak boleh menjadi komponen utama pada mode ini.

**FR-ACC-02**  
Pengguna harus mencapai minimum completion yang ditentukan.

**FR-ACC-03**  
Reward utama berasal dari word accuracy dan completion.

**FR-ACC-04**  
Pengguna dapat mengulang latihan tanpa penalti.

#### Suggested Mastery Requirement

- Word accuracy minimal 90%.
- Completion minimal 95%.
- Maksimal dua kata salah untuk kalimat yang panjang.

Nilai dapat disesuaikan berdasarkan hasil usability testing.

### 17.9 Speed Challenge

#### Description

Mode latihan untuk meningkatkan kecepatan setelah pengguna dapat berbicara dengan cukup akurat.

#### Functional Requirements

**FR-SPD-01**  
Mode Speed hanya boleh terbuka setelah pengguna menyelesaikan latihan Accuracy untuk tongue twister tersebut.

**FR-SPD-02**  
Sistem harus menampilkan target time.

**FR-SPD-03**  
Speed score hanya berlaku apabila accuracy melewati threshold.

**FR-SPD-04**  
Sistem harus menyimpan fastest valid attempt.

**FR-SPD-05**  
Percobaan cepat dengan banyak kata hilang tidak boleh memperoleh skor tinggi.

#### Suggested Accuracy Threshold

Minimal **85% word accuracy** dan **90% completion** agar speed score dianggap valid.

### 17.10 Difficult Word Practice

#### Description

Pengguna berlatih kata tertentu sebelum mencoba seluruh tongue twister.

#### Functional Requirements

**FR-WRD-01**  
Sistem harus dapat menampilkan daftar kata sulit dari sebuah tongue twister.

**FR-WRD-02**  
Pengguna dapat mendengarkan satu kata.

**FR-WRD-03**  
Pengguna dapat merekam pengucapan satu kata.

**FR-WRD-04**  
Sistem memberikan recognized result sederhana.

**FR-WRD-05**  
Kata yang sering salah harus masuk ke Mistake Review.

### 17.11 Daily Twist

#### Description

Satu tongue twister pilihan yang tersedia setiap hari.

#### Functional Requirements

**FR-DLY-01**  
Sistem harus menampilkan satu Daily Twist pada Home.

**FR-DLY-02**  
Tingkat kesulitan harus disesuaikan dengan level pengguna.

**FR-DLY-03**  
Daily Twist memberikan bonus Twist Points.

**FR-DLY-04**  
Penyelesaian Daily Twist memperpanjang streak.

**FR-DLY-05**  
Pengguna tidak kehilangan progress latihan lain apabila melewatkan Daily Twist.

### 17.12 Mistake Review

#### Description

Sesi latihan yang mengumpulkan kata dan tongue twister yang belum dikuasai.

#### Functional Requirements

**FR-MST-01**  
Sistem harus menyimpan daftar kata yang sering salah atau terlewat.

**FR-MST-02**  
Sistem harus menyimpan tongue twister dengan skor rendah.

**FR-MST-03**  
Pengguna harus dapat memulai sesi review.

**FR-MST-04**  
Item yang berhasil dikuasai harus dapat dikeluarkan dari daftar prioritas.

**FR-MST-05**  
Review harus memprioritaskan kesalahan terbaru dan berulang.

### 17.13 Progress Tracking

#### Description

Halaman yang menampilkan perkembangan belajar pengguna.

#### Functional Requirements

**FR-PRG-01**  
Sistem harus menyimpan jumlah completed tongue twisters.

**FR-PRG-02**  
Sistem harus menyimpan mastered tongue twisters.

**FR-PRG-03**  
Sistem harus menyimpan average word accuracy.

**FR-PRG-04**  
Sistem harus menyimpan total practice time.

**FR-PRG-05**  
Sistem harus menyimpan learning streak.

**FR-PRG-06**  
Sistem harus menyimpan personal best untuk setiap tongue twister.

**FR-PRG-07**  
Sistem harus menampilkan bunyi atau kata yang paling sering perlu dilatih.

---

## 18. Gamification System

### 18.1 Stars

Stars merepresentasikan performa pada satu tongue twister.

#### Proposed Star Rules

| Stars | Requirement |
|---|---|
| **1 Star** | Latihan selesai dengan completion minimum |
| **2 Stars** | Accuracy dan completion mencapai target |
| **3 Stars** | Accuracy tinggi dan target waktu tercapai |
| **Perfect Star** | 100% completion dan hampir seluruh kata dikenali dengan benar |

### 18.2 Twist Points

Twist Points adalah reward currency yang diperoleh dari:

- Menyelesaikan latihan.
- Mencapai personal best.
- Menyelesaikan Daily Twist.
- Mempertahankan streak.
- Mencapai mastery.
- Membuka badge.
- Menyelesaikan latihan pada percobaan pertama.

Twist Points dapat digunakan untuk membuka:

- Themes
- Profile frames
- Microphone effects
- Practice backgrounds
- Sound effects
- Tongue twister card collections

Twist Points tidak boleh memberikan keuntungan terhadap hasil penilaian.

### 18.3 Badges

Proposed badges:

- First Twist
- Clear Speaker
- Perfect Accuracy
- Speed Starter
- Rhythm Keeper
- No Missing Words
- Five-Day Streak
- Ten-Day Streak
- Pronunciation Pro
- Twist Master

### 18.4 Levels

#### Proposed Level Structure

1. Starter
2. Mover
3. Speaker
4. Master
5. Legend

Level pengguna meningkat berdasarkan kombinasi:

- Completed challenges
- Mastered tongue twisters
- Stars earned
- Consistent practice

---

## 19. Scoring Model

### 19.1 Score Components

| Component | Weight | Description |
|---|---:|---|
| **Word Accuracy** | 50% | Persentase kata target yang dikenali secara tepat |
| **Completion** | 20% | Persentase bagian kalimat yang berhasil diselesaikan |
| **Speaking Speed** | 15% | Kecepatan terhadap target waktu |
| **Consistency** | 10% | Stabilitas hasil dibandingkan percobaan sebelumnya |
| **First-Try Bonus** | 5% | Bonus untuk hasil valid pada percobaan pertama |

### 19.2 Suggested Formula

**Overall Score =**

- Word Accuracy × 0.50
- Completion × 0.20
- Speed Score × 0.15
- Consistency Score × 0.10
- First-Try Bonus × 0.05

Hasil akhir dibatasi pada rentang 0–100.

### 19.3 Speed Protection Rule

Apabila word accuracy berada di bawah threshold:

- Speed score dikurangi secara signifikan, atau
- Speed score tidak dihitung.

### 19.4 No-Penalty Recognition Failure

Apabila speech recognition gagal karena masalah sistem, jaringan, atau audio yang tidak terdeteksi, percobaan tidak boleh dihitung sebagai kegagalan pengguna.

---

## 20. User Stories

### Core Practice

**US-01**  
Sebagai pelajar, saya ingin mendengarkan tongue twister agar mengetahui cara mengucapkannya.

**US-02**  
Sebagai pelajar, saya ingin memperlambat audio agar dapat mendengar setiap kata dengan jelas.

**US-03**  
Sebagai pelajar, saya ingin merekam suara agar dapat mencoba mengucapkan tongue twister.

**US-04**  
Sebagai pelajar, saya ingin melihat hasil transkripsi agar mengetahui ucapan yang dikenali aplikasi.

**US-05**  
Sebagai pelajar, saya ingin melihat kata yang salah atau terlewat agar mengetahui bagian yang perlu diperbaiki.

**US-06**  
Sebagai pelajar, saya ingin mencoba kembali agar dapat meningkatkan hasil.

### Progress and Motivation

**US-07**  
Sebagai pelajar, saya ingin melihat personal best agar termotivasi mengalahkan rekor saya.

**US-08**  
Sebagai pelajar, saya ingin memperoleh Stars dan Twist Points agar latihan terasa menyenangkan.

**US-09**  
Sebagai pelajar, saya ingin mempertahankan streak agar termotivasi berlatih setiap hari.

**US-10**  
Sebagai pelajar, saya ingin membuka level dan badges agar dapat melihat pencapaian saya.

### Adaptive Learning

**US-11**  
Sebagai pelajar, saya ingin melihat kata yang sering salah agar dapat melatihnya kembali.

**US-12**  
Sebagai pelajar, saya ingin memperoleh tantangan sesuai kemampuan agar latihan tidak terlalu mudah atau terlalu sulit.

---

## 21. MVP Scope

### 21.1 Must Have

1. Onboarding.
2. Microphone permission handling.
3. Speech recognition permission handling.
4. Tongue twister library.
5. Three difficulty levels.
6. Pronunciation audio playback.
7. Normal playback.
8. Slow playback.
9. Voice recording.
10. Speech transcription.
11. Text normalization.
12. Word-level comparison.
13. Correct, incorrect, additional, and missing word detection.
14. Word accuracy.
15. Completion percentage.
16. Speaking duration.
17. Instant feedback.
18. Retry flow.
19. Accuracy Challenge.
20. Basic Speed Challenge.
21. Personal best.
22. Stars.
23. Twist Points.
24. Daily Twist.
25. Mistake Review.
26. Basic progress page.
27. Local data persistence.
28. Error and permission states.

### 21.2 Should Have

1. Difficult Word Practice.
2. Trouble Sounds categories.
3. Badges.
4. Learning streak.
5. Unlockable themes.
6. Adaptive content recommendation.
7. iPad-specific layout.
8. English and Indonesian interface localization.

### 21.3 Could Have

1. Rhythm Challenge.
2. Classroom Practice.
3. Teacher-selected sessions.
4. Cloud synchronization.
5. User accounts.
6. Family profiles.
7. Advanced pronunciation analytics.
8. Detailed phoneme feedback.
9. Shareable achievement cards.
10. Additional languages.

### 21.4 Will Not Have in MVP

1. Public leaderboard.
2. Real-time multiplayer.
3. Social messaging.
4. AI conversation.
5. Clinical speech evaluation.
6. Subscription system.
7. User-generated public content.
8. Teacher dashboard.
9. Audio sharing between users.

---

## 22. Non-Functional Requirements

### 22.1 Performance

- Recording state harus muncul segera setelah tombol ditekan.
- Processing state harus ditampilkan ketika recognition berlangsung.
- Result screen idealnya muncul dalam beberapa detik setelah recognition selesai.
- Animasi tidak boleh mengganggu responsivitas.
- Audio playback harus stabil pada perangkat yang didukung.

### 22.2 Reliability

- Aplikasi tidak boleh crash ketika permission ditolak.
- Perekaman harus berhenti dengan aman ketika terjadi interruption.
- Progress harus tetap tersimpan setelah aplikasi ditutup.
- Recognition failure tidak boleh menghapus progress pengguna.
- Audio session harus dikembalikan ke kondisi aman setelah recording selesai.

### 22.3 Accessibility

- Mendukung Dynamic Type sejauh layout memungkinkan.
- Memiliki contrast yang cukup.
- Tidak mengandalkan warna sebagai satu-satunya bentuk feedback.
- Menyediakan icon atau label untuk status kata.
- Tombol utama memiliki ukuran sentuh yang memadai.
- Mendukung VoiceOver untuk elemen navigasi utama.
- Animasi penting tidak boleh terlalu cepat atau menyilaukan.

### 22.4 Privacy

- Hanya meminta permission yang diperlukan.
- Menjelaskan tujuan penggunaan mikrofon.
- Meminimalkan penyimpanan rekaman suara.
- Menghapus temporary recording setelah evaluasi.
- Tidak menampilkan identitas anak secara publik.
- Tidak menggunakan advertising identifier pada MVP.
- Melakukan review kepatuhan terhadap aturan privasi anak sebelum rilis publik.

### 22.5 Localization

- Konten latihan utama menggunakan bahasa Inggris.
- Instruksi dapat tersedia dalam bahasa Inggris dan Indonesia.
- Sistem perbandingan harus menggunakan locale pengenalan bahasa Inggris.
- Teks UI tidak boleh terpotong pada kedua bahasa.

---

## 23. Technical Requirements

### 23.1 AVFoundation Responsibilities

AVFoundation digunakan untuk:

- Audio session configuration.
- Pronunciation audio playback.
- Playback speed control.
- Microphone recording.
- Audio interruption handling.
- Audio route handling.
- Recording lifecycle.
- Temporary audio file management.

### 23.2 Speech Responsibilities

Speech digunakan untuk:

- Speech recognition authorization.
- English speech transcription.
- Recognition task lifecycle.
- Partial atau final recognition results.
- Recognition error handling.
- Availability monitoring.

### 23.3 Application Logic

Application layer digunakan untuk:

- Text normalization.
- Word tokenization.
- Sequence comparison.
- Score calculation.
- Reward calculation.
- Progress persistence.
- Personal best comparison.
- Daily challenge selection.
- Mistake Review prioritization.

### 23.4 Suggested Data Models

#### TongueTwister

- id
- title
- text
- difficulty
- targetSounds
- audioReference
- normalDuration
- targetDuration
- rewardPoints
- vocabularyNotes
- isDailyEligible

#### PracticeAttempt

- id
- tongueTwisterID
- date
- transcription
- wordAccuracy
- completion
- duration
- wordsPerMinute
- overallScore
- starsEarned
- pointsEarned
- isPersonalBest
- recognitionStatus

#### UserProgress

- currentLevel
- totalStars
- twistPoints
- streakCount
- completedIDs
- masteredIDs
- difficultWords
- badges
- unlockedItems
- totalPracticeTime

---

## 24. Analytics Requirements

Data analytics harus menggunakan event yang tidak menyimpan rekaman suara atau informasi pribadi sensitif.

### Proposed Events

- onboarding_started
- onboarding_completed
- microphone_permission_result
- speech_permission_result
- challenge_viewed
- pronunciation_played
- slow_audio_played
- recording_started
- recording_completed
- recognition_succeeded
- recognition_failed
- result_viewed
- retry_selected
- next_challenge_selected
- daily_twist_completed
- personal_best_achieved
- badge_unlocked
- mistake_review_started
- challenge_mastered

### Suggested Event Properties

- difficulty
- challenge_mode
- attempt_number
- duration_bucket
- accuracy_bucket
- completion_bucket
- error_type
- device_category
- interface_language

Jangan mengirim:

- Raw audio.
- Full transcription yang dapat mengandung ucapan tidak terduga.
- Nama lengkap anak.
- Informasi kontak.
- Data lokasi presisi.

---

## 25. Success Metrics

### 25.1 Product Metrics

#### Activation

- Persentase pengguna yang menyelesaikan latihan pertama.
- Persentase pengguna yang memberikan permission.
- Persentase pengguna yang mencapai result screen.

#### Engagement

- Jumlah completed challenges per active user.
- Rata-rata latihan per sesi.
- Persentase pengguna yang memilih Retry.
- Daily Twist completion rate.
- Learning streak participation.

#### Learning Progress

- Persentase pengguna yang meningkatkan accuracy dalam tiga percobaan.
- Persentase tongue twister yang mencapai mastery.
- Perubahan average word accuracy dari minggu ke minggu.
- Penurunan jumlah missing words.

#### Retention

- Day 1 retention.
- Day 7 retention.
- Weekly active users.
- Persentase pengguna yang kembali untuk Daily Twist.

#### Technical Quality

- Recognition success rate.
- Recording completion rate.
- Crash-free session rate.
- Audio playback failure rate.
- Permission-related abandonment rate.

### 25.2 Proposed Initial Targets

Target ini merupakan hipotesis awal dan harus divalidasi setelah testing:

- Minimal 70% pengguna baru menyelesaikan latihan pertama.
- Minimal 80% sesi recording mencapai result screen.
- Minimal 50% pengguna mencoba ulang setidaknya satu kali.
- Minimal 60% pengguna menunjukkan peningkatan dalam tiga percobaan.
- Crash-free sessions minimal 99.5%.
- Recognition technical success minimal 90% pada kondisi audio yang memadai.

---

## 26. Edge Cases and Error States

### Permission Denied

Tampilkan penjelasan dan tombol Open Settings.

### No Speech Detected

Minta pengguna mendekatkan perangkat dan mencoba kembali.

### Background Noise

Berikan saran untuk berpindah ke tempat lebih tenang.

### Recognition Unavailable

Simpan state latihan dan izinkan pengguna mencoba lagi nanti.

### Recording Interrupted

Berhentikan recording dengan aman dan jangan hitung sebagai attempt gagal.

### User Stops Too Early

Tampilkan bahwa kalimat belum selesai dan tawarkan retry.

### User Speaks Longer Than Maximum Duration

Hentikan recording otomatis dan evaluasi bagian yang tersedia.

### Different Words With Similar Meaning

Tetap dinilai berdasarkan target text karena mode latihan berfokus pada tongue twister yang spesifik.

### Repeated Words

Comparison engine harus mempertahankan urutan kata agar pengulangan dapat dievaluasi dengan benar.

### Child Speaks Very Softly

Berikan feedback volume tanpa mempermalukan pengguna.

### Recognition Produces Punctuation Differences

Punctuation tidak boleh memengaruhi score.

---

## 27. Content Guidelines

Semua tongue twister harus:

- Sesuai untuk usia 9–14 tahun.
- Tidak mengandung bahasa kasar.
- Tidak mengandung stereotip sensitif.
- Tidak mengandung tema seksual, kekerasan, atau penggunaan zat.
- Menggunakan kosakata yang dapat dijelaskan secara sederhana.
- Memiliki audio pronunciation yang jelas.
- Memiliki tingkat kesulitan yang konsisten.
- Diuji pada beberapa jenis aksen pengguna.
- Tidak terlalu panjang untuk level dasar.

### Content Fields

Setiap konten idealnya memiliki:

- Tongue twister text
- Simple meaning
- Difficult words
- Target sounds
- Example audio
- Difficulty
- Suggested target time
- Reward
- Optional example illustration

---

## 28. Visual and Interaction Direction

TwistSpeak tidak menggunakan maskot.

Identitas visual berfokus pada:

- Sound waves
- Microphone
- Moving letters
- Speech bubbles
- Timers
- Accuracy rings
- Rhythm indicators
- Animated word highlights
- Stars and achievement effects

### Brand Personality

- Energetic
- Encouraging
- Playful
- Modern
- Educational

### Interface Direction

- Tampilan bersih dengan satu primary action per screen.
- Tombol record menjadi elemen utama pada practice screen.
- Teks tongue twister menjadi pusat perhatian.
- Feedback kata mudah dipindai.
- Animasi reward singkat dan tidak menghambat navigasi.
- Pengguna dapat melewati animasi reward.

---

## 29. App Store Metadata Direction

### App Name

**TwistSpeak: Tongue Twister**

### Subtitle

**Pronunciation & Fluency**

### Tagline

**Twist Your Words. Train Your Voice.**

### Core Phrase

**Listen. Twist. Speak. Master.**

### Keyword Direction

- English
- Articulation
- Voice
- Accent
- Phonics
- Rhythm
- Diction
- Oral
- Reading
- Student
- Learning
- Game

---

## 30. Release Plan

### Phase 1: Prototype

Focus:

- Audio playback
- Recording
- Speech transcription
- Basic text comparison
- Word highlighting

Success condition:

Pengguna dapat menyelesaikan alur listen, record, transcribe, dan review.

### Phase 2: Core MVP

Focus:

- Content library
- Difficulty levels
- Accuracy Challenge
- Speed Challenge
- Scoring
- Stars
- Twist Points
- Personal best
- Progress persistence

Success condition:

Pengguna dapat menyelesaikan beberapa sesi dan melihat perkembangan.

### Phase 3: Engagement

Focus:

- Daily Twist
- Streak
- Mistake Review
- Badges
- Unlockable themes
- Adaptive recommendation

Success condition:

Pengguna memiliki alasan untuk kembali secara rutin.

### Phase 4: Expansion

Focus:

- Rhythm Challenge
- Advanced sound categories
- Classroom Practice
- Cloud synchronization
- Teacher or parent features
- Advanced pronunciation analysis

---

## 31. Risks and Mitigation

| Risk | Impact | Mitigation |
|---|---|---|
| Speech recognition tidak akurat untuk suara anak | Feedback dapat terasa tidak adil | Gunakan retry tanpa penalti, confidence handling, dan pengujian dengan target user |
| Lingkungan pengguna terlalu bising | Recognition failure meningkat | Berikan noise guidance dan microphone level feedback |
| Pengguna menganggap transcription score sebagai pronunciation score mutlak | Ekspektasi produk tidak sesuai | Gunakan istilah Word Accuracy dan Speech Match |
| Pengguna mengejar speed dan mengabaikan accuracy | Tujuan belajar tidak tercapai | Terapkan accuracy threshold sebelum speed score berlaku |
| Gamifikasi terlalu dominan | Fokus belajar berkurang | Reward dikaitkan dengan improvement dan mastery |
| Feedback merah membuat anak merasa gagal | Engagement menurun | Gunakan bahasa suportif dan status visual tambahan |
| Konten terlalu sulit | Frustrasi | Progressive difficulty dan adaptive recommendations |
| Permission ditolak | Core flow tidak dapat digunakan | Pre-permission explanation dan Settings recovery flow |
| Penyimpanan audio menimbulkan risiko privasi | Risiko kepercayaan dan kepatuhan | Hapus temporary recordings setelah evaluasi |

---

## 32. Dependencies

Produk bergantung pada:

- Microphone availability.
- Speech recognition availability.
- English recognition support.
- Audio pronunciation assets.
- Content review.
- Permission approval.
- Stable audio session configuration.
- Local persistence system.
- Device performance.
- User environment yang cukup tenang.

---

## 33. Open Questions

1. Apakah audio pronunciation menggunakan rekaman manusia atau text-to-speech?
2. Apakah seluruh recognition membutuhkan koneksi internet?
3. Apakah pengguna membutuhkan akun pada rilis pertama?
4. Apakah progress disimpan hanya secara lokal?
5. Apakah interface utama menggunakan bahasa Inggris atau bilingual?
6. Berapa jumlah tongue twister ideal untuk MVP?
7. Apakah Master dan Legend tersedia saat launch?
8. Apakah Rhythm Challenge masuk MVP atau versi berikutnya?
9. Apakah orang tua dapat melihat progress anak?
10. Apakah rekaman suara dapat diputar kembali oleh pengguna?
11. Apakah Twist Points digunakan hanya untuk cosmetic items?
12. Bagaimana mastery threshold disesuaikan untuk panjang kalimat yang berbeda?

---

## 34. Definition of Done for MVP

MVP dianggap siap diuji ketika:

1. Pengguna dapat menyelesaikan onboarding.
2. Permission mikrofon dan speech recognition dapat ditangani.
3. Pengguna dapat memilih tongue twister.
4. Audio pronunciation dapat diputar normal dan lambat.
5. Pengguna dapat merekam suara.
6. Ucapan dapat ditranskripsikan.
7. Hasil dapat dibandingkan dengan target text.
8. Kata benar, salah, tambahan, dan terlewat dapat ditampilkan.
9. Word accuracy dan completion dapat dihitung.
10. Speaking duration dapat dihitung.
11. Pengguna dapat melihat result screen.
12. Pengguna dapat melakukan retry.
13. Personal best dapat disimpan.
14. Stars dan Twist Points dapat diberikan.
15. Progress tetap tersedia setelah aplikasi ditutup.
16. Daily Twist dapat diselesaikan.
17. Mistake Review dapat menampilkan item yang perlu dilatih.
18. Permission denial dan recognition failure tidak menyebabkan crash.
19. Temporary audio tidak disimpan lebih lama dari yang diperlukan.
20. Core flow telah diuji bersama pengguna target.

---

## 35. Final Product Summary

| Product Element | Definition |
|---|---|
| **Product Name** | TwistSpeak |
| **Full Name** | TwistSpeak: Tongue Twister |
| **Category** | English Pronunciation and Speaking Practice |
| **Target User** | Students aged 9–14 |
| **Platform** | iPhone and iPad |
| **Primary Framework** | Speech |
| **Secondary Framework** | AVFoundation |
| **Core Interaction** | Listen, record, transcribe, compare, improve |
| **Primary Learning Goals** | Pronunciation, articulation, accuracy, rhythm, fluency, and confidence |
| **Main Gamification** | Stars, Twist Points, badges, levels, streaks, and personal records |
| **Primary Principle** | Clear speech before fast speech |
| **Mascot** | None |
| **Tagline** | Twist Your Words. Train Your Voice. |
| **Core Phrase** | Listen. Twist. Speak. Master. |

---

## 36. Key Value Proposition

**TwistSpeak mengubah latihan pronunciation yang repetitif menjadi tantangan berbicara yang singkat, terukur, dan menyenangkan. Pengguna dapat mendengarkan contoh pengucapan, mencoba berbicara, melihat kata yang berhasil dikenali, mengetahui bagian yang perlu diperbaiki, mengukur perkembangan performa, dan termotivasi untuk mencoba kembali melalui personal records serta sistem gamifikasi.**
