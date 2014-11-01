Definitions.

A = [Aa]
B = [Bb]
C = [Cc]
D = [Dd]
E = [Ee]
F = [Ff]
G = [Gg]
H = [Hh]
I = [Ii]
J = [Jj]
K = [Kk]
L = [Ll]
M = [Mm]
N = [Nn]
O = [Oo]
P = [Pp]
Q = [Qq]
R = [Rr]
S = [Ss]
T = [Tt]
U = [Uu]
V = [Vv]
W = [Ww]
X = [Xx]
Y = [Yy]
Z = [Zz]

NUM  = [0-9]
CHAR = [a-zA-Z]
ANY  = [0-9a-zA-Z]
STAR = [*]
WS   = [\000-\s]
OP   = (<|<=|=|!=|=>|>)

Rules.

{S}{E}{L}{E}{C}{T}    : {token, {select,      TokenLine}}.
{U}{P}{D}{A}{T}{E}    : {token, {update,      TokenLine}}.
{I}{N}{S}{E}{R}{T}    : {token, {insert,      TokenLine}}.
{D}{E}{L}{E}{T}{E}    : {token, {delete,      TokenLine}}.
{F}{R}{O}{M}          : {token, {from,        TokenLine}}.
{W}{H}{E}{R}{E}       : {token, {where,       TokenLine}}.
{O}{R}{D}{E}{R}       : {token, {order,       TokenLine}}.
{G}{R}{O}{U}{P}       : {token, {group,       TokenLine}}.
{I}{N}{N}{E}{R}       : {token, {inner,       TokenLine}}.
{O}{U}{T}{E}{R}       : {token, {outer,       TokenLine}}.
{J}{O}{I}{N}          : {token, {join,        TokenLine}}.
{I}{N}{T}{O}          : {token, {into,        TokenLine}}.
{S}{E}{T}             : {token, {set,         TokenLine}}.
{D}{E}{S}{C}          : {token, {desc,        TokenLine}}.
{A}{S}{C}             : {token, {asc,         TokenLine}}.
{B}{Y}                : {token, {by,          TokenLine}}.
{O}{R}                : {token, {atom('or'),  TokenLine}}.
{A}{N}{D}             : {token, {atom('and'), TokenLine}}.
{I}{N}                : {token, {in,          TokenLine}}.
{T}{R}{U}{E}          : {token, {bool,        TokenLine, true}}.
{F}{A}{L}{S}{E}       : {token, {bool,        TokenLine, false}}.
{N}{U}{L}{L}          : {token, {null,        TokenLine}}.
{CHAR}({ANY}|\.)*     : {token, {var,         TokenLine, TokenChars}}.
'{ANY}*'              : {token, {string,      TokenLine, strip(TokenChars, TokenLen)}}.
"{ANY}*"              : {token, {string,      TokenLine, strip(TokenChars, TokenLen)}}.
{NUM}+\.{NUM}+((E|e)(\+|\-)?{NUM}+)? : {token, {float, TokenLen, list_to_float(TokenChars)}}.
{NUM}+                : {token, {integer,     TokenLine, list_to_integer(TokenChars)}}.
[(),\[\]{}:]          : {token, {atom(TokenChars), TokenLine}}.
{OP}                  : {token, {op,          TokenLine, atom(TokenChars)}}.
{STAR}                : {token, {all,         TokenLine}}.
{WS}+                 : skip_token.

Erlang code.

atom(Chars) when is_atom(Chars) -> Chars;
atom(Chars) -> list_to_atom(Chars).

strip(TokenChars,TokenLen) ->
    lists:sublist(TokenChars, 2, TokenLen - 2).
