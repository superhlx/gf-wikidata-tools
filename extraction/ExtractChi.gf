--# -path=.:morphodict

-- make a symlink to morphodict

concrete ExtractChi of ExtractChiAbs =
  MorphoDictChi,
  UniversityWordsChi,
  ExtractSyntaxChi
  ;

