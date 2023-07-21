# Save history across sessions.
set history save on
set history filename ~/.gdb/history
set history size 1000

# Pwndbg
define init-pwn
source ~/.gdb/plugins/pwn/gdbinit.py
end
document init-pwn
Initializes PwnDBG
end

# GEF
define init-gef
source ~/.gdb/plugins/gef/gef.py
end
document init-gef
Initializes GEF
end
