; RUN: llc -disable-debug-info-verifier %s -mtriple=i386-apple-macosx10.6.7 -o /dev/null

; This used to crash because early dup was not ignoring debug instructions.

%struct.cpp_dir = type { %struct.cpp_dir*, i8*, i32, i8, i8**, i8*, i8* (i8*, %struct.cpp_dir*)*, i64, i32, i8 }

declare void @llvm.dbg.value(metadata, i64, metadata) nounwind readnone

define internal i8* @framework_construct_pathname(i8* %fname, %struct.cpp_dir* %dir) nounwind ssp {
entry:
  br i1 undef, label %bb33, label %bb

bb:                                               ; preds = %entry
  %tmp = icmp eq i32 undef, 0
  %tmp1 = add i32 0, 11
  call void @llvm.dbg.value(metadata !{i32 %tmp1}, i64 0, metadata !0)
  br i1 undef, label %bb18, label %bb31.preheader

bb31.preheader:                                   ; preds = %bb19, %bb
  %tmp2 = getelementptr inbounds i8* %fname, i32 0
  br label %bb31

bb18:                                             ; preds = %bb
  %tmp3 = icmp eq i32 undef, 0
  br i1 %tmp3, label %bb19, label %bb33

bb19:                                             ; preds = %bb18
  call void @foobar(i32 0)
  br label %bb31.preheader

bb22:                                             ; preds = %bb31
  %tmp4 = add i32 0, %tmp1
  call void @foobar(i32 %tmp4)
  br i1 undef, label %bb33, label %bb31

bb31:                                             ; preds = %bb22, %bb31.preheader
  br i1 false, label %bb33, label %bb22

bb33:                                             ; preds = %bb31, %bb22, %bb18, %entry
  ret i8* undef
}

declare void @foobar(i32)

!0 = metadata !{i32 590080, metadata !1, metadata !"frname_len", metadata !3, i32 517, metadata !38, i32 0} ; [ DW_TAG_auto_variable ]
!1 = metadata !{i32 589835, metadata !2, i32 515, i32 0, metadata !3, i32 19} ; [ DW_TAG_lexical_block ]
!2 = metadata !{i32 589870, i32 0, metadata !3, metadata !"framework_construct_pathname", metadata !"framework_construct_pathname", metadata !"", metadata !3, i32 515, metadata !5, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, %struct.cpp_dir*)* @framework_construct_pathname} ; [ DW_TAG_subprogram ]
!3 = metadata !{i32 589865, metadata !"darwin-c.c", metadata !"/Users/espindola/llvm/build-llvm-gcc/gcc/../../llvm-gcc-4.2/gcc/config", metadata !4} ; [ DW_TAG_file_type ]
!4 = metadata !{i32 589841, i32 0, i32 1, metadata !"/Users/espindola/llvm/build-llvm-gcc/gcc/../../llvm-gcc-4.2/gcc/config/darwin-c.c", metadata !"/Users/espindola/llvm/build-llvm-gcc/gcc", metadata !"4.2.1 (Based on Apple Inc. build 5658) (LLVM build)", i1 true, i1 true, metadata !"", i32 0} ; [ DW_TAG_compile_unit ]
!5 = metadata !{i32 589845, metadata !3, metadata !"", metadata !3, i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !6, i32 0, null} ; [ DW_TAG_subroutine_type ]
!6 = metadata !{metadata !7, metadata !9, metadata !11}
!7 = metadata !{i32 589839, metadata !3, metadata !"", metadata !3, i32 0, i64 32, i64 32, i64 0, i32 0, metadata !8} ; [ DW_TAG_pointer_type ]
!8 = metadata !{i32 589860, metadata !3, metadata !"char", metadata !3, i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ]
!9 = metadata !{i32 589839, metadata !3, metadata !"", metadata !3, i32 0, i64 32, i64 32, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ]
!10 = metadata !{i32 589862, metadata !3, metadata !"", metadata !3, i32 0, i64 8, i64 8, i64 0, i32 0, metadata !8} ; [ DW_TAG_const_type ]
!11 = metadata !{i32 589839, metadata !3, metadata !"", metadata !3, i32 0, i64 32, i64 32, i64 0, i32 0, metadata !12} ; [ DW_TAG_pointer_type ]
!12 = metadata !{i32 589846, metadata !13, metadata !"cpp_dir", metadata !13, i32 45, i64 0, i64 0, i64 0, i32 0, metadata !14} ; [ DW_TAG_typedef ]
!13 = metadata !{i32 589865, metadata !"cpplib.h", metadata !"/Users/espindola/llvm/build-llvm-gcc/gcc/../../llvm-gcc-4.2/gcc/../libcpp/include", metadata !4} ; [ DW_TAG_file_type ]
!14 = metadata !{i32 589843, metadata !3, metadata !"cpp_dir", metadata !13, i32 43, i64 352, i64 32, i64 0, i32 0, null, metadata !15, i32 0, null} ; [ DW_TAG_structure_type ]
!15 = metadata !{metadata !16, metadata !18, metadata !19, metadata !21, metadata !23, metadata !25, metadata !27, metadata !29, metadata !33, metadata !36}
!16 = metadata !{i32 589837, metadata !14, metadata !"next", metadata !13, i32 572, i64 32, i64 32, i64 0, i32 0, metadata !17} ; [ DW_TAG_member ]
!17 = metadata !{i32 589839, metadata !3, metadata !"", metadata !3, i32 0, i64 32, i64 32, i64 0, i32 0, metadata !14} ; [ DW_TAG_pointer_type ]
!18 = metadata !{i32 589837, metadata !14, metadata !"name", metadata !13, i32 575, i64 32, i64 32, i64 32, i32 0, metadata !7} ; [ DW_TAG_member ]
!19 = metadata !{i32 589837, metadata !14, metadata !"len", metadata !13, i32 576, i64 32, i64 32, i64 64, i32 0, metadata !20} ; [ DW_TAG_member ]
!20 = metadata !{i32 589860, metadata !3, metadata !"unsigned int", metadata !3, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ]
!21 = metadata !{i32 589837, metadata !14, metadata !"sysp", metadata !13, i32 580, i64 8, i64 8, i64 96, i32 0, metadata !22} ; [ DW_TAG_member ]
!22 = metadata !{i32 589860, metadata !3, metadata !"unsigned char", metadata !3, i32 0, i64 8, i64 8, i64 0, i32 0, i32 8} ; [ DW_TAG_base_type ]
!23 = metadata !{i32 589837, metadata !14, metadata !"name_map", metadata !13, i32 584, i64 32, i64 32, i64 128, i32 0, metadata !24} ; [ DW_TAG_member ]
!24 = metadata !{i32 589839, metadata !3, metadata !"", metadata !3, i32 0, i64 32, i64 32, i64 0, i32 0, metadata !9} ; [ DW_TAG_pointer_type ]
!25 = metadata !{i32 589837, metadata !14, metadata !"header_map", metadata !13, i32 590, i64 32, i64 32, i64 160, i32 0, metadata !26} ; [ DW_TAG_member ]
!26 = metadata !{i32 589839, metadata !3, metadata !"", metadata !3, i32 0, i64 32, i64 32, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ]
!27 = metadata !{i32 589837, metadata !14, metadata !"construct", metadata !13, i32 597, i64 32, i64 32, i64 192, i32 0, metadata !28} ; [ DW_TAG_member ]
!28 = metadata !{i32 589839, metadata !3, metadata !"", metadata !3, i32 0, i64 32, i64 32, i64 0, i32 0, metadata !5} ; [ DW_TAG_pointer_type ]
!29 = metadata !{i32 589837, metadata !14, metadata !"ino", metadata !13, i32 601, i64 64, i64 64, i64 224, i32 0, metadata !30} ; [ DW_TAG_member ]
!30 = metadata !{i32 589846, metadata !31, metadata !"ino_t", metadata !31, i32 141, i64 0, i64 0, i64 0, i32 0, metadata !32} ; [ DW_TAG_typedef ]
!31 = metadata !{i32 589865, metadata !"types.h", metadata !"/usr/include/sys", metadata !4} ; [ DW_TAG_file_type ]
!32 = metadata !{i32 589860, metadata !3, metadata !"long long unsigned int", metadata !3, i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ]
!33 = metadata !{i32 589837, metadata !14, metadata !"dev", metadata !13, i32 602, i64 32, i64 32, i64 288, i32 0, metadata !34} ; [ DW_TAG_member ]
!34 = metadata !{i32 589846, metadata !31, metadata !"dev_t", metadata !31, i32 107, i64 0, i64 0, i64 0, i32 0, metadata !35} ; [ DW_TAG_typedef ]
!35 = metadata !{i32 589860, metadata !3, metadata !"int", metadata !3, i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ]
!36 = metadata !{i32 589837, metadata !14, metadata !"user_supplied_p", metadata !13, i32 605, i64 8, i64 8, i64 320, i32 0, metadata !37} ; [ DW_TAG_member ]
!37 = metadata !{i32 589860, metadata !3, metadata !"_Bool", metadata !3, i32 0, i64 8, i64 8, i64 0, i32 0, i32 2} ; [ DW_TAG_base_type ]
!38 = metadata !{i32 589846, metadata !39, metadata !"size_t", metadata !39, i32 326, i64 0, i64 0, i64 0, i32 0, metadata !40} ; [ DW_TAG_typedef ]
!39 = metadata !{i32 589865, metadata !"stddef.h", metadata !"/Users/espindola/llvm/build-llvm-gcc/./prev-gcc/include", metadata !4} ; [ DW_TAG_file_type ]
!40 = metadata !{i32 589860, metadata !3, metadata !"long unsigned int", metadata !3, i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ]
