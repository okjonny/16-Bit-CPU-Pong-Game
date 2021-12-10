ANDI $0 %r0 
ANDI $0 %r1 
ANDI $0 %r2 
ADDI $127 %r2 
ADDI $112 %r2 
ANDI $0 %r3 
ANDI $0 %r14 
JPT .routineLoop %r0 
JUC %r0 
JPT .left %r1 
ANDI $0 %r3 
ADDI $127 %r3 
ADDI $64 %r3 
CMP %r15 %r3 
JEQ %r1 
JPT .right %r1 
ANDI $0 %r3 
ADDI $127 %r3 
CMP %r15 %r3 
JEQ %r1 
ADDI $1 %r2 
JPT .routineLoop %r0 
JUC %r0 
SUBI $1 %r2 
JPT .routineLoop %r0 
JUC %r0 
