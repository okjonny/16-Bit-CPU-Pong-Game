ANDI $0 %r0 
ANDI $0 %r1 
ANDI $0 %r2 
ADDI $127 %r2 
ADDI $112 %r2 
ANDI $0 %r3 
ANDI $0 %r14 
ANDI $0 %r3 
ADDI $127 %r3 
JPT .notRight %r0 
CMP %r15 %r3 
JNE %r0 
ANDI $0 %r14 
ADDI $1 %r14 
ANDI $0 %r14 
ADDI $0 %r14 
JPT .routineLoop %r0 
JUC %r0 
