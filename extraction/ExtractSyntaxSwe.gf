concrete ExtractSyntaxSwe of ExtractSyntax =
  StructuralSwe **
    ExtractSyntaxFunctor - [pmkV2, prefixCN, CompoundN] with
      (Syntax=SyntaxSwe),
      (Symbolic=SymbolicSwe),
      (Extend=ExtendSwe) **
      open (P=ParadigmsSwe), ResSwe in {

  oper
    pmkV2 : V -> V2 = P.mkV2 ;
    prefixCN : Str -> CN -> CN = \s, cn ->
      cn ** {s = \\n, c => s ++ cn.s ! n ! c} ;
  lin
    CompoundN noun cn = {
      s = \\n,c => noun.s ! Sg ! Nom ++ cn.s ! n ! c ;
      g = cn.g
  } ;

 }
