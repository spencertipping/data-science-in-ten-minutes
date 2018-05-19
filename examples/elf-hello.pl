# elf-hello.pl: emit machine code for hello world, then exit successfully
use strict;
use warnings;
print pack('H*', join '',
  '4831c0',                             # xorq %rax, %rax
  'b001',                               # movb $01, %al (1 = write syscall)
  'e80c000000',                         # call %rip+12 (jump over the message)
  unpack('H*', "hello world\n"),        # the message
  '5e',                                 # pop message into %rsi (buf arg)
  'ba0c000000',                         # movl $12, %rdx (len arg)
  '48c7c701000000',                     # movl $1, %rdi (fd arg)
  '0f05',                               # syscall instruction

  '4831c0',                             # xorq %rax, %rax
  'b03c',                               # movb $3c, %rax (3c = exit syscall)
  '4831ff',                             # xorq %rdi, %rdi (exit code arg)
  '0f05');                              # syscall instruction
