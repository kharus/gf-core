incomplete concrete AdverbRomance of Adverb = 
  CatRomance ** open CommonRomance, ResRomance, Prelude in {

  lin
    PositAdvAdj a = {
      s = a.s ! Posit ! AA
      } ;
    ComparAdvAdj cadv a np = {
      s = cadv.s ++ a.s ! Posit ! AA ++ conjThan ++ (np.s ! Nom).ton 
      } ;
    ComparAdvAdjS cadv a s = {
      s = cadv.s ++ a.s ! Posit ! AA ++ conjThan ++ s.s ! Conjunct --- ne
      } ;

    PrepNP prep np = {s = prep.s ++ (np.s ! prep.c).ton} ;

    AdAdv = cc2 ;

    SubjS subj s = {
      s = subj.s ++ s.s ! subj.m
      }  ;

    AdnCAdv cadv = {s = cadv.s ++ conjThan} ;

}
