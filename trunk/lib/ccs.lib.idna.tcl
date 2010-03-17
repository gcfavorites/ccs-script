if {[namespace current] == "::"} {putlog "\002\00304You shouldn't use source for [info script]"; return}

pkg_add lib {idna} "Buster <buster@buster-net.ru> (c)" "1.0.0" "14-Nov-2009" \
	"Библиотека с функциями преобразования IDNA адресов"

if {[package versions [namespace current]::idna] == ""} {
	package ifneeded [namespace current]::idna 1.0.0 "namespace eval [namespace current] {source [info script]}"
	return
}

namespace eval idna {
	
	variable author      "Buster <buster@buster-net.ru> (c)"
	variable version     "1.0.0"
	variable date        "14-Nov-2009"
	variable description "Библиотека с функциями преобразования IDNA адресов"
	
	variable _np_map_nothing
	variable _general_prohibited
	variable _np_prohibit
	variable _np_prohibit_ranges
	variable _np_replacemaps
	variable _np_norm_combcls
	variable options
	
	# These Unicode codepoints are
	# mapped to nothing, See RFC3454 for details
	set _np_map_nothing {
		173 847 6150 6155 6156 6157 8203 8204 8205 8288 65024 65025 65026 65027 65028 65029 65030
		65031 65032 65033 65034 65035 65036 65037 65038 65039 65279
	}
	
	# Prohibited codepints
	set _general_prohibited {
		0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34
		35 36 37 38 39 40 41 42 43 44 47 59 60 61 62 63 64 91 92 93 94 95 96 123 124 125 126 127 12290
	}
	
	# Codepints prohibited by Nameprep
	set _np_prohibit {
		160 5760 8192 8193 8194 8195 8196 8197 8198 8199 8200 8201 8202 8203 8239 8287 12288 1757
		1807 6158 8204 8205 8232 8233 65279 65529 65530 65531 65532 65534 65535 131070 131071 196606
		196607 262142 262143 327678 327679 393214 393215 458750 458751 524286 524287 589822 589823
		655358 655359 720894 720895 786430 786431 851966 851967 917502 917503 983038 983039 1048574
		1048575 1114110 1114111 65529 65530 65531 65532 65533 832 833 8206 8207 8234 8235 8236 8237
		8238 8298 8299 8300 8301 8302 8303 917505
	}

	# Codepoint ranges prohibited by nameprep
	set _np_prohibit_ranges {
		0x80     0x9F     0x2060 0x206F 0x1D173 0x1D17A 0xE000 0xF8FF 0xF0000 0xFFFFD
		0x100000 0x10FFFD 0xFDD0 0xFDEF 0xD800  0xDFFF  0x2FF0 0x2FFB 0xE0020 0xE007F
	}

	# Replacement mappings (casemapping, replacement sequences, ...)
	array set _np_replacemaps {
65 97 66 98 67 99 68 100 69 101 70 102 71 103 72 104 73 105 74 106 75 107 76 108 77 109 78 110
79 111 80 112 81 113 82 114 83 115 84 116 85 117 86 118 87 119 88 120 89 121 90 122 181 956 192 224
193 225 194 226 195 227 196 228 197 229 198 230 199 231 200 232 201 233 202 234 203 235 204 236
205 237 206 238 207 239 208 240 209 241 210 242 211 243 212 244 213 245 214 246 216 248 217 249
218 250 219 251 220 252 221 253 222 254 223 {115 115} 256 257 258 259 260 261 262 263 264 265
266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286 287 288 289
290 291 292 293 294 295 296 297 298 299 300 301 302 303 304 {105 775} 306 307 308 309 310 311
313 314 315 316 317 318 319 320 321 322 323 324 325 326 327 328 329 {700 110} 330 331 332 333
334 335 336 337 338 339 340 341 342 343 344 345 346 347 348 349 350 351 352 353 354 355 356 357
358 359 360 361 362 363 364 365 366 367 368 369 370 371 372 373 374 375 376 255 377 378 379 380
381 382 383 115 385 595 386 387 388 389 390 596 391 392 393 598 394 599 395 396 398 477 399 601
400 603 401 402 403 608 404 611 406 617 407 616 408 409 412 623 413 626 415 629 416 417 418 419
420 421 422 640 423 424 425 643 428 429 430 648 431 432 433 650 434 651 435 436 437 438 439 658
440 441 444 445 452 454 453 454 455 457 456 457 458 460 459 460 461 462 463 464 465 466 467 468
469 470 471 472 473 474 475 476 478 479 480 481 482 483 484 485 486 487 488 489 490 491 492 493
494 495 496 {106 780} 497 499 498 499 500 501 502 405 503 447 504 505 506 507 508 509 510 511
512 513 514 515 516 517 518 519 520 521 522 523 524 525 526 527 528 529 530 531 532 533 534 535
536 537 538 539 540 541 542 543 544 414 546 547 548 549 550 551 552 553 554 555 556 557 558 559
560 561 562 563 837 953 890 {32 953} 902 940 904 941 905 942 906 943 908 972 910 973 911 974
912 {953 776 769} 913 945 914 946 915 947 916 948 917 949 918 950 919 951 920 952 921 953 922 954
923 955 924 956 925 957 926 958 927 959 928 960 929 961 931 963 932 964 933 965 934 966 935 967
936 968 937 969 938 970 939 971 944 {965 776 769} 962 963 976 946 977 952 978 965 979 973 980 971
981 966 982 960 984 985 986 987 988 989 990 991 992 993 994 995 996 997 998 999 1000 1001 1002 1003
1004 1005 1006 1007 1008 954 1009 961 1010 963 1012 952 1013 949 1024 1104 1025 1105 1026 1106
1027 1107 1028 1108 1029 1109 1030 1110 1031 1111 1032 1112 1033 1113 1034 1114 1035 1115 1036 1116
1037 1117 1038 1118 1039 1119 1040 1072 1041 1073 1042 1074 1043 1075 1044 1076 1045 1077 1046 1078
1047 1079 1048 1080 1049 1081 1050 1082 1051 1083 1052 1084 1053 1085 1054 1086 1055 1087 1056 1088
1057 1089 1058 1090 1059 1091 1060 1092 1061 1093 1062 1094 1063 1095 1064 1096 1065 1097 1066 1098
1067 1099 1068 1100 1069 1101 1070 1102 1071 1103 1120 1121 1122 1123 1124 1125 1126 1127 1128 1129
1130 1131 1132 1133 1134 1135 1136 1137 1138 1139 1140 1141 1142 1143 1144 1145 1146 1147 1148 1149
1150 1151 1152 1153 1162 1163 1164 1165 1166 1167 1168 1169 1170 1171 1172 1173 1174 1175 1176 1177
1178 1179 1180 1181 1182 1183 1184 1185 1186 1187 1188 1189 1190 1191 1192 1193 1194 1195 1196 1197
1198 1199 1200 1201 1202 1203 1204 1205 1206 1207 1208 1209 1210 1211 1212 1213 1214 1215 1217 1218
1219 1220 1221 1222 1223 1224 1225 1226 1227 1228 1229 1230 1232 1233 1234 1235 1236 1237 1238 1239
1240 1241 1242 1243 1244 1245 1246 1247 1248 1249 1250 1251 1252 1253 1254 1255 1256 1257 1258 1259
1260 1261 1262 1263 1264 1265 1266 1267 1268 1269 1272 1273 1280 1281 1282 1283 1284 1285 1286 1287
1288 1289 1290 1291 1292 1293 1294 1295 1329 1377 1330 1378 1331 1379 1332 1380 1333 1381 1334 1382
1335 1383 1336 1384 1337 1385 1338 1386 1339 1387 1340 1388 1341 1389 1342 1390 1343 1391 1344 1392
1345 1393 1346 1394 1347 1395 1348 1396 1349 1397 1350 1398 1351 1399 1352 1400 1353 1401 1354 1402
1355 1403 1356 1404 1357 1405 1358 1406 1359 1407 1360 1408 1361 1409 1362 1410 1363 1411 1364 1412
1365 1413 1366 1414 1415 {1381 1410} 7680 7681 7682 7683 7684 7685 7686 7687 7688 7689 7690 7691
7692 7693 7694 7695 7696 7697 7698 7699 7700 7701 7702 7703 7704 7705 7706 7707 7708 7709 7710 7711
7712 7713 7714 7715 7716 7717 7718 7719 7720 7721 7722 7723 7724 7725 7726 7727 7728 7729 7730 7731
7732 7733 7734 7735 7736 7737 7738 7739 7740 7741 7742 7743 7744 7745 7746 7747 7748 7749 7750 7751
7752 7753 7754 7755 7756 7757 7758 7759 7760 7761 7762 7763 7764 7765 7766 7767 7768 7769 7770 7771
7772 7773 7774 7775 7776 7777 7778 7779 7780 7781 7782 7783 7784 7785 7786 7787 7788 7789 7790 7791
7792 7793 7794 7795 7796 7797 7798 7799 7800 7801 7802 7803 7804 7805 7806 7807 7808 7809 7810 7811
7812 7813 7814 7815 7816 7817 7818 7819 7820 7821 7822 7823 7824 7825 7826 7827 7828 7829
7830 {104 817} 7831 {116 776} 7832 {119 778} 7833 {121 778} 7834 {97 702} 7835 7777 7840 7841
7842 7843 7844 7845 7846 7847 7848 7849 7850 7851 7852 7853 7854 7855 7856 7857 7858 7859 7860 7861
7862 7863 7864 7865 7866 7867 7868 7869 7870 7871 7872 7873 7874 7875 7876 7877 7878 7879 7880 7881
7882 7883 7884 7885 7886 7887 7888 7889 7890 7891 7892 7893 7894 7895 7896 7897 7898 7899 7900 7901
7902 7903 7904 7905 7906 7907 7908 7909 7910 7911 7912 7913 7914 7915 7916 7917 7918 7919 7920 7921
7922 7923 7924 7925 7926 7927 7928 7929 7944 7936 7945 7937 7946 7938 7947 7939 7948 7940 7949 7941
7950 7942 7951 7943 7960 7952 7961 7953 7962 7954 7963 7955 7964 7956 7965 7957 7976 7968 7977 7969
7978 7970 7979 7971 7980 7972 7981 7973 7982 7974 7983 7975 7992 7984 7993 7985 7994 7986 7995 7987
7996 7988 7997 7989 7998 7990 7999 7991 8008 8000 8009 8001 8010 8002 8011 8003 8012 8004 8013 8005
8016 {965 787} 8018 {965 787 768} 8020 {965 787 769} 8022 {965 787 834} 8025 8017 8027 8019
8029 8021 8031 8023 8040 8032 8041 8033 8042 8034 8043 8035 8044 8036 8045 8037 8046 8038 8047 8039
8064 {7936 953} 8065 {7937 953} 8066 {7938 953} 8067 {7939 953} 8068 {7940 953} 8069 {7941 953}
8070 {7942 953} 8071 {7943 953} 8072 {7936 953} 8073 {7937 953} 8074 {7938 953} 8075 {7939 953}
8076 {7940 953} 8077 {7941 953} 8078 {7942 953} 8079 {7943 953} 8080 {7968 953} 8081 {7969 953}
8082 {7970 953} 8083 {7971 953} 8084 {7972 953} 8085 {7973 953} 8086 {7974 953} 8087 {7975 953}
8088 {7968 953} 8089 {7969 953} 8090 {7970 953} 8091 {7971 953} 8092 {7972 953} 8093 {7973 953}
8094 {7974 953} 8095 {7975 953} 8096 {8032 953} 8097 {8033 953} 8098 {8034 953} 8099 {8035 953}
8100 {8036 953} 8101 {8037 953} 8102 {8038 953} 8103 {8039 953} 8104 {8032 953} 8105 {8033 953}
8106 {8034 953} 8107 {8035 953} 8108 {8036 953} 8109 {8037 953} 8110 {8038 953} 8111 {8039 953}
8114 {8048 953} 8115 {945 953} 8116 {940 953} 8118 {945 834} 8119 {945 834 953} 8120 8112 8121 8113
8122 8048 8123 8049 8124 {945 953} 8126 953 8130 {8052 953} 8131 {951 953} 8132 {942 953}
8134 {951 834} 8135 {951 834 953} 8136 8050 8137 8051 8138 8052 8139 8053 8140 {951 953}
8146 {953 776 768} 8147 {953 776 769} 8150 {953 834} 8151 {953 776 834} 8152 8144 8153 8145
8154 8054 8155 8055 8162 {965 776 768} 8163 {965 776 769} 8164 {961 787} 8166 {965 834}
8167 {965 776 834} 8168 8160 8169 8161 8170 8058 8171 8059 8172 8165 8178 {8060 953} 8179 {969 953}
8180 {974 953} 8182 {969 834} 8183 {969 834 953} 8184 8056 8185 8057 8186 8060 8187 8061
8188 {969 953} 8360 {114 115} 8450 99 8451 {176 99} 8455 603 8457 {176 102} 8459 104 8460 104
8461 104 8464 105 8465 105 8466 108 8469 110 8470 {110 111} 8473 112 8474 113 8475 114 8476 114
8477 114 8480 {115 109} 8481 {116 101 108} 8482 {116 109} 8484 122 8486 969 8488 122 8490 107
8491 229 8492 98 8493 99 8496 101 8497 102 8499 109 8510 947 8511 960 8517 100 8544 8560 8545 8561
8546 8562 8547 8563 8548 8564 8549 8565 8550 8566 8551 8567 8552 8568 8553 8569 8554 8570 8555 8571
8556 8572 8557 8573 8558 8574 8559 8575 9398 9424 9399 9425 9400 9426 9401 9427 9402 9428 9403 9429
9404 9430 9405 9431 9406 9432 9407 9433 9408 9434 9409 9435 9410 9436 9411 9437 9412 9438 9413 9439
9414 9440 9415 9441 9416 9442 9417 9443 9418 9444 9419 9445 9420 9446 9421 9447 9422 9448 9423 9449
13169 {104 112 97} 13171 {97 117} 13173 {111 118} 13184 {112 97} 13185 {110 97} 13186 {956 97}
13187 {109 97} 13188 {107 97} 13189 {107 98} 13190 {109 98} 13191 {103 98} 13194 {112 102}
13195 {110 102} 13196 {956 102} 13200 {104 122} 13201 {107 104 122} 13202 {109 104 122}
13203 {103 104 122} 13204 {116 104 122} 13225 {112 97} 13226 {107 112 97} 13227 {109 112 97}
13228 {103 112 97} 13236 {112 118} 13237 {110 118} 13238 {956 118} 13239 {109 118} 13240 {107 118}
13241 {109 118} 13242 {112 119} 13243 {110 119} 13244 {956 119} 13245 {109 119} 13246 {107 119}
13247 {109 119} 13248 {107 969} 13249 {109 969} 13250 {97 46 109 46} 13251 {98 113}
13254 {99 8725 107 103} 13255 {99 111 46} 13256 {100 98} 13257 {103 121} 13259 {104 112}
13261 {107 107} 13262 {107 109} 13271 {112 104} 13273 {112 112 109} 13274 {112 114} 13276 {115 118}
13277 {119 98} 64256 {102 102} 64257 {102 105} 64258 {102 108} 64259 {102 102 105}
64260 {102 102 108} 64261 {115 116} 64262 {115 116} 64275 {1396 1398} 64276 {1396 1381}
64277 {1396 1387} 64278 {1406 1398} 64279 {1396 1389} 65313 65345 65314 65346 65315 65347
65316 65348 65317 65349 65318 65350 65319 65351 65320 65352 65321 65353 65322 65354 65323 65355
65324 65356 65325 65357 65326 65358 65327 65359 65328 65360 65329 65361 65330 65362 65331 65363
65332 65364 65333 65365 65334 65366 65335 65367 65336 65368 65337 65369 65338 65370 66560 66600
66561 66601 66562 66602 66563 66603 66564 66604 66565 66605 66566 66606 66567 66607 66568 66608
66569 66609 66570 66610 66571 66611 66572 66612 66573 66613 66574 66614 66575 66615 66576 66616
66577 66617 66578 66618 66579 66619 66580 66620 66581 66621 66582 66622 66583 66623 66584 66624
66585 66625 66586 66626 66587 66627 66588 66628 66589 66629 66590 66630 66591 66631 66592 66632
66593 66633 66594 66634 66595 66635 66596 66636 66597 66637 119808 97 119809 98 119810 99 119811 100
119812 101 119813 102 119814 103 119815 104 119816 105 119817 106 119818 107 119819 108 119820 109
119821 110 119822 111 119823 112 119824 113 119825 114 119826 115 119827 116 119828 117 119829 118
119830 119 119831 120 119832 121 119833 122 119860 97 119861 98 119862 99 119863 100 119864 101
119865 102 119866 103 119867 104 119868 105 119869 106 119870 107 119871 108 119872 109 119873 110
119874 111 119875 112 119876 113 119877 114 119878 115 119879 116 119880 117 119881 118 119882 119
119883 120 119884 121 119885 122 119912 97 119913 98 119914 99 119915 100 119916 101 119917 102
119918 103 119919 104 119920 105 119921 106 119922 107 119923 108 119924 109 119925 110 119926 111
119927 112 119928 113 119929 114 119930 115 119931 116 119932 117 119933 118 119934 119 119935 120
119936 121 119937 122 119964 97 119966 99 119967 100 119970 103 119973 106 119974 107 119977 110
119978 111 119979 112 119980 113 119982 115 119983 116 119984 117 119985 118 119986 119 119987 120
119988 121 119989 122 120016 97 120017 98 120018 99 120019 100 120020 101 120021 102 120022 103
120023 104 120024 105 120025 106 120026 107 120027 108 120028 109 120029 110 120030 111 120031 112
120032 113 120033 114 120034 115 120035 116 120036 117 120037 118 120038 119 120039 120 120040 121
120041 122 120068 97 120069 98 120071 100 120072 101 120073 102 120074 103 120077 106 120078 107
120079 108 120080 109 120081 110 120082 111 120083 112 120084 113 120086 115 120087 116 120088 117
120089 118 120090 119 120091 120 120092 121 120120 97 120121 98 120123 100 120124 101 120125 102
120126 103 120128 105 120129 106 120130 107 120131 108 120132 109 120134 111 120138 115 120139 116
120140 117 120141 118 120142 119 120143 120 120144 121 120172 97 120173 98 120174 99 120175 100
120176 101 120177 102 120178 103 120179 104 120180 105 120181 106 120182 107 120183 108 120184 109
120185 110 120186 111 120187 112 120188 113 120189 114 120190 115 120191 116 120192 117 120193 118
120194 119 120195 120 120196 121 120197 122 120224 97 120225 98 120226 99 120227 100 120228 101
120229 102 120230 103 120231 104 120232 105 120233 106 120234 107 120235 108 120236 109 120237 110
120238 111 120239 112 120240 113 120241 114 120242 115 120243 116 120244 117 120245 118 120246 119
120247 120 120248 121 120249 122 120276 97 120277 98 120278 99 120279 100 120280 101 120281 102
120282 103 120283 104 120284 105 120285 106 120286 107 120287 108 120288 109 120289 110 120290 111
120291 112 120292 113 120293 114 120294 115 120295 116 120296 117 120297 118 120298 119 120299 120
120300 121 120301 122 120328 97 120329 98 120330 99 120331 100 120332 101 120333 102 120334 103
120335 104 120336 105 120337 106 120338 107 120339 108 120340 109 120341 110 120342 111 120343 112
120344 113 120345 114 120346 115 120347 116 120348 117 120349 118 120350 119 120351 120 120352 121
120353 122 120380 97 120381 98 120382 99 120383 100 120384 101 120385 102 120386 103 120387 104
120388 105 120389 106 120390 107 120391 108 120392 109 120393 110 120394 111 120395 112 120396 113
120397 114 120398 115 120399 116 120400 117 120401 118 120402 119 120403 120 120404 121 120405 122
120432 97 120433 98 120434 99 120435 100 120436 101 120437 102 120438 103 120439 104 120440 105
120441 106 120442 107 120443 108 120444 109 120445 110 120446 111 120447 112 120448 113 120449 114
120450 115 120451 116 120452 117 120453 118 120454 119 120455 120 120456 121 120457 122 120488 945
120489 946 120490 947 120491 948 120492 949 120493 950 120494 951 120495 952 120496 953 120497 954
120498 955 120499 956 120500 957 120501 958 120502 959 120503 960 120504 961 120505 952 120506 963
120507 964 120508 965 120509 966 120510 967 120511 968 120512 969 120531 963 120546 945 120547 946
120548 947 120549 948 120550 949 120551 950 120552 951 120553 952 120554 953 120555 954 120556 955
120557 956 120558 957 120559 958 120560 959 120561 960 120562 961 120563 952 120564 963 120565 964
120566 965 120567 966 120568 967 120569 968 120570 969 120589 963 120604 945 120605 946 120606 947
120607 948 120608 949 120609 950 120610 951 120611 952 120612 953 120613 954 120614 955 120615 956
120616 957 120617 958 120618 959 120619 960 120620 961 120621 952 120622 963 120623 964 120624 965
120625 966 120626 967 120627 968 120628 969 120647 963 120662 945 120663 946 120664 947 120665 948
120666 949 120667 950 120668 951 120669 952 120670 953 120671 954 120672 955 120673 956 120674 957
120675 958 120676 959 120677 960 120678 961 120679 952 120680 963 120681 964 120682 965 120683 966
120684 967 120685 968 120686 969 120705 963 120720 945 120721 946 120722 947 120723 948 120724 949
120725 950 120726 951 120727 952 120728 953 120729 954 120730 955 120731 956 120732 957 120733 958
120734 959 120735 960 120736 961 120737 952 120738 963 120739 964 120740 965 120741 966 120742 967
120743 968 120744 969 120763 963 1017 963 7468 97 7469 230 7470 98 7472 100 7473 101 7474 477
7475 103 7476 104 7477 105 7478 106 7479 107 7480 108 7481 109 7482 110 7484 111 7485 547 7486 112
7487 114 7488 116 7489 117 7490 119 8507 {102 97 120} 12880 {112 116 101} 13004 {104 103}
13006 {101 118} 13007 {108 116 100} 13178 {105 117} 13278 {118 8725 109} 13279 {97 8725 109}
	}
	
	# Normalization Combining Classes; Code Points not listed
	# got Combining Class 0.
	array set _np_norm_combcls  {
820 1 821 1 822 1 823 1 824 1 2364 7 2492 7 2620 7 2748 7 2876 7 3260 7 4151 7 12441 8 12442 8
2381 9 2509 9 2637 9 2765 9 2893 9 3021 9 3149 9 3277 9 3405 9 3530 9 3642 9 3972 9 4153 9 5908 9
5940 9 6098 9 1456 10 1457 11 1458 12 1459 13 1460 14 1461 15 1462 16 1463 17 1464 18 1465 19
1467 20 1468 21 1469 22 1471 23 1473 24 1474 25 64286 26 1611 27 1612 28 1613 29 1614 30 1615 31
1616 32 1617 33 1618 34 1648 35 1809 36 3157 84 3158 91 3640 103 3641 103 3656 107 3657 107 3658 107
3659 107 3768 118 3769 118 3784 122 3785 122 3786 122 3787 122 3953 129 3954 130 3962 130 3963 130
3964 130 3965 130 3968 130 3956 132 801 202 802 202 807 202 808 202 795 216 3897 216 119141 216
119142 216 119150 216 119151 216 119152 216 119153 216 119154 216 12330 218 790 220 791 220 792 220
793 220 796 220 797 220 798 220 799 220 800 220 803 220 804 220 805 220 806 220 809 220 810 220
811 220 812 220 813 220 814 220 815 220 816 220 817 220 818 220 819 220 825 220 826 220 827 220
828 220 839 220 840 220 841 220 845 220 846 220 851 220 852 220 853 220 854 220 1425 220 1430 220
1435 220 1443 220 1444 220 1445 220 1446 220 1447 220 1450 220 1621 220 1622 220 1763 220 1770 220
1773 220 1841 220 1844 220 1847 220 1848 220 1849 220 1851 220 1852 220 1854 220 1858 220 1860 220
1862 220 1864 220 2386 220 3864 220 3865 220 3893 220 3895 220 4038 220 6459 220 8424 220 119163 220
119164 220 119165 220 119166 220 119167 220 119168 220 119169 220 119170 220 119178 220 119179 220
1434 222 1453 222 6441 222 12333 222 12334 224 12335 224 119149 226 1454 228 6313 228 12331 228
768 230 769 230 770 230 771 230 772 230 773 230 774 230 775 230 776 230 777 230 778 230 779 230
780 230 781 230 782 230 783 230 784 230 785 230 786 230 787 230 788 230 829 230 830 230 831 230
832 230 833 230 834 230 835 230 836 230 838 230 842 230 843 230 844 230 848 230 849 230 850 230
855 230 867 230 868 230 869 230 870 230 871 230 872 230 873 230 874 230 875 230 876 230 877 230
878 230 879 230 1155 230 1156 230 1157 230 1158 230 1426 230 1427 230 1428 230 1429 230 1431 230
1432 230 1433 230 1436 230 1437 230 1438 230 1439 230 1440 230 1441 230 1448 230 1449 230 1451 230
1452 230 1455 230 1476 230 1552 230 1553 230 1554 230 1555 230 1556 230 1557 230 1619 230 1620 230
1623 230 1624 230 1750 230 1751 230 1752 230 1753 230 1754 230 1755 230 1756 230 1759 230 1760 230
1761 230 1762 230 1764 230 1767 230 1768 230 1771 230 1772 230 1840 230 1842 230 1843 230 1845 230
1846 230 1850 230 1853 230 1855 230 1856 230 1857 230 1859 230 1861 230 1863 230 1865 230 1866 230
2385 230 2387 230 2388 230 3970 230 3971 230 3974 230 3975 230 5901 230 6458 230 8400 230 8401 230
8404 230 8405 230 8406 230 8407 230 8411 230 8412 230 8417 230 8423 230 8425 230 65056 230 65057 230
65058 230 65059 230 119173 230 119174 230 119175 230 119177 230 119176 230 119210 230 119211 230
119212 230 119213 230 789 232 794 232 12332 232 863 233 866 233 861 234 862 234 864 234 865 234 837 240
	}
	
	# @var string
	set options(punycode_prefix)	"xn--"

	set options(max_ucs)			0x10FFFF

	# @var int
	set options(base)				36

	# @var int
	set options(tmin)				1

	# @var int
	set options(tmax)				26

	# @var int
	set options(skew)				38

	# @var int
	set options(damp)				700

	# @var int
	set options(initial_bias)		72

	# @var int
	set options(initial_n)			0x80

	set options(sbase)				0xAC00

	set options(lbase)				0x1100

	set options(vbase)				0x1161

	set options(tbase)				0x11a7

	# @var int
	set options(lcount)				19

	# @var int
	set options(vcount)				21

	# @var int
	set options(tcount)				28

	# vcount * tcount
	#
	# @var int
	set options(ncount)				588

	# lcount * tcount * vcount
	#
	# @var int
	set options(scount)				11172

	# Default encoding for encode()'s input and decode()'s output is UTF-8;
	# Other possible encodings are ucs4_string and ucs4_array
	# See {@link setParams()} for how to select these
	#
	# @var bool
	set options(api_encoding)		"utf8"

	# Overlong UTF-8 encodings are forbidden
	#
	# @var bool
	set options(allow_overlong)		0

	# Encode a given UTF-8 domain name.
	#
	# @param    string     $decoded     Domain name (UTF-8 or UCS-4)
	# [@param    string     $encoding    Desired input encoding, see {@link set_parameter}]
	# @return   string                  Encoded Domain name (ACE string)
	# @return   mixed                   processed string
	# @throws   Exception
	proc encode {decoded {one_time_encoding ""}} {
		variable options
		# Forcing conversion of input to UCS4 array
		# If one time encoding is given, use this, else the objects property
		switch -exact -- [expr {$one_time_encoding != "" ? $one_time_encoding : $options(api_encoding)}] {
			utf8       { set decoded [_utf8_to_ucs4 $decoded] }
			ucs4_array { }
			default    { return -code error "Unsupported input format" }
		}
		# No input, no output, what else did you expect?
		if {$decoded == ""} {return ""}
		# Anchors for iteration
		set last_begin 0
		# Output string
		set output ""

		set k 0
		foreach v $decoded {
			# Make sure to use just the plain dot
			switch -exact -- $v {
				12290 - 65294 - 65377 {
					lset decoded $k 0x2E
				}
				46 - 47 - 58 - 63 - 64 {
					# Skip first char
					if {$k} {
						set encoded [_encode [lrange $decoded $last_begin [expr $k - 1]]]
						if {$encoded != ""} {
							append output $encoded;
						} else {
							append output [_ucs4_to_utf8 [lrange $decoded $last_begin [expr $k - 1]]]
						}
						append output [format %c [lindex $decoded $k]]
					}
					set last_begin [expr $k + 1]
				}
			}
			incr k
		}
		# Catch the rest of the string
		if {$last_begin} {
			set inp_len [llength $decoded]
			set encoded [_encode [lrange $decoded $last_begin [expr $inp_len - 1]]]
			if {$encoded != ""} {
				append output $encoded
			} else {
				append output [_ucs4_to_utf8 [lrange $decoded $last_begin [expr $inp_len - 1]]]
			}
			return $output
		} else {
			if {[set output [_encode $decoded]] != ""} {
				return $output
			} else {
				return [_ucs4_to_utf8 $decoded]
			}
		}
	}

	# Decode a given ACE domain name.
	#
	# @param    string     $encoded     Domain name (ACE string)
	# @param    string     $encoding    Desired output encoding, see {@link set_parameter}
	# @return   string                  Decoded Domain name (UTF-8 or UCS-4)
	# @throws   Exception
	proc decode {input {one_time_encoding ""}} {
		variable options
		# Optionally set
		if {$one_time_encoding != ""} {
			switch -exact -- $one_time_encoding {
				utf8 - ucs4_array {}
				default {
					return -code error "Unknown encoding $one_time_encoding"
				}
			}
		}
		# Make sure to drop any newline characters around
		set input [string trim $input]

		set new_arr {}
		foreach v [split $input .] {
			if {[set conv [_decode $v]] != ""} {
				lappend new_arr $conv
			} else {
				lappend new_arr $v
			}
		}
		set return [join $new_arr .]
		# The output is UTF-8 by default, other output formats need conversion here
		# If one time encoding is given, use this, else the objects property
		switch -exact -- [expr {$one_time_encoding != "" ? $one_time_encoding : $options(api_encoding)}] {
			utf8       { return $return }
			ucs4_array { return [_utf8_to_ucs4 $return] }
			default    { return -code error "Unsupported output format" }
		}
	}


	# The actual encoding algorithm.
	#
	# @return   string
	# @throws   Exception
	proc _encode {decoded} {
		variable options
		# We cannot encode a domain name containing the Punycode prefix
		set extract [string length $options(punycode_prefix)]
		set check_pref [_utf8_to_ucs4 $options(punycode_prefix)]
		#$check_deco = array_slice($decoded, 0, $extract);
		set check_deco [lrange $decoded 0 [expr $extract - 1]]
		if {$check_pref == $check_deco} {
			return -code error "This is already a punycode string"
		}
		# We will not try to encode strings consisting of basic code points only
		set encodable 0
		foreach v $decoded {
			if {$v > 0x7a} {
				set encodable 1
				break
			}
		}
		if {!$encodable} {return ""}

		set decoded [_nameprep $decoded]

		set deco_len [llength $decoded]
		# Empty array
		if {!$deco_len} {return ""}

		# How many chars have been consumed
		set codecount 0

		# Start with the prefix; copy it to output
		#set encoded $options(punycode_prefix)

		set encoded ""
		# Copy all basic code points to output
		for {set i 0} {$i < $deco_len} {incr i} {
			set test [lindex $decoded $i]
			# Will match [0-9a-zA-Z-]
			if {(0x2F < $test && $test < 0x40)
					|| (0x40 < $test && $test < 0x5B)
					|| (0x60 < $test && $test <= 0x7B)
					|| (0x2D == $test)} {
				append encoded [format %c [lindex $decoded $i]]
				incr codecount
			}
		}
		# All codepoints were basic ones
		if {$codecount == $deco_len} {return $encoded}

		# Start with the prefix; copy it to output
		set encoded "${options(punycode_prefix)}${encoded}"

		# If we have basic code points in output, add an hyphen to the end
		if {$codecount} {append encoded "-"}
		
		# Now find and encode all non-basic code points
		set is_first 1
		set cur_code $options(initial_n)
		set bias     $options(initial_bias)
		set delta    0
		
		while {$codecount < $deco_len} {
			# Find the smallest code point >= the current code point and
			# remember the last ouccrence of it in the input
			set next_code $options(max_ucs)
			for {set i 0} {$i < $deco_len} {incr i} {
				if {[lindex $decoded $i] >= $cur_code && [lindex $decoded $i] <= $next_code} {
					set next_code [lindex $decoded $i]
				}
			}
			
			incr delta [expr ($next_code - $cur_code) * ($codecount + 1)]
			set cur_code $next_code
			
			# Scan input again and encode all characters whose code point is $cur_code
			for {set i 0} {$i < $deco_len} {incr i} {
				if {[lindex $decoded $i] < $cur_code} {
					incr delta
				} elseif {[lindex $decoded $i] == $cur_code} {
					set q $delta
					for {set k $options(base)} {1} {incr k $options(base)} {
						set t [expr {($k <= $bias) ? $options(tmin) : (($k >= $bias + $options(tmax)) ? $options(tmax) : $k - $bias)}]
						if {$q < $t} {
							break
						}
						
						append encoded [_encodeDigit [expr ceil($t + (int($q - $t) % ($options(base) - $t)))]]
						set q [expr double($q - $t) / ($options(base) - $t)]
					}
					append encoded [_encodeDigit $q]
					set bias [_adapt $delta [expr $codecount + 1] $is_first]
					incr codecount
					set delta 0
					set is_first 0
				}
			}
			
			incr delta
			incr cur_code
		}
		return $encoded
		
	}

	# The actual decoding algorithm.
	#
	# @return   string
	# @throws   Exception
	proc lset2 {var index value} {
		upvar $var n
		
		if {$index >= [llength $n]} {
			for {set i [llength $n]} {$i <= $index} {incr i} {
				lappend n 0
			}
			lset n $index $value
		} else {
			lset n $index $value
		}
		
	}
	
	proc _decode {encoded} {
		variable options
		# We do need to find the Punycode prefix
		if {![regexp -- "^$options(punycode_prefix)" $encoded]} {
			return ""
		}
		
		regsub "^$options(punycode_prefix)" $encoded {} encode_test
		
		# If nothing left after removing the prefix, it is hopeless
		if {$encode_test == ""} {return ""}

		# Find last occurence of the delimiter
		set delim_pos [string last "-" $encoded]

		if {$delim_pos > [string length $options(punycode_prefix)]} {
			for {set k [string length $options(punycode_prefix)]} {$k < $delim_pos} {incr k} {
				lappend decoded [scan [string index $encoded $k] %c]
			}
		} else {
			set decoded {}
		}

		set deco_len [llength $decoded]
		set enco_len [string length $encoded]

		# Wandering through the strings; init
		set is_first 1
		set bias     $options(initial_bias)
		set idx      0
		set char     $options(initial_n)

		for {set enco_idx [expr {$delim_pos ? ($delim_pos + 1) : 0}]} {$enco_idx < $enco_len} {incr deco_len} {
			
			set old_idx $idx
			set w 1
			for {set k $options(base)} {1} {incr k $options(base)} {
				set digit [_decodeDigit [string index $encoded $enco_idx]]
				incr enco_idx
				incr idx [expr $digit * $w]
				set t [expr {($k <= $bias) ? $options(tmin) : (($k >= $bias + $options(tmax)) ? $options(tmax) : ($k - $bias))}]
				if {$digit < $t} {break}

				set w [expr int($w * ($options(base) - $t))]
			}

			set bias     [_adapt [expr $idx - $old_idx] [expr $deco_len + 1] $is_first]
			set is_first 0
			incr char    [expr int(double($idx) / ($deco_len + 1))]
			set idx      [expr $idx % ($deco_len + 1)]

			if {$deco_len > 0} {
				# Make room for the decoded char
				for {set i $deco_len} {$i > $idx} {incr i -1} {
					lset2 decoded $i [lindex $decoded [expr $i - 1]]
				}
			}
			lset2 decoded $idx $char
			incr idx
		}
		
		return [_ucs4_to_utf8 $decoded]
		
	}

	# Adapt the bias according to the current code point and position.
	proc _adapt {delta npoints is_first} {
		variable options
		
		set delta [expr {$is_first ? int(double($delta) / $options(damp)) : int(double($delta) / 2)}]
		incr delta [expr int(double($delta) / $npoints)]
		
		for {set k 0} {$delta > [expr double(($options(base) - $options(tmin)) * $options(tmax)) / 2]} {incr k $options(base)} {
			set delta [expr int(double($delta) / ($options(base) - $options(tmin)))]
		}
		
		return [expr int($k + double(($options(base) - $options(tmin) + 1) * $delta) / ($delta + $options(skew)))]
		
	}

	# Encoding a certain digit.
	proc _encodeDigit {d} {
		return [format %c [expr int($d + 22 + 75 * ($d < 26))]]
	}

	# Decode a certain digit.
	proc _decodeDigit {cp} {
		variable options
		
		set cp [scan $cp %c]
		if {$cp == ""} {set cp 0}
		return [expr {($cp - 48 < 10) ? $cp - 22 : (($cp - 65 < 26) ? $cp - 65 : (($cp - 97 < 26) ? $cp - 97 : $options(base)))}]
		
	}

	# Do Nameprep according to RFC3491 and RFC3454.
	#
	# @param    array      $input       Unicode Characters
	# @return   string                  Unicode Characters, Nameprep'd
	# @throws   Exception
	proc _nameprep {input} {
		variable _np_map_nothing
		variable _general_prohibited
		variable _np_prohibit
		variable _np_prohibit_ranges
		variable _np_replacemaps
		
		set output {}

		# Walking through the input array, performing the required steps on each of
		# the input chars and putting the result into the output array
		# While mapping required chars we apply the cannonical ordering

		foreach v $input {
			# Map to nothing == skip that code point
			if {[lsearch -exact $_np_map_nothing $v] >= 0} {continue}

			# Try to find prohibited input
			if {[lsearch -exact $_np_prohibit $v] >= 0 || [lsearch -exact $_general_prohibited $v] >= 0} {
				return -code error "NAMEPREP: Prohibited input U+[format "%08x" $v]"
			}

			foreach {range1 range2} $_np_prohibit_ranges {
				if {$range1 <= $v && $v <= $range2} {
					return -code error "NAMEPREP: Prohibited input U+[format "%08x" $v]"
				}
			}

			# Hangul syllable decomposition
			if {0xAC00 <= $v && $v <= 0xD7AF} {
				foreach out [_hangulDecompose $v] {lappend output $out}
			} elseif {[info exist _np_replacemaps($v)]} { # There's a decomposition mapping for that code point
				foreach out [_applyCannonicalOrdering $_np_replacemaps($v)] {lappend output $out}
			} else {
				lappend output $v
			}
		}

		# Combine code points

		set last_class 0
		set last_starter 0
		set out_len [llength $output]

		for {set i 0} {$i < $out_len} {incr i} {
			set class [_getCombiningClass [lindex $output $i]]

			if {(!$last_class || $last_class != $class) && $class} {
				# Try to match
				set seq_len [expr $i - $last_starter]
				set out [_combine [lrange $output $last_starter [expr $last_starter + $seq_len - 1]]]

				# On match: Replace the last starter with the composed character and remove
				# the now redundant non-starter(s)
				if {$out != ""} {
					lset2 output $last_starter $out;

					if {[llength $out] != $seq_len} {
						for {set j [expr $i + 1]} {$j < $out_len} {incr j} {
							lset2 output [expr $j - 1] [lindex $output $j]
						}
						
						#unset($output[$out_len]);
						set output [lreplace $output $out_len $out_len]
					}

					# Rewind the for loop by one, since there can be more possible compositions
					incr i -1
					incr out_len -1
					set last_class [expr {($i == $last_starter) ? 0 : [_getCombiningClass [lindex $output [expr $i - 1]]]}]

					continue
				}
			}

			# The current class is 0
			if {!$class} {set last_starter $i}

			set last_class $class
		}
		
		return $output
		
	}

	# Decomposes a Hangul syllable
	# (see http://www.unicode.org/unicode/reports/tr15/#Hangul).
	#
	# @param    integer    $char        32bit UCS4 code point
	# @return   array                   Either Hangul Syllable decomposed or original 32bit
	#                                   value as one value array
	proc _hangulDecompose {char} {
		variable options
		
		set sindex [expr $char - $options(sbase)]
		
		if {$sindex < 0 || $sindex >= $options(scount)} {return [list $char]}
		
		set result {}
		set T [expr $options(tbase) + $sindex % $options(tcount)]
		lappend result [expr int($options(lbase) + double($sindex) / $options(ncount))]
		lappend result [expr int($options(vbase) + double($sindex % $options(ncount)) / $options(tcount))]
		
		if {$T != $options(tbase)} {lappend result $T}
		
		return $result
		
	}

	# Ccomposes a Hangul syllable
	# (see http://www.unicode.org/unicode/reports/tr15/#Hangul).
	#
	# @param    array      $input       Decomposed UCS4 sequence
	# @return   array                   UCS4 sequence with syllables composed
	proc _hangulCompose {input} {
		variable options
		
		set inp_len [llength $input]

		if {!$inp_len} {return {}}

		set result {}
		set last [lindex $input 0]
		lappend result $last; # copy first char from input to output

		for {set i 1} {$i < $inp_len} {incr i} {
			set char [lindex $input $i]

			# Find out, wether two current characters from L and V
			set lindex [expr $last - $options(lbase)]

			if {0 <= $lindex && $lindex < $options(lcount)} {
				set vindex [expr $char - $options(vbase)]

				if {0 <= $vindex && $vindex < $options(vcount)} {
					# create syllable of form LV
					set last [expr $options(sbase) + ($lindex * $options(vcount) + $vindex) * $options(tcount)]
					set out_off [expr [llength $result] - 1]
					lset2 result $out_off $last; # reset last
					
					# discard char
					continue
				}
			}
			
			# Find out, wether two current characters are LV and T
			set sindex [expr $last - $options(sbase)]
			
			if {0 <= $sindex && $sindex < $options(scount) && ($sindex % $options(tcount)) == 0} {
				set tindex [expr $char - $options(tbase)]
				
				if {0 <= $tindex && $tindex <= $options(tcount)} {
					# create syllable of form LVT
					incr last $tindex
					set out_off [expr [llength $result] - 1]
					lset2 result $out_off $last; # reset last
					
					# discard char
					continue
				}
			}
			
			# if neither case was true, just add the character
			set last $char
			lappend result $char
		}
		
		return $result
		
	}

	# Returns the combining class of a certain wide char.
	#
	# @param    integer    $char        Wide char to check (32bit integer)
	# @return   integer                 Combining class if found, else 0
	proc _getCombiningClass {char} {
		variable _np_norm_combcls
		
		if {[info exist _np_norm_combcls($char)]} {
			return $_np_norm_combcls($char)
		} else {
			return 0
		}
		
	}

	# Apllies the cannonical ordering of a decomposed UCS4 sequence.
	#
	# @param    array      $input       Decomposed UCS4 sequence
	# @return   array                   Ordered USC4 sequence
	proc _applyCannonicalOrdering {input} {
		
		set swap 1
		set size [llength $input]
		
		while {$swap} {
			set swap 0
			set last [_getCombiningClass [lindex $input 0]]
			
			for {set i 0} {$i < [expr $size - 1]} {incr i} {
				set next [_getCombiningClass [lindex $input [expr $i + 1]]]
				
				if {$next != 0 && $last > $next} {
					# Move item leftward until it fits
					for {set j [expr $i + 1]} {$j > 0} {incr j -1} {
						if {[_getCombiningClass [lindex $input [expr $j - 1]] <= $next} {break}
						
						set t [lindex $input $j]
						lset2 input $j [lindex $input [expr $j - 1]]
						lset input [expr $j - 1] $t
						set swap 1
					}
					
					# Reentering the loop looking at the old character again
					set next $last
				}
				
				set last $next
			}
		}
		
		return $input
		
	}

	# Do composition of a sequence of starter and non-starter.
	#
	# @param    array      $input       UCS4 Decomposed sequence
	# @return   array                   Ordered USC4 sequence
	proc _combine {input} {
		variable _np_replacemaps
		
		set inp_len [llength $input]
		
		# Is it a Hangul syllable?
		if {1 != $inp_len} {
			set hangul [_hangulCompose $input]
			
			# This place is probably wrong
			if {[llength $hangul] != $inp_len} {return $hangul}
		}
		
		foreach np_src [array names _np_replacemaps] {
			if {$_np_replacemaps($np_src) == $input} {return $np_src}
		}
		
		return ""
		
	}

	# This converts an UTF-8 encoded string to its UCS-4 (array) representation
	# By talking about UCS-4 we mean arrays of 32bit integers representing
	# each of the "chars". This is due to PHP not being able to handle strings with
	# bit depth different from 8. This applies to the reverse method _ucs4_to_utf8(), too.
	# The following UTF-8 encodings are supported:
	#
	# bytes bits  representation
	# 1        7  0xxxxxxx
	# 2       11  110xxxxx 10xxxxxx
	# 3       16  1110xxxx 10xxxxxx 10xxxxxx
	# 4       21  11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
	# 5       26  111110xx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
	# 6       31  1111110x 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
	#
	# Each x represents a bit that can be used to store character data.
	proc _utf8_to_ucs4 {input} {
		variable options
		
		set output {}
		set out_len 0
		set inp_len [string length $input]
		set mode "next"
		set test "none"
		for {set k 0} {$k < $inp_len} {incr k} {
			set v [scan [string index $input $k] %c]; # Extract byte from input string
			if {$v < 128} { # We found an ASCII char - put into stirng as is
				#$output[$out_len] = $v;
				lset2 output $out_len $v
				incr out_len
				if {"add" == $mode} {
					return -code error "Conversion from UTF-8 to UCS-4 failed: malformed input at byte $k"
				}
				continue
			}
			if {"next" == $mode} { # Try to find the next start byte; determine the width of the Unicode char
				set start_byte $v
				set mode "add"
				set test "range"
				if {$v >> 5 == 6} { # &110xxxxx 10xxxxx
					set next_byte 0; # Tells, how many times subsequent bitmasks must rotate 6bits to the left
					set v [expr ($v - 192) << 6]
				} elseif {$v >> 4 == 14} { # &1110xxxx 10xxxxxx 10xxxxxx
					set next_byte 1
					set v [expr ($v - 224) << 12]
				} elseif {$v >> 3 == 30} { # &11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
					set next_byte 2
					set v [expr ($v - 240) << 18]
				} elseif {$v >> 2 == 62} { # &111110xx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
					set next_byte 3
					set v [expr ($v - 248) << 24]
				} elseif {$v >> 1 == 126} { # &1111110x 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx 10xxxxxx
					set next_byte 4
					set v [expr ($v - 252) << 30]
				} else {
					return -code error "This might be UTF-8, but I don\'t understand it at byte $k"
				}
				if {"add" == $mode} {
					#$output[$out_len] = (int) $v;
					lset2 output $out_len $v
					incr out_len
					continue
				}
			}
			if {"add" == $mode} {
				if {!$options(allow_overlong) && $test == "range"} {
					set test "none"
					if {($v < 0xA0 && $start_byte == 0xE0) || ($v < 0x90 && $start_byte == 0xF0) || ($v > 0x8F && $start_byte == 0xF4)} {
						return -code error "Bogus UTF-8 character detected (out of legal range) at byte $k"
					}
				}
				if {$v >> 6 == 2} { # Bit mask must be 10xxxxxx
					set v [expr ($v - 128) << ($next_byte * 6)]
					#$output[($out_len - 1)] += $v;
					lset2 output [expr $out_len - 1] [expr [lindex $output [expr $out_len - 1]] + $v]
					incr next_byte -1
				} else {
					return -code error "Conversion from UTF-8 to UCS-4 failed: malformed input at byte $k"
				}
				if {$next_byte < 0} {set mode "next"}
			}
		}
		return $output
		
	}

	# Convert UCS-4 array into UTF-8 string.
	proc _ucs4_to_utf8 {input} {
		
		set output ""
		
		foreach v $input {
			if {$v < 128} {
				# 7bit are transferred literally
				append output [format %c $v]
			} elseif {$v < 1 << 11} {
				# 2 bytes
				append output [format %c [expr (192 + ($v >> 6))]]
				append output [format %c [expr (128 + ($v & 63))]]
			} elseif {$v < 1 << 16} {
				# 3 bytes
				append output [format %c [expr (224 + ($v >> 12))]]
				append output [format %c [expr (128 + (($v >> 6) & 63))]]
				append output [format %c [expr (128 + ($v & 63))]]
			} elseif {$v < 1 << 21} {
				# 4 bytes
				append output [format %c [expr (240 + ($v >> 18))]]
				append output [format %c [expr (128 + (($v >> 12) & 63))]]
				append output [format %c [expr (128 + (($v >>  6) & 63))]]
				append output [format %c [expr (128 + ($v & 63))]]
			} elseif {$v < 1 << 26} {
				# 5 bytes
				append output [format %c [expr (248 + ($v >> 24))]]
				append output [format %c [expr (128 + (($v >> 18) & 63))]]
				append output [format %c [expr (128 + (($v >> 12) & 63))]]
				append output [format %c [expr (128 + (($v >>  6) & 63))]]
				append output [format %c [expr (128 + ($v & 63))]]
			} elseif {$v < 1 << 31} {
				# 6 bytes
				append output [format %c [expr (252 + ($v >> 30))]]
				append output [format %c [expr (128 + (($v >> 24) & 63))]]
				append output [format %c [expr (128 + (($v >> 18) & 63))]]
				append output [format %c [expr (128 + (($v >> 12) & 63))]]
				append output [format %c [expr (128 + (($v >>  6) & 63))]]
				append output [format %c [expr (128 + ($v & 63))]]
			} else {
				return -code error "Conversion from UCS-4 to UTF-8 failed: malformed input at byte"
			}
		}
		return $output
		
	}
	
}

package provide [namespace current]::idna $idna::version
