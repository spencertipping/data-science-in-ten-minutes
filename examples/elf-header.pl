# elf-header.pl: emit an ELF binary and program header to stdout
use strict;
use warnings;

print pack('C16 SSL',
           0x7f, ord 'E', ord 'L', ord 'F',
           2, 1, 1, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,

           2,                           # e_type    = ET_EXEC
           62,                          # e_machine = EM_X86_64
           1)                           # e_version = EV_CURRENT

    . pack('QQQ',
           0x400078,                    # e_entry = 0x400078
           64,                          # e_phoff
           0)                           # e_shoff

    . pack('LSS SSSS',
           0,                           # e_flags
           64,                          # e_ehsize
           56,                          # e_phentsize
           1,                           # e_phnum

           0,                           # e_shentsize
           0,                           # e_shnum
           0)                           # e_shstrndx

    . pack('LLQQQQQQ',
           1,                           # p_type = PT_LOAD (map a region)
           7,                           # p_flags = R|W|X
           0,                           # p_offset (must be page-aligned)
           0x400000,                    # p_vaddr
           0,                           # p_paddr
           0x1000,                      # p_filesz: 4KB
           0x1000,                      # p_memsz: 4KB
           0x1000);                     # p_align: 4KB
