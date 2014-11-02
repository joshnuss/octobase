Nonterminals
command select_command update_command insert_command delete_command
where_clause order_clause order_list order_expression shape
predicates predicate list dict keypairs keypair literal expressions expression.

Terminals '(' ')' ',' '[' ']' '{' '}' ':' '='
select update insert delete from where order by group inner outer join set into
bool null string float integer var and or all op in asc desc.

Rootsymbol command.

command -> select_command : '$1'.
command -> insert_command : '$1'.
command -> update_command : '$1'.
command -> delete_command : '$1'.

select_command -> select shape from var where_clause order_clause : {select, '$2', unwrap('$4'), '$5', '$6'}.
insert_command -> insert into var dict: {insert, unwrap('$3'), '$4'}.
update_command -> update var set dict where_clause: {update, unwrap('$2'), '$4', '$5'}.
delete_command -> delete from var where_clause : {delete, unwrap('$3'), '$4'}.

shape -> all : all.
shape -> dict : '$1'.
shape -> expressions : '$1'.

dict -> '{' keypairs '}' : maps:from_list('$2').

keypairs -> '$empty' : [].
keypairs -> keypair : ['$1'].
keypairs -> keypairs ',' keypair : '$1' ++ ['$3'].

keypair -> string ':' expression : {unwrap('$1'), '$3'}.
keypair -> var ':' expression : {unwrap('$1'), '$3'}.
keypair -> var ':' dict : {unwrap('$1'), '$3'}.

where_clause -> '$empty' : {}.
where_clause -> where predicates : '$2'.

order_clause -> '$empty' : [].
order_clause -> order by order_list : '$3'.

order_list -> order_list ',' order_expression : '$1' ++ ['$3'].
order_list -> order_expression : ['$1'].

order_expression -> expression : {'$1', asc}.
order_expression -> expression desc : {'$1', desc}.
order_expression -> expression asc : {'$1', asc}.

predicates -> predicate : '$1'.
predicates -> predicate and predicate : {atom('and'), '$1', '$3'}.
predicates -> predicates and predicate : {atom('and'), '$1', '$3'}.
predicates -> predicate or predicate : {atom('or'), '$1', '$3'}.
predicates -> predicates or predicate : {atom('or'), '$1', '$3'}.

predicate -> var op var : {unwrap('$2'), {var, unwrap('$1')}, {var, unwrap('$3')}}.
predicate -> literal op var : {unwrap('$2'), '$1', {var, unwrap('$3')}}.
predicate -> var op literal : {unwrap('$2'), {var, unwrap('$1')}, '$3'}.
predicate -> literal op literal : {unwrap('$2'), '$1', '$3'}.

expressions -> expressions ',' expression : '$1' ++ ['$3'].
expressions -> expression : ['$1'].

expression -> var : unwrap('$1').
expression -> literal : '$1'.

literal -> string : unwrap('$1').
literal -> float : unwrap('$1').
literal -> integer : unwrap('$1').
literal -> bool : unwrap('$1').
literal -> null : null.

Erlang code.

atom(Chars) when is_atom(Chars) -> Chars;
atom(Chars) -> list_to_atom(Chars).

unwrap({_,Value}) -> Value;
unwrap({_,_,Value}) -> Value.
