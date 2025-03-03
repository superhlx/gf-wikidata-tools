concrete ExtractSyntaxEng of ExtractSyntax =
  StructuralEng **
    ExtractSyntaxFunctor - [pmkV2, prefixCN, CompoundN] with
      (Syntax=SyntaxEng),
      (Symbolic=SymbolicEng),
      (Extend=ExtendEng) **
      open (P=ParadigmsEng), ResEng in {

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
