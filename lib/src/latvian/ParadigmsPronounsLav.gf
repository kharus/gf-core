--# -path=.:../abstract:../common:../prelude

resource ParadigmsPronounsLav = open
  (Predef=Predef),
  Prelude,
  ResLav,
  CatLav
  in {

flags
  coding = utf8;

oper
  PronGend : Type = {s : Gender => Number => Case => Str} ;

-- PRONOUNS (incl. 'determiners')

  -- Gender=>Number=>Case P3 pronouns
  -- Expected ending of a lemma: -s or -š (Masc=>Sg=>Nom)
  -- Examples:
  --   viņš (he/she)
  --   kāds (a/some)
  --   katrs, ikviens, jebkurš (every/everything/everyone/all)
  --   neviens (no/nothing/noone)
  --   viss (all)
  --   kurš (that-relative)
  mkPronoun_Gend : Str -> PronGend = \lemma ->
    let stem : Str = Predef.tk 1 lemma
    in {
      s = table {
        Masc => table {
          Sg => table {
            Nom => lemma ;
            Gen => stem + "a" ;
            Dat => stem + "am" ;
            Acc => stem + "u" ;
            Loc => stem + "ā" ;
			Voc => NON_EXISTENT --FIXME - var tak uzrunā arī likt determineru
          } ;
          Pl => table {
            Nom => stem + "i" ;
            Gen => stem + "u" ;
            Dat => stem + "iem" ;
            Acc => stem + "us" ;
            Loc => stem + "os" ;
			Voc => NON_EXISTENT
          }
        } ;
        Fem => table {
          Sg => table {
            Nom => stem + "a" ;
            Gen => stem + "as" ;
            Dat => stem + "ai" ;
            Acc => stem + "u" ;
            Loc => stem + "ā" ;
			Voc => NON_EXISTENT
          } ;
          Pl => table {
            Nom => stem + "as" ;
            Gen => stem + "u" ;
            Dat => stem + "ām" ;
            Acc => stem + "as" ;
            Loc => stem + "ās" ;
			Voc => NON_EXISTENT
          }
        }
      } ;
    } ;

  -- A special case (paradigm) of Gender=>Number=>Case P3 pronouns
  -- Returns the full paradigm of 'šis' (this) or 'tas' (that)
  mkPronoun_ThisThat : ThisOrThat -> PronGend = \tot ->
    let
      stem  : Str = case tot of {This => "š" ; That => "t"} ;
      suff1 : Str = case tot of {This => "i" ; That => "a"} ;
      suff2 : Str = case tot of {This => "ī" ; That => "ā"}
    in {
      s = table {
        Masc => table {
          Sg => table {
            Nom => stem + suff1 + "s" ;
            Gen => stem + suff2 ;
            Dat => stem + suff1 + "m" ;
            Acc => stem + "o" ;
            Loc => stem + "ajā" ;
			Voc => NON_EXISTENT
          } ;
          Pl => table {
            Nom => stem + "ie" ;
            Gen => stem + "o" ;
            Dat => stem + "iem" ;
            Acc => stem + "os" ;
            Loc => stem + "ajos" ;
			Voc => NON_EXISTENT
          }
        } ;
        Fem => table {
          Sg => table {
            Nom => stem + suff2 ;
            Gen => stem + suff2 + "s" ;
            Dat => stem + "ai" ;
            Acc => stem + "o" ;
            Loc => stem + "ajā" ;
			Voc => NON_EXISTENT
          } ;
          Pl => table {
            Nom => stem + suff2 + "s" ;
            Gen => stem + "o" ;
            Dat => stem + suff2 + "m" ;
            Acc => stem + suff2 + "s" ;
            Loc => stem + "ajās" ;
			Voc => NON_EXISTENT
          }
        }
      } ;
    } ;

} ;
