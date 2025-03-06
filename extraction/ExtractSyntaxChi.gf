concrete ExtractSyntaxChi of ExtractSyntax =
  StructuralChi **
    ExtractSyntaxFunctor - [pmkV2, prefixCN, PNCommaPN, AAdAP] with
      (Syntax=SyntaxChi),
      (Symbolic=SymbolicChi),
      (Extend=ExtendChi) **
    open
      (P=ParadigmsChi)
    in {

   lin
     PNCommaPN thessaloniki greece = thessaloniki ** {
       s = thessaloniki.s ++ bindComma ++ (mkUtt (mkNP greece)).s
      } ;

     AAdAP a ap = mkAP (lin AdA {s = (SyntaxChi.mkAdv a).s}) ap ;
   oper
     pmkV2 : V -> V2 = P.mkV2 ;
     prefixCN : Str -> CN -> CN = \s, cn ->
        cn ** {s = s ++ cn.s} ;

     }
